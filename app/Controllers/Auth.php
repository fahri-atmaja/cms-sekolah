<?php

namespace App\Controllers;

class Auth extends BaseController
{
    public function loginForm()
    {
        if (session()->get('user_id')) {
            return redirect()->to(site_url('admin'));
        }
        if (db_connect()->table('users')->countAllResults() === 0) {
            return redirect()->to(site_url('setup'));
        }
        return view('auth/login');
    }

    public function login()
    {
        if (! $this->validate(['username' => 'required', 'password' => 'required'])) {
            return redirect()->back()->withInput()->with('error', 'Username dan password wajib diisi.');
        }

        $identifier = trim((string) $this->request->getPost('username'));
        $user = db_connect()->table('users')
            ->select('users.*, roles.role_key')
            ->join('roles', 'roles.id = users.role_id')
            ->groupStart()
                ->where('users.username', $identifier)
                ->orWhere('users.email', $identifier)
            ->groupEnd()
            ->where('users.is_active', 1)
            ->get()->getRowArray();

        if (! $user || ! password_verify((string) $this->request->getPost('password'), $user['password_hash'])) {
            return redirect()->back()->withInput()->with('error', 'Username atau password tidak sesuai.');
        }

        session()->regenerate(true);
        session()->set([
            'user_id' => (int) $user['id'],
            'user_name' => $user['full_name'],
            'user_role' => $user['role_key'],
        ]);

        db_connect()->table('users')->where('id', $user['id'])->update([
            'last_login_at' => date('Y-m-d H:i:s'),
            'updated_at' => date('Y-m-d H:i:s'),
        ]);

        return redirect()->to(site_url('admin'))->with('success', 'Selamat datang, ' . $user['full_name'] . '.');
    }

    public function logout()
    {
        session()->destroy();
        return redirect()->to(site_url('login'))->with('success', 'Anda berhasil keluar.');
    }
}
