<?php

namespace App\Controller;

use App\Repository\UserRepository;
use Core\View\View;
use Core\Security\Jwt\JwtHandler;

class UserController
{
    public function atualizar()
    {
        $data = [];
        if (session_id()) {
            $data = JwtHandler::validateToken($_SESSION['jwt']);
        }

        $userRepository = new UserRepository();

        // Obter dados do usuário logado
        $userResult = $userRepository->findForSign($data['name']);
        /*if (!$userResult || empty($userResult)) {
            return new View('admin/perfil', ['title' => 'Perfil Administrativo'], [], [], 'admin-layout');
        }*/
       

        $data = [
            'user' => $userResult[0]['username'],
            'email' => $userResult[0]['email'],
            'company_name' => $userResult[0]['company_name'],
            'cnpj' => $userResult[0]['cnpj'],
            'phone' => $userResult[0]['phone'], 
        ];



        $styles = ['/assets/css/cadastro.css'];
        $scripts = ['/assets/js/cadastro.js'];
        return new View(view: 'admin/atualizar', vars: $data, styles: $styles, scripts: $scripts);
    }
}