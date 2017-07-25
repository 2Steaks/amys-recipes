<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 */

return [
    '*' => array(
        'allowAutoUpdates' => 'minor-only',
        'defaultWeekStartDay' => 1,
        'omitScriptNameInUrls' => true,
        'sendPoweredByHeader' => false,
        'maxUploadFileSize' => 1572864,
        'devMode' => true,
        'cpTrigger' => 'admin',
        'enableCsrfProtection' => true
    ),
    '.ninja' => array(
        'devMode' => false
    )
];
