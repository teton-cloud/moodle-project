<?php
unset($CFG);
global $CFG;
$CFG = new stdClass();

//=========================================================================
// 1. DATABASE SETUP
//=========================================================================

$CFG->dbtype    = getenv('DB_TYPE') ?: 'pgsql';
$CFG->dblibrary = 'native';
$CFG->dbhost    = getenv('POSTGRES_HOST') ?: 'moodle-db';
$CFG->dbname    = getenv('POSTGRES_DB') ?: 'moodledb';
$CFG->dbuser    = getenv('POSTGRES_USER') ?: 'moodleuser';
$CFG->dbpass    = getenv('POSTGRES_PASSWORD') ?: 'moodlepass';
$CFG->prefix    = 'mdl_';

$CFG->dboptions = array(
    'dbpersist' => false,
    'dbsocket'  => false,
    'dbport'    => getenv('POSTGRES_PORT') ?: '5432',
    'dbcollation' => 'utf8mb4_unicode_ci',
    'ssl' => getenv('DB_SSL') ?: '', // Example: require, disable, prefer
);

//=========================================================================
// 2. WEB SITE LOCATION
//=========================================================================

$CFG->wwwroot = getenv('DOMAIN') ? 'https://' . getenv('DOMAIN') : 'http://localhost';

//=========================================================================
// 3. DATA FILES LOCATION
//=========================================================================
$CFG->dataroot = '/moodledata';

//=========================================================================
// 4. ADMIN DIRECTORY LOCATION
//=========================================================================
$CFG->admin = 'admin';

//=========================================================================
// 5. DIRECTORY PERMISSIONS
//=========================================================================
$CFG->directorypermissions = 02777;

//=========================================================================
// 6. DEBUGGING
//=========================================================================
$CFG->debug = (int) getenv('DEBUG_LEVEL') ?: 0; // 0 = None, 1 = MINIMAL, 15 = ALL
$CFG->debugdisplay = (bool) getenv('DEBUG_DISPLAY') ?: false;

//=========================================================================
// 7. REQUIRED LIBRARY
//=========================================================================
require_once(__DIR__ . '/lib/setup.php');

// Debugging: Log $CFG to Apache error log
error_log("Moodle CFG: " . print_r($CFG, true));

