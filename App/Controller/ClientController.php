<?php 

namespace App\Controller;

use Core\View\View;

class ClientController
{
    public function cadastro()
    {
        $styles = ['/assets/css/cadastro.css'];
        $scripts = ['/assets/js/cadastro-cliente.js'];
        return new View(view: 'admin/cadastro-cliente', vars: [], styles: $styles, scripts: $scripts);
    }
}