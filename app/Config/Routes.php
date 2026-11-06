<?php

use CodeIgniter\Router\RouteCollection;

/** @var RouteCollection $routes */
$routes->get('/', 'Auth::loginForm');
$routes->get('setup', 'Setup::index');
$routes->post('setup', 'Setup::create');
$routes->get('login', 'Auth::loginForm');
$routes->post('login', 'Auth::login');
$routes->get('logout', 'Auth::logout', ['filter' => 'auth']);

$routes->group('admin', ['filter' => 'auth'], static function (RouteCollection $routes): void {
    $routes->get('/', 'Admin\Dashboard::index');
});
