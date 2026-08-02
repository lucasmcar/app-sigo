<?php

namespace App\Controller;

use Core\View\View;
use IntlDateFormatter;
use DateTime;
use App\Repository\UserRepository;
use Core\Security\Jwt\JwtHandler;

class DashboardController
{
    public function index()
    {
        
        $formatter = new IntlDateFormatter(
            'pt_BR',
            IntlDateFormatter::FULL, // Para exibir o dia da semana completo
            IntlDateFormatter::NONE,
            'America/Sao_Paulo',
            IntlDateFormatter::GREGORIAN
        );

        // Pega a data de hoje dinamicamente
        $dataAtual = new DateTime();
        $atual = $formatter->format($dataAtual); 


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
            'atual' => $atual,
            'company_name' => $userResult[0]['company_name'],
        ];

        // Lógica para exibir o dashboard
        $styles = ['/assets/css/dashboard.css'];
        return new View(view: 'admin/dashboard', vars: $data, styles: $styles);
    }
}