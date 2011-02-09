<?php
$u_agent = $_SERVER['HTTP_USER_AGENT'];

// Forwarding to browser specific version.
if (preg_match('/MSIE/i', $u_agent)) {
    // got to IE version
    header('Location: /pages/page0001-ie-sketched.html');
} else {
    // got to non IE Version 
    header('Location: /pages/page0001-sketched.xhtml');
}
exit;
?>