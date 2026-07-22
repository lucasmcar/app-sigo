<?php 

namespace App\Controller;

use Core\View\View;
use Core\Security\Jwt\JwtHandler;
use App\Repository\ClientRepository;
use App\Repository\UserRepository;
use Core\Security\Csrf;
use App\Helper\InputFilterHelper;
class ClientController
{
    public function cadastro()
    {

        $data = [];
        if (session_id()) {
            $data = JwtHandler::validateToken($_SESSION['jwt']);
        }

        $userRepository = new UserRepository();

        // Obter dados do usuário logado
        $userResult = $userRepository->getWhere('id', '=', $data['sub']);

        $data = [
            'company_id' => $userResult[0]['id'],
        ];

        $styles = ['/assets/css/dashboard.css',];
        $scripts = ['/assets/js/cadastro-cliente.js'];
        return new View(view: 'admin/cadastro-cliente', vars: $data, styles: $styles, scripts: $scripts);
    }

    public function cadastrar()
    {
        // Lógica para cadastrar o cliente
        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'company_id',
            'name',
            'person_type',
            'cpf',
            'cnpj',
            'birth_date',
            'phone',
            'whatsapp',
            'email',
            'cep',
            'street',
            'number',
            'complement',
            'district',
            'city',
            'state',
            'notes',
            '_csrf_token'
        ]);

        // Verifica o token CSRF
        if (!Csrf::verifyToken($data['_csrf_token'])) {
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => 'Token CSRF inválido.']);
            return;
        }

        /*foreach ($data as $key => $value) {
            if (empty($value)) {
                echo json_encode(
                    [
                        'success' => false, 
                        'message' => "O campo {$key} é obrigatório."
                    ]
                );
                return;
            }
        }*/
        unset($data['_csrf_token']);

        $clientRepository = new ClientRepository();
        try {
            $id = $clientRepository->create($data);

            if ($id) {

                http_response_code(201);
                header('Content-Type: application/json');

                echo json_encode([
                    'success' => true,
                    'message' => 'Cliente cadastrado com sucesso!',
                    'redirect' => '/sigo/dashboard'
                ]);

                exit;
            }

            http_response_code(400);

            echo json_encode([
                'success' => false,
                'message' => 'Erro ao cadastrar.'
            ]);

            exit;

        } catch (\Exception $e) {
            http_response_code(500);
            echo json_encode(
                [
                    'success' => false, 
                    'error_message' => $e->getMessage(),
                    'message' => 'Erro ao cadastrar cliente'
                ]
            );
            return;
        }
    }
}