<?php 

namespace App\Model;

use App\Model\ModelBase;

class Vehicle extends ModelBase
{
    protected $table = 'vehicles';

    protected $fillable = [

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
    ];

    public function buscarPorPlaca(string $plate)
    {
        return $this
            ->alias('v')
            ->join('customers c', 'v.customer_id = c.id')
            ->where('v.plate', '=', $plate)
            ->get([
                'v.id',
                'v.brand',
                'v.model',
                'v.model_year',
                'v.color',
                'v.plate',
                'v.mileage',
                'c.name AS customer_name',
                'v.customer_id',
            ])[0] ?? null;
    }
}