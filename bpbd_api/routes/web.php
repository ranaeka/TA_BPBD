<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->post('register', 'UserController@register');

$router->post('login', 'UserController@login');

$router->post('updatePassword/{id}', 'UserController@updatePassword');

$router->post('buatLaporan', 'LaporanController@buatLaporan');

$router->get('lihatLaporan/{id}', 'LaporanController@lihatLaporan');
$router->get('get_jenis_bencana','ControllerBencana@getJenisBencana');
$router->get('get_bencana', 'ControllerBencana@getBencana');
$router->get('get_laporan', 'ControllerBencana@getLaporan');
$router->post('update_status', 'ControllerBencana@updateStatus');
$router->post('save_uraian', 'ControllerBencana@saveUraian');
$router->post('edit_uraian', 'ControllerBencana@editUraian');
$router->delete('delete_uraian/{id}', 'ControllerBencana@deleteUraian');
$router->delete('delete_laporan/{id}', 'LaporanController@deleteLaporan');
$router->get('get_uraian', 'ControllerBencana@getUraian');
