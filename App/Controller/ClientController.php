<?php 

namespace App\Controller;

use Core\View\View;
use Core\Security\Jwt\JwtHandler;
use App\Repository\ClientRepository;
use App\Model\Client;
use App\Repository\UserRepository;
use Core\Security\Csrf;
use App\Helper\InputFilterHelper;
use Svg\Style;

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

    public function buscar()
    {
        $data = InputFilterHelper::filterInputs(INPUT_POST, [
            'document',
            '_csrf_token'
        ]);

        //$document = preg_replace('/\D/', '', $data['document']);

        $client= new Client();

        $client = $client
            ->where('cpf', '=', $data['document'])
            ->orWhere('cnpj', '=', $data['document'])
            ->get();

        if (!empty($client)) {

            http_response_code(200);

            echo json_encode([
                'success' => true,
                'message' => 'Cliente encontrado.',
                'customer' => $client[0]
            ]);

            exit;
        }

        http_response_code(404);

        echo json_encode([
            'success' => false,
            'message' => 'Cliente não encontrado.'
        ]);
    }

    public function buscarTodos()
    {
        $styles = ['/assets/css/dashboard.css'];
        $scripts = ['/assets/js/busca-cliente.js'];
        return new View(view: 'admin/lista-clientes', vars: [], styles: $styles, scripts: $scripts);
    }

    public function listarPor($params = [])
    {
        $rawQ = $params['search'] ?? $_GET['search'] ?? '';

        $q = trim(filter_var(
            $rawQ,
            FILTER_UNSAFE_RAW,
            FILTER_FLAG_STRIP_LOW
        ));

        $clientRepository = new ClientRepository();

        if(empty($q)){
            $clientes = $clientRepository->all();  
        
        } else {
            $clientes = $clientRepository->buscarPorNomeOuDocumento($q);
        }

        

        http_response_code(200);

        echo json_encode($clientes);
    }
}