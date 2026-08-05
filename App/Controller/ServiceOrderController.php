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
            'customer_id',

            'complaint',
            'entry_mileage',

            'service_category',
            'priority',

            'estimated_delivery',
            'estimated_value',
            'expected_date',

            'status',
            'notes'

        ]);

        unset($data['_csrf_token']);

        // --- Campos obrigatórios ---
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

        $vehicleId = filter_var($data['vehicle_id'], FILTER_VALIDATE_INT);
        if ($vehicleId === false) {

            http_response_code(400);

            echo json_encode([
                'success' => false,
                'message' => 'Veículo inválido.'
            ]);

            return;

        }
        $data['vehicle_id'] = $vehicleId;

        $mileage = filter_var($data['entry_mileage'], FILTER_VALIDATE_INT, [
            'options' => ['min_range' => 0]
        ]);
        if ($mileage === false) {

            http_response_code(400);

            echo json_encode([
                'success' => false,
                'message' => 'Quilometragem inválida.'
            ]);

            return;

        }
        $data['entry_mileage'] = $mileage;

        if (isset($data['estimated_value']) && $data['estimated_value'] !== '') {

            $estimatedValue = filter_var($data['estimated_value'], FILTER_VALIDATE_FLOAT, [
                'options' => ['min_range' => 0]
            ]);

            if ($estimatedValue === false) {

                http_response_code(400);

                echo json_encode([
                    'success' => false,
                    'message' => 'Valor estimado inválido.'
                ]);

                return;

            }

            $data['estimated_value'] = $estimatedValue;

        } else {

            $data['estimated_value'] = 0.00;

        }
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

        $validCategories = [
            'mecanica', 'funilaria', 'pintura', 'funilaria_pintura',
            'eletrica', 'estetica', 'ar_condicionado', 'revisao', 'outro'
        ];

        if (!empty($data['service_category']) && !in_array($data['service_category'], $validCategories, true)) {

            http_response_code(400);

            echo json_encode([
                'success' => false,
                'message' => 'Categoria de atendimento inválida.'
            ]);

            return;

        }

        $validPriorities = ['normal', 'alta', 'urgente'];

        if (!empty($data['priority']) && !in_array($data['priority'], $validPriorities, true)) {

            http_response_code(400);

            echo json_encode([
                'success' => false,
                'message' => 'Prioridade inválida.'
            ]);

            return;

        }

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
        $data['estimated_delivery'] = $data['estimated_delivery'] ?? null;
        $data['entry_date'] = date('Y-m-d H:i:s');

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

            http_response_code(404);

            echo json_encode([

                'success' => false,
                'message' => $e->getMessage()

            ]);

        } catch (\Exception $e) {

            http_response_code(500);

            echo json_encode([

                'success' => false,
                'message' => 'Erro interno.'
            ]);

        }
    }

    public function buscaOS($params =[])
    {
        $rawQ = $params[0] ?? $_GET['search'] ?? '';

        $q = trim(filter_var(
            $rawQ,
            FILTER_UNSAFE_RAW,
            FILTER_FLAG_STRIP_LOW
        ));

        $repository = new ServiceOrderRepository();

        $resultado = $repository->buscarPorId((int)$q);

    print_r($resultado); // Debug: Exibe o resultado no console do navegador

        $data = [
            'service_order' => [
                'id' => $resultado['id'],
                'number' => $resultado['number'],
                'status' => $resultado['status'],
                'service_category' => $resultado['service_category'],
                'priority' => $resultado['priority'],

                'mileage' => $resultado['mileage'],

                'complaint' => $resultado['complaint'],
                'diagnosis' => $resultado['diagnosis'],
                'observations' => $resultado['observations'],

                'estimated_value' => $resultado['estimated_value'],
                'total_value' => $resultado['total_value'],

                'entry_date' => $resultado['entry_date'],
                'expected_date' => $resultado['estimated_delivery'],
                'completion_date' => $resultado['completion_date'],

                'created_at' => $resultado['created_at'],
                'updated_at' => $resultado['updated_at'],

                'customer' => [
                    'id' => $resultado['customer_id'],
                    'name' => $resultado['customer_name'],
                    'phone' => $resultado['customer_phone'],
                    'email' => $resultado['customer_email'],
                ],

                'vehicle' => [
                    'id' => $resultado['vehicle_id'],
                    'brand' => $resultado['brand'],
                    'model' => $resultado['model'],
                    'model_year' => $resultado['model_year'],
                    'color' => $resultado['color'],
                    'plate' => $resultado['plate'],
                ],

                'created_by' => [
                    'id' => $resultado['user_id'],
                    'username' => $resultado['created_by_name'],
                ]
            ]
        ];

        $styles = ['/assets/css/dashboard.css'];

        return new View(view: 'admin/detalhes-os', vars: $data, styles: $styles);
    }
}