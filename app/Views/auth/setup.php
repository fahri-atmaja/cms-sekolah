<!doctype html>
<html lang="id">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title>Setup Administrator | CMS Sekolah</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5"><div class="row justify-content-center"><div class="col-md-7 col-lg-6">
<div class="card border-0 shadow-sm"><div class="card-body p-4 p-md-5">
<h1 class="h4 mb-2">Setup Administrator</h1><p class="text-muted mb-4">Buat akun administrator pertama CMS sekolah.</p>
<?php if ($message = session()->getFlashdata('error')): ?><div class="alert alert-danger"><?= esc($message) ?></div><?php endif; ?>
<?php if ($errors = session()->getFlashdata('errors')): ?><div class="alert alert-danger"><ul class="mb-0"><?php foreach ($errors as $error): ?><li><?= esc($error) ?></li><?php endforeach; ?></ul></div><?php endif; ?>
<form method="post" action="<?= site_url('setup') ?>">
<?= csrf_field() ?>
<div class="mb-3"><label class="form-label">Nama lengkap</label><input class="form-control" name="full_name" value="<?= esc(old('full_name')) ?>" required maxlength="120"></div>
<div class="mb-3"><label class="form-label">Username</label><input class="form-control" name="username" value="<?= esc(old('username')) ?>" required minlength="4" maxlength="60" autocomplete="username"></div>
<div class="mb-3"><label class="form-label">Email (opsional)</label><input class="form-control" type="email" name="email" value="<?= esc(old('email')) ?>" maxlength="120"></div>
<div class="mb-3"><label class="form-label">Password (minimal 10 karakter)</label><input class="form-control" type="password" name="password" required minlength="10" autocomplete="new-password"></div>
<div class="mb-4"><label class="form-label">Ulangi password</label><input class="form-control" type="password" name="password_confirm" required minlength="10" autocomplete="new-password"></div>
<button class="btn btn-primary w-100" type="submit">Buat Administrator</button>
</form></div></div><p class="text-center text-muted small mt-3">CMS Web Profil Sekolah</p>
</div></div></div>
</body></html>
