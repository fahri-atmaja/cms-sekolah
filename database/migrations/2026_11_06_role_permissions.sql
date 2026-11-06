-- CMS Web Profil Sekolah
-- Migration: permission dasar untuk role Editor
-- Jalankan sekali pada database CMS yang sudah memiliki tabel roles, users, role_permissions.
-- Backup database terlebih dahulu.

START TRANSACTION;

INSERT IGNORE INTO role_permissions (role_id, permission_key, created_at)
SELECT r.id, p.permission_key, NOW()
FROM roles r
JOIN (
    SELECT 'dashboard.view' AS permission_key
    UNION ALL SELECT 'school_profile.view'
    UNION ALL SELECT 'school_profile.edit'
    UNION ALL SELECT 'pages.view'
    UNION ALL SELECT 'pages.create'
    UNION ALL SELECT 'pages.edit'
    UNION ALL SELECT 'pages.delete'
    UNION ALL SELECT 'pages.publish'
    UNION ALL SELECT 'news.view'
    UNION ALL SELECT 'news.create'
    UNION ALL SELECT 'news.edit'
    UNION ALL SELECT 'news.delete'
    UNION ALL SELECT 'news.publish'
    UNION ALL SELECT 'announcements.view'
    UNION ALL SELECT 'announcements.create'
    UNION ALL SELECT 'announcements.edit'
    UNION ALL SELECT 'announcements.delete'
    UNION ALL SELECT 'announcements.publish'
    UNION ALL SELECT 'staff.view'
    UNION ALL SELECT 'staff.create'
    UNION ALL SELECT 'staff.edit'
    UNION ALL SELECT 'staff.delete'
    UNION ALL SELECT 'gallery.view'
    UNION ALL SELECT 'gallery.create'
    UNION ALL SELECT 'gallery.edit'
    UNION ALL SELECT 'gallery.delete'
    UNION ALL SELECT 'facilities.view'
    UNION ALL SELECT 'facilities.create'
    UNION ALL SELECT 'facilities.edit'
    UNION ALL SELECT 'facilities.delete'
    UNION ALL SELECT 'achievements.view'
    UNION ALL SELECT 'achievements.create'
    UNION ALL SELECT 'achievements.edit'
    UNION ALL SELECT 'achievements.delete'
    UNION ALL SELECT 'media.view'
    UNION ALL SELECT 'media.upload'
    UNION ALL SELECT 'feedback.view'
    UNION ALL SELECT 'feedback.manage'
) p
WHERE r.role_key = 'editor';

COMMIT;
