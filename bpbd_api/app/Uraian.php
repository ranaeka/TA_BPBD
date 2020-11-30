<?php

namespace App;

use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Model;
use Laravel\Lumen\Auth\Authorizable;

class Uraian extends Model implements AuthenticatableContract, AuthorizableContract
{
    use Authenticatable, Authorizable;

    public $table = "tb_uraian";

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */


    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */




    public function detailUser()
    {
        return $this->hasOne(Users::class, 'id', 'id_user');
    }


}
