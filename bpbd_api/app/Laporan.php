<?php

namespace App;

use Illuminate\Auth\Authenticatable;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Database\Eloquent\Model;
use Laravel\Lumen\Auth\Authorizable;

class Laporan extends Model implements AuthenticatableContract, AuthorizableContract
{
    use Authenticatable, Authorizable;

    public $table = "laporan";

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'nama_pelapor','no_hp', 'kecamatan', 'desa', 'jenis_bencana', 'garis_bujur', 'garis_lintang', 'foto', 'keterangan',
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */

}
