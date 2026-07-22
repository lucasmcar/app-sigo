<?php

namespace App\Model;
use App\Model\ModelBase;

class Client extends ModelBase
{
    protected $table = 'customers';

    protected $fillable = [

        'company_id',

        'name',

        'person_type',

        'cpf',

        'cnpj',

        'birth_date',

        'phone',

        'whatsapp',

        'email',

        'cep',

        'street',

        'number',

        'complement',

        'district',

        'city',

        'state',

        'notes'

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