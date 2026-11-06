<!doctype html>
<html lang="id">
<head>
<meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<title><?= esc($title ?? 'Admin') ?> | CMS Sekolah</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
<style>
body{background:#f5f7fb}.sidebar{min-height:100vh;background:#172554}
.sidebar a{color:rgba(255,255,255,.82);text-decoration:none;display:block;padding:.7rem 1rem;border-radius:.5rem}
.sidebar a:hover,.sidebar a.active{background:rgba(255,255,255,.13);color:#fff}
.brand{color:#fff;font-weight:700;letter-spacing:.02em}
@media(max-width:767.98px){.sidebar{min-height:auto}}
</style>
</head>
<body><div class="container-fluid"><div class="row">
<aside class="col-md-3 col-lg-2 sidebar p-3">
<div class="brand fs-5 mb-4 px-2">CMS Sekolah</div>
<nav class="d-grid gap-1"><a class="active" href="<?= site_url('admin') ?>"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a></nav>
<div class="border-top border-light border-opacity-25 mt-4 pt-3 px-2 text-white-50 small">Masuk sebagai<br><strong class="text-white"><?= esc(session()->get('user_name')) ?></strong></div>
<a class="mt-2" href="<?= site_url('logout') ?>"><i class="bi bi-box-arrow-right me-2"></i>Keluar</a>
</aside>
<main class="col-md-9 col-lg-10 p-3 p-lg-4">
<?php if ($message = session()->getFlashdata('success')): ?><div class="alert alert-success"><?= esc($message) ?></div><?php endif; ?>
<?= $this->renderSection('content') ?>
<footer class="text-muted small mt-5 pt-3 border-top">CMS Web Profil Sekolah</footer>
</main></div></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body></html>
