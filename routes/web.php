<?php

use App\Middleware\AuthMiddleware;

$router->get('/', 'ExampleController', 'index');
$router->get('/admin', 'ExampleController', 'admin');

//Rota inicial

$router->get('/login', 'IndexController', 'index');
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
},[AuthMiddleware::class]);

