<?php

use App\Middleware\AuthMiddleware;


//Rota inicial

$router->get('/', 'IndexController', 'index');
$router->get('/cadastro', 'IndexController', 'cadastro');
$router->post('/login', 'AuthController', 'login');
$router->post('/cadastrar', 'IndexController', 'cadastrar');


$router->notFound(function(){
    include '../App/views/not-found/not-found.tpl';
});

/**
 * Agrupamento de rotas, com middleware
 */
$router->group('/sigo', function($router) {
    $router->get('/dashboard', 'DashboardController', 'index');
    $router->get('/cadastro/atualizar', 'UserController', 'atualizar');
    $router->get('/cliente/cadastro', 'ClientController', 'cadastro');
    $router->post('/cliente/cadastrar', 'ClientController', 'cadastrar');
},[AuthMiddleware::class]);

