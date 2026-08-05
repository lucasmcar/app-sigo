<?php 

namespace App\Model;

use App\Model\ModelBase;

class ServiceOrder extends ModelBase
{
    protected $table = 'service_orders';

    protected $fillable = [

        'customer_id',
        'vehicle_id',

        'number',
        'status',

        'mileage',

        'complaint',
        'diagnosis',
        'observations',

        'service_category',
        'priority',

        'estimated_value',
        'total_value',

        'entry_date',
        'expected_date',
        'completion_date',

        'created_by',

    ];

    public function nextNumber(): int
    {
        $sql = "SELECT COALESCE(MAX(number), 0) + 1 AS next_number FROM {$this->table}";
        $this->connect()->prepare($sql);
        $result = $this->connect()->one();
        return ($result['next_number'] ?? 0) + 1;
    }

    public function buscarPorId(int $id)
    {
        return $this
            ->alias('so')
            ->join('customers c', 'so.customer_id = c.id')
            ->join('vehicles v', 'so.vehicle_id = v.id')
            ->join('users u', 'so.created_by = u.id')
            ->where('so.id', '=', $id)
            ->get([
                // Dados da OS
                'so.id',
                'so.number',
                'so.status',
                'so.service_category',
                'so.priority',
                'so.mileage',
                'so.complaint',
                'so.diagnosis',
                'so.observations',
                'so.estimated_value',
                'so.total_value',
                'so.entry_date',
                'so.expected_date',
                'so.completion_date',
                'so.created_at',
                'so.updated_at',

                // Cliente
                'c.id AS customer_id',
                'c.name AS customer_name',
                'c.phone AS customer_phone',
                'c.email AS customer_email',

                // Veículo
                'v.id AS vehicle_id',
                'v.brand',
                'v.model',
                'v.model_year',
                'v.color',
                'v.plate',

                // Usuário
                'u.id AS user_id',
                'u.username AS created_by_name'
            ])[0] ?? null;
    }

}