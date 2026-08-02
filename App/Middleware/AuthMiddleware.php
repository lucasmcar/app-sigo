<?php
namespace App\Middleware;

use Core\Security\Jwt\JwtHandler;
use Core\Security\Csrf;

class AuthMiddleware
{
    public function handle($request, $next)
    {
        // Inicia a sessão se não estiver ativa
        if (!session_id()) {
            session_start();
        }

        // Pega o token da sessão
        $jwt = $_SESSION['jwt'] ?? null;

        if (!$jwt) {
            $this->unauthorized('Sessão não autenticada.');
        }

        // Valida o token usando JwtHandler
        try {
            $decoded = JwtHandler::validateToken($jwt);
        } catch (\Throwable $e) {
            $decoded = null;
        }

        // Cobre null, false, array vazio, ou payload sem o campo esperado
        if (empty($decoded) || !isset($decoded['sub'])) {
            unset($_SESSION['jwt']);
            $this->unauthorized('Sessão expirada. Faça login novamente.');
        }

        // Defesa extra: valida expiração mesmo se validateToken já checar,
        // caso ele confie apenas na assinatura e não no campo 'exp'.
        if (isset($decoded['exp']) && $decoded['exp'] < time()) {
            unset($_SESSION['jwt']);
            $this->unauthorized('Sessão expirada. Faça login novamente.');
        }

        // Adiciona os dados do usuário ao request
        $request['user'] = $decoded;

        // Verifica CSRF para métodos POST, PUT, DELETE
        if (in_array($_SERVER['REQUEST_METHOD'], ['POST', 'PUT', 'DELETE'])) {

            $headers = getallheaders();
            $csrfToken = $headers['X-CSRF-TOKEN'] ?? '';

            if (!Csrf::verifyToken($csrfToken)) {
                if ($this->isAjaxRequest()) {
                    http_response_code(403);
                    echo json_encode([
                        'success' => false,
                        'message' => 'Forbidden - Invalid CSRF token'
                    ]);
                } else {
                    http_response_code(403);
                    echo 'Forbidden - Invalid CSRF token';
                }
                exit;
            }
        }

        return $next($request);
    }

    /**
     * Responde de forma diferente dependendo do tipo de requisição, e interrompe a execução.
     * - Requisição de página (navegação direta do navegador): redirect HTTP real.
     * - Requisição AJAX/fetch (JS): JSON, pra quem chama tratar via result.redirect.
     */
    private function unauthorized(string $message): void
    {
        if ($this->isAjaxRequest()) {
            http_response_code(401);
            echo json_encode([
                'success' => false,
                'message' => $message,
                'redirect' => '/'
            ]);
        } else {
            http_response_code(302);
            header('Location: /');
        }

        exit;
    }

    /**
     * Detecta se a requisição veio de fetch/XHR (JS) ou de navegação direta do navegador.
     * Baseado no header X-Requested-With que o service_order.js (e afins) já enviam.
     */
    private function isAjaxRequest(): bool
    {
        return isset($_SERVER['HTTP_X_REQUESTED_WITH'])
            && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest';
    }
}