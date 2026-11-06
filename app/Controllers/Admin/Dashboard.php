<?php

namespace App\Controllers\Admin;

use App\Controllers\BaseController;

class Dashboard extends BaseController
{
    public function index()
    {
        $db = db_connect();
        return view('admin/dashboard', [
            'title' => 'Dashboard',
            'counts' => [
                'pages' => $db->table('pages')->countAllResults(),
                'news' => $db->table('news_posts')->countAllResults(),
                'announcements' => $db->table('announcements')->countAllResults(),
                'staff' => $db->table('staff')->countAllResults(),
                'galleries' => $db->table('galleries')->countAllResults(),
                'users' => $db->table('users')->countAllResults(),
            ],
        ]);
    }
}
