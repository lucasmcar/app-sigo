<?php

namespace App\Model;
use App\Model\ModelBase;

class User extends ModelBase
{
    protected $table = 'users';

    protected $fillable = [
        'company_name',
        'cnpj',
        'phone',
        'email',
        'username',
        'password'
    ];

    /**
     * Update register of last login
     * @param $id | int
     * @param $lastLogin | date
     * @return true || null
     */
    public function updateLastLogin($id, $lastLogin)
    {
        $sql = "UPDATE users as u SET u.last_login = :last_login WHERE u.id = :id";
        $this->db->prepare($sql);
        $this->db->bind(':last_login', $lastLogin);
        $this->db->bind(':id', $id, null);
        $result = $this->db->execute([]);
        return $result;
    }
}