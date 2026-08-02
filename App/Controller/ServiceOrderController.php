<?php


namespace App\Controller;

use Core\View\View;
use App\Helper\InputFilterHelper;
use App\Repository\VehicleRepository;
use App\Repository\ServiceOrderRepository;
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

            'service_category',
            'priority',

            'estimated_delivery',
            'estimated_value',

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

        // Front manda ABERTA / EM_ANALISE, banco espera minúsculo (ENUM)
        $statusMap = [
            'ABERTA'     => 'aberta',
            'EM_ANALISE' => 'em_analise',
        ];

        if (!isset($statusMap[$data['status']])) {

            http_response_code(400);

            echo json_encode([
                'success' => false,
                'message' => 'Status inicial inválido.'
            ]);

            return;

        }

        $data['status'] = $statusMap[$data['status']];

        // Renomeia notes -> observations (nome da coluna na tabela)
        $data['observations'] = $data['notes'] ?? null;
        unset($data['notes']);

        $data['created_by'] = $_SESSION['user_id'] ?? null;

        if (!$data['created_by']) {

            http_response_code(401);

            echo json_encode([
                'success' => false,
                'message' => 'Sessão expirada. Faça login novamente.'
            ]);

            return;

        }

        $repository = new ServiceOrderRepository();

        try {

            $id = $repository->create($data);

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
                'redirect' => '/sigo/os/' . $id

            ]);

        } catch (\InvalidArgumentException $e) {

            // ex.: veículo não encontrado
            http_response_code(404);

            echo json_encode([

                'success' => false,
                'message' => $e->getMessage()

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