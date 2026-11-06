<?= $this->extend('layouts/admin') ?>
<?= $this->section('content') ?>
<div class="mb-4"><h1 class="h3 mb-1">Dashboard</h1><p class="text-muted mb-0">Ringkasan pengelolaan website sekolah.</p></div>
<div class="row g-3">
<?php
$cards = [
 ['Halaman', $counts['pages']],
 ['Berita', $counts['news']],
 ['Pengumuman', $counts['announcements']],
 ['Guru & Staf', $counts['staff']],
 ['Galeri', $counts['galleries']],
 ['Pengguna', $counts['users']],
];
?>
<?php foreach ($cards as [$label, $count]): ?>
<div class="col-6 col-xl-4"><div class="card border-0 shadow-sm h-100"><div class="card-body">
<div class="text-muted small"><?= esc($label) ?></div><div class="display-6 fw-semibold"><?= number_format((int) $count) ?></div>
</div></div></div>
<?php endforeach; ?>
</div>
<div class="alert alert-info mt-4 mb-0">Fondasi CMS berhasil dimuat. Modul pengelolaan konten akan ditambahkan pada tahapan berikutnya.</div>
<?= $this->endSection() ?>
