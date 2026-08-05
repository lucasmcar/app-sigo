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
    //Cliente
    $router->get('/cliente/cadastro', 'ClientController', 'cadastro');
    $router->post('/cliente/cadastrar', 'ClientController', 'cadastrar');
    $router->get('/clientes/todos', 'ClientController', 'buscarTodos');
    $router->get('/cliente/listar', 'ClientController', 'listarPor');
    $router->post('/clientes/buscar', 'ClientController', 'buscar');
    //Veiculo
    $router->get('/veiculo/cadastro', 'VehicleController', 'cadastro');
    $router->post('/veiculos/buscar', 'VehicleController', 'buscarVeiculo');
    $router->post('/veiculo/cadastrar', 'VehicleController', 'cadastrar');
    //Ordem de serviço
    $router->get('/os/cadastro', 'ServiceOrderController', 'cadastroServiceOrder');
    $router->post('/os/cadastrar', 'ServiceOrderController', 'cadastrar');
    $router->get('/os/{id}', 'ServiceOrderController', 'buscaOS');
    
},[AuthMiddleware::class]);

