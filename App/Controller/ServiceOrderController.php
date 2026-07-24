<?php


namespace App\Controller;

use Core\View\View;
use App\Helper\InputFilterHelper;
use App\Repository\VehicleRepository;
use App\Model\Vehicle;


class ServiceOrderController
{

    public function cadastroServiceOrder()
    {
        $scripts = ['/assets/js/cadastro-os.js'];
        $styles = ['/assets/css/dashboard.css'];

        return new View(view: 'admin/cadastro-os', vars: [], styles: $styles, scripts: $scripts);
    }


    /**
     * Cadastro da Ordem de Serviço
     */
    public function cadastrar()
    {

        $data = InputFilterHelper::filterInputs(INPUT_POST, [

            'vehicle_id',
            '_csrf_token',

            'complaint',
            'entry_mileage',

            'estimated_delivery',
            'status',

            'notes'

        ]);

        foreach ([
            'vehicle_id',
            'complaint',
            'entry_mileage',
            'status'
        ] as $field) {

            if (empty($data[$field])) {

                http_response_code(400);

                echo json_encode([
                    'success' => false,
                    'message' => "O campo {$field} é obrigatório."
                ]);

                return;

            }

        }

        unset($data['_csrf_token']);

        //$repository = new ServiceOrderRepository();

        try {

            $id = null;//$repository->create($data);

            if (!$id) {

                http_response_code(400);

                echo json_encode([
                    'success' => false,
                    'message' => 'Não foi possível criar a Ordem de Serviço.'
                ]);

                return;

            }

            http_response_code(201);

            echo json_encode([

                'success' => true,
                'message' => 'Ordem de Serviço criada com sucesso.',
                'redirect' => '/os'

            ]);

        } catch (\Exception $e) {

            http_response_code(500);

            echo json_encode([

                'success' => false,
                'message' => 'Erro interno.',
                'error_message' => $e->getMessage()

            ]);

        }
    }
}