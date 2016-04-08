<?php
echo "PHP TEST: echo\n";

if(class_exists('Memcached')){
  echo "PHP TEST: memcached\n";
}

error_log("PHP TEST: error_log");

require_once __DIR__.'/../vendor/autoload.php';

use Monolog\Logger;
use Monolog\Handler\StreamHandler;

$log = new Logger('stdoutlogger');
$log->pushHandler(new StreamHandler('php://stdout', Logger::WARNING));
$log->pushHandler(new StreamHandler('php://stdout', Logger::INFO));
$log->pushHandler(new StreamHandler('php://stderr', Logger::ERROR));

$log->addInfo("PHP TEST: monolog info to stdout\n");
$log->addWarning("PHP TEST: monolog warning to stdout\n");
$log->addError("PHP TEST: monolog error to stderr\n");

?>
