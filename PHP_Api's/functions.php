<?php
//same const in flutter hed ma fini a3ml changes b2lbo

//kermel security w n7mi data jeyh
function filterRequest($requestName)
{
    return htmlspecialchars(strip_tags($_POST[$requestName]));
}

function imageUpload($imagerequest)
{
    global $msgError;
    $imagename = rand(1, 10000) . $_FILES[$imagerequest]["name"];
    $imagetmp = $_FILES[$imagerequest]["tmp_name"];
    $imagesize = $_FILES[$imagerequest]["size"];
    $allowExt = array("jpg", "png", "gif", "mp3", "pdf", "jpeg");
    $stringToArray = explode(".", $imagename);
    $ext = end($stringToArray);
    $ext = strtolower($ext);
    $msgError = [];
    define('MB', 1024 * 1024);
    if (!empty($imagename) && !in_array($ext, $allowExt)) {
        $msgError[] = "Ext";
    }
    if ($imagesize > 2 * MB) {
        $msgError[] = "size";
    }
    if (empty($msgError)) {
        if (move_uploaded_file($imagetmp, "../upload/" . $imagename)) {
            return $imagename;
        } else {
            return  "Error moving file: " . error_get_last()['message'];
        }
    } else {
        return 'fail';
    }
}


function deleteFile($direction, $imagename)
{
    if (file_exists($direction . "/" . $imagename)) {
        unlink($direction . "/" . $imagename);
    }
}
