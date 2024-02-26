<?php
//kermel security w n7mi data jeyh
function filterRequest($requestName)
{
    return htmlspecialchars(strip_tags($_POST[$requestName]));
}
