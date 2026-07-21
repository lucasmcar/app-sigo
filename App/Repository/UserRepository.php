<?php 

namespace App\Repository;

use App\Model\User;

class UserRepository
{
    private $model;

    public function __construct()
    {
        $this->model = new User();
    }

    public function create(array $data) : int
    {
        return $this->model->create($data);
    }

    public function findForSign(string $email)
    {
        return $this->model->findForSign($email);
    }

    public function updateLastLogin($id, $lastLogin)
    {
        $this->model->updateLastLogin($id, $lastLogin);
    }

    public function getWhere(string $param, string $operator, int|string $value )
    {
        return $this->model->where($param, $operator, $value)->get();
    }
}