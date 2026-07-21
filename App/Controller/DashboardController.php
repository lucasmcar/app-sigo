<?php

namespace App\Controller;

use Core\View\View;
use IntlDateFormatter;
use DateTime;

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

        $data = [
            'atual' => $atual
        ];

        // Lógica para exibir o dashboard
        $styles = ['/assets/css/dashboard.css'];
        return new View(view: 'admin/dashboard', vars: $data, styles: $styles);
    }
}