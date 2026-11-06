<!doctype html>
<html lang="id">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login | CMS Sekolah</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5"><div class="row justify-content-center"><div class="col-md-6 col-lg-5">
<div class="card border-0 shadow-sm"><div class="card-body p-4 p-md-5">
<h1 class="h4 mb-2">CMS Web Profil Sekolah</h1><p class="text-muted mb-4">Masuk ke panel pengelolaan website.</p>
<?php if ($message = session()->getFlashdata('success')): ?><div class="alert alert-success"><?= esc($message) ?></div><?php endif; ?>
<?php if ($message = session()->getFlashdata('error')): ?><div class="alert alert-danger"><?= esc($message) ?></div><?php endif; ?>
<form method="post" action="<?= site_url('login') ?>">
<?= csrf_field() ?>
<div class="mb-3"><label class="form-label">Username atau email</label><input class="form-control" name="username" value="<?= esc(old('username')) ?>" required autocomplete="username" autofocus></div>
<div class="mb-4"><label class="form-label">Password</label><input class="form-control" type="password" name="password" required autocomplete="current-password"></div>
<button class="btn btn-primary w-100" type="submit">Masuk</button>
</form></div></div><p class="text-center text-muted small mt-3">CMS Web Profil Sekolah</p>
</div></div></div>
</body></html>
