<?php 

namespace App\Repository;

use App\Model\Vehicle;

class VehicleRepository
{
    private $model;

    public function __construct()
    {
        $this->model = new Vehicle();
    }

    public function create(array $data) : int
    {
        return $this->model->create($data);
    }

    public function findForSign(string $username, string $email =  null)
    {
        return $this->model->findForSign($username, $email);
    }

    /*public function updateLastLogin($id, $lastLogin)
    {
        $this->model->updateLastLogin($id, $lastLogin);
    }*/

    public function getWhere(string $param, string $operator, int|string $value, bool $hasOr = true )
    {
        if($hasOr) {
            return $this->model->where($param, $operator, $value)
                ->orWhere($param, $operator, $value) ->get();
        }
        return $this->model->where($param, $operator, $value)->get();
    }
}