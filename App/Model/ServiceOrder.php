<?php 

namespace App\Model;

use App\Model\ModelBase;

class ServiceOrder extends ModelBase
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

}