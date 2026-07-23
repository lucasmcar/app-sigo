<?php 

namespace App\Controller;

use Core\View\View;
use Core\Security\Jwt\JwtHandler;
use Core\Security\Csrf;
use App\Helper\InputFilterHelper;
use App\Repository\VehicleRepository;

class VehicleController
{
    public function cadastro()
    {
        $styles = ['/assets/css/dashboard.css',];
        $scripts = ['/assets/js/cadastro-veiculo.js'];
        return new View(view: 'admin/cadastro-veiculo', vars: [], styles: $styles, scripts: $scripts);
    }

    public function cadastrar()
    {
        $vehicleRepository = new VehicleRepository();

        $vehicleData = InputFilterHelper::filterInputs(INPUT_POST, [

            'customer_id',

            'plate',
            'renavam',
            'chassis',

            'brand',
            'model',
            'version',

            'manufacture_year',
            'model_year',

            'color',
            'fuel',
            'transmission',

            'mileage',

            'engine',

            'notes'
        ]);

        $required = [

            'customer_id',
            'plate',
            'brand',
            'model'

        ];

        foreach ($required as $field) {

            if (empty($vehicleData[$field])) {

                http_response_code(400);

                echo json_encode([
                    'success' => false,
                    'message' => "O campo {$field} é obrigatório."
                ]);

                return;
            }

        }

        $vehicleData['plate'] = strtoupper(
            preg_replace('/[^A-Za-z0-9]/', '', $vehicleData['plate'])
        );

        try {

            $id = $vehicleRepository->create($vehicleData);

            if ($id) {

                http_response_code(201);

                echo json_encode([

                    'success' => true,
                    'message' => 'Veículo cadastrado com sucesso.',
                    'redirect' => '/sigo/dashboard',
                    'id' => $id

                ]);

                return;

            }

            http_response_code(400);

            echo json_encode([
                'success' => false,
                'message' => 'Não foi possível cadastrar o veículo.'
            ]);

        } catch (\PDOException $e) {

            if ($e->getCode() == 23000) {

                http_response_code(409);

                echo json_encode([
                    'success' => false,
                    'message' => 'Já existe um veículo cadastrado com esta placa.'
                ]);

                return;
            }

            http_response_code(500);

            echo json_encode([
                'success' => false,
                'message' => 'Erro interno.',
                'error_message' => $e->getMessage()
            ]);

        }
}
}