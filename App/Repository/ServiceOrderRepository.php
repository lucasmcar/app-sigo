<?php 

namespace App\Repository;

use App\Model\ServiceOrder;

class ServiceOrderRepository
{
    private ServiceOrder $model;

    public function __construct()
    {
        $this->model = new ServiceOrder();
    }

    public function create(array $data) : int
    {
        if (empty($data['number'])) {
            $data['number'] = $this->model->nextNumber();
        }

        return $this->model->create($data);
    }

    public function findForSign(string $username, string $email =  null)
    {
        return $this->model->findForSign($username, $email);
    }

    public function updateLastLogin($id, $lastLogin)
    {
        //$this->model->updateLastLogin($id, $lastLogin);
    }

    public function getWhere(string $param, string $operator, int|string $value, bool $hasOr = true )
    {
        return $this->model->where($param, $operator, $value)->get();
    }

    public function buscarPorNomeOuDocumento(string $busca = '')
    {
        //return $this->model->buscarPorNomeOuDocumento($busca);
    }

    public function all()
    {
        return $this->model->all();
    }

    public function buscarPorId(int $id)
    {
        return $this->model->buscarPorId($id);
    }
}