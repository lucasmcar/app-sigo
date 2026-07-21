<?php 

namespace App\Controller;

use Core\View\View;
use App\Helper\InputFilterHelper;
use App\Repository\UserRepository;

class IndexController
{
    public function index()
    {
        $styles = ['/assets/css/login.css'];
        $scripts = ['/assets/js/login.js'];
        
        return new View(view: 'admin/login', vars: [], styles: $styles, scripts: $scripts);
    }

    public function cadastro()
    {
        $styles = ['/assets/css/cadastro.css'];
        $scripts = ['/assets/js/cadastro.js'];
        return new View(view: 'admin/cadastro', vars: [], styles: $styles, scripts: $scripts);
    }

    public function cadastrar()
    {

        $userRepository = new UserRepository();
        //Receber dados do formulário
        $userData = InputFilterHelper::filterInputs(INPUT_POST, [
            'company_name',
            'cnpj',
            '_csrf_token',
            'phone',
            'email',
            'username',
            'password',
            'password_confirmation'
        ]);

        //Tratar e validar os dados recebidos
        if (!$this->validatePasswords($userData['password'], $userData['password_confirmation'])) {
            // As senhas não coincidem
            echo json_encode(['success' => false, 'message' => 'As senhas não coincidem.']);
            return;
        }

        foreach ($userData as $key => $value) {
            if (empty($value)) {
                echo json_encode(
                    [
                        'success' => false, 
                        'message' => "O campo {$key} é obrigatório."
                    ]
                );
                return;
            }
        }
        unset($userData['_csrf_token']);
        unset($userData['password_confirmation']);

        $userData['password'] = password_hash(
            $userData['password'],
            PASSWORD_DEFAULT
        );

        //Se tudo estiver correto, criar o usuário
        try {
            $id = $userRepository->create($userData);

            if ($id) {

                http_response_code(201);
                header('Content-Type: application/json');

                echo json_encode([
                    'success' => true,
                    'message' => 'Cadastro realizado com sucesso!',
                    'redirect' => '/login'
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
                    'message' => 'Erro ao cadastrar usuário'
                ]
            );
            return;
        }

    }

    private function validatePasswords(string $password, string $passwordConfirmation) : bool
    {
        if ($password !== $passwordConfirmation) {
            // As senhas não coincidem
            return false;
        }
        return true;
    }
}