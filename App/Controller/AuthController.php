<?php

namespace App\Controller;

use App\Helper\InputFilterHelper;
use Core\Security\Jwt\JwtHandler;
use Core\Security\Csrf;
use App\Repository\UserRepository;
use Core\DeviceDetector;

class AuthController
{
    public function login()
    {

        $user = new UserRepository();

        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'username',
            'password',
            '_csrf_token'
        ]);

        // Verifica o token CSRF
        if (!Csrf::verifyToken($data['_csrf_token'])) {
            http_response_code(400);
            echo json_encode(['success' => false, 'message' => 'Token CSRF inválido.']);
            return;
        }

        $usuario =  $user->findForSign($data['username']);

        if(empty($usuario)){
            http_response_code(404);
            echo json_encode(
                [
                    'success' => false, 
                    'message' => 'Usuário não cadastrado', 
                    'redirect' => '/login'
                ]
            );
            exit;
        }

        

        $payload = [
            'iat' => time(),
            'exp' => time() + (60 * 60), // 1 hora
            'sub' => $usuario[0]['id'],
            'name' => $usuario[0]['username'],
            'email' => $usuario[0]['email']
        ];

        $jwt = JwtHandler::generateToken($payload);

        
        if (!session_id()) {
            session_start();
        }

        $_SESSION['jwt'] = $jwt;
        $_SESSION['jwt_exp'] = $payload['exp'];
        $_SESSION['username'] = $usuario[0]['username'];
        $_SESSION['user_id'] = $usuario[0]['id'];
        
        
        $user->updateLastLogin($usuario[0]['id'], date('Y-m-d H:i:s'));

        // Atualiza login
        //$userRepository->updateLastLogin($user[0]['id'], date('Y-m-d H:i:s'));
    
        echo json_encode([
            'success' => true,
            'message' => 'Login realizado com sucesso!',
            'token' => $jwt,
            'user' => [
                'id' => $usuario[0]['id'],
                'nome' => $usuario[0]['username'],
                'email' => $usuario[0]['email'],
            ],
            'redirect' => '/sigo/dashboard'
        ]);
        
  

        
        exit();
    }
}