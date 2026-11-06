<?php

namespace App\Filters;

use CodeIgniter\Filters\FilterInterface;
use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;

class RoleFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        if (! session()->get('user_id')) {
            return redirect()->to(site_url('login'))->with('error', 'Silakan masuk terlebih dahulu.');
        }

        $role = (string) session()->get('user_role');

        // Administrator memiliki akses penuh ke seluruh modul CMS.
        if ($role === 'admin') {
            return null;
        }

        $permission = $arguments[0] ?? null;
        if (! is_string($permission) || $permission === '') {
            return service('response')->setStatusCode(403)->setBody('403 - Akses ditolak.');
        }

        $allowed = db_connect()->table('role_permissions rp')
            ->select('rp.id')
            ->join('roles r', 'r.id = rp.role_id')
            ->where('r.role_key', $role)
            ->where('rp.permission_key', $permission)
            ->limit(1)
            ->countAllResults() > 0;

        if (! $allowed) {
            return service('response')->setStatusCode(403)->setBody('403 - Anda tidak memiliki hak akses untuk halaman ini.');
        }
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        // No post-processing required.
    }
}
