<?php

namespace App\Controllers;

class Setup extends BaseController
{
    public function index()
    {
        if (db_connect()->table('users')->countAllResults() > 0) {
            return redirect()->to(site_url('login'));
        }

        return view('auth/setup');
    }

    public function create()
    {
        $db = db_connect();

        if ($db->table('users')->countAllResults() > 0) {
            return redirect()->to(site_url('login'))->with('error', 'Administrator sudah dibuat.');
        }

        $rules = [
            'full_name' => 'required|min_length[3]|max_length[120]',
            'username'  => 'required|min_length[4]|max_length[60]|alpha_numeric_punct',
            'email'     => 'permit_empty|valid_email|max_length[120]',
            'password'  => 'required|min_length[10]|max_length[255]',
            'password_confirm' => 'required|matches[password]',
        ];

        if (! $this->validate($rules)) {
            return redirect()->back()->withInput()->with('errors', $this->validator->getErrors());
        }

        $adminRole = $db->table('roles')->where('role_key', 'admin')->get()->getRowArray();
        if (! $adminRole) {
            return redirect()->back()->withInput()->with('error', 'Role administrator tidak ditemukan. Jalankan database/schema.sql terlebih dahulu.');
        }

        try {
            $db->table('users')->insert([
                'role_id'      => $adminRole['id'],
                'full_name'    => trim((string) $this->request->getPost('full_name')),
                'username'     => trim((string) $this->request->getPost('username')),
                'email'        => trim((string) $this->request->getPost('email')) ?: null,
                'password_hash'=> password_hash((string) $this->request->getPost('password'), PASSWORD_DEFAULT),
                'is_active'    => 1,
                'created_at'   => date('Y-m-d H:i:s'),
                'updated_at'   => date('Y-m-d H:i:s'),
            ]);
        } catch (\Throwable $e) {
            log_message('error', 'Initial administrator creation failed: {message}', ['message' => $e->getMessage()]);
            return redirect()->back()->withInput()->with('error', 'Gagal membuat administrator. Pastikan username/email belum digunakan.');
        }

        return redirect()->to(site_url('login'))->with('success', 'Administrator berhasil dibuat. Silakan masuk.');
    }
}
