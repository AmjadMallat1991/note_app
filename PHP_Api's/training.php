<?php
// $name = 'mhmd';
// echo "hello " . $name;
// echo "<br/>";
// $price = 10;
// if ($price > 10) {
//     echo 'price good';
// } else if ($price == 10) {
//     echo 'same';
// } else {
//     echo 'price not good';
// }

// function printName($namePerson)
// {
//     echo '<br/> how are you ' . $namePerson;
// }
// printName($name);

// //la est3ml variable m3rfo bara function
// function printName2()
// {

//     global $name;
//     echo '<br/> how are you ' . $name;
//     //or
//     echo '<br/> how are you ' . $GLOBALS['name'];
// }
// printName2();

//all this is indexed array 

// global  $listName;
// $listName =  array('amjad', 'mahmoud', 'ahmad');
// for ($i = 0; $i < count($listName); $i++) {
//     echo  $listName[$i] .'<br/> ';
// }
// //bzid 3al list
// $listName.array_push($listName,$name);

// this is associative array same MAP in dart

$listAssoc=array(
'name'=>'salim',
'age'=>18,

);

echo  $listAssoc['name'] .'<br/>';

foreach ($listAssoc as $key => $value) {
    echo ' '. $key .' '. $value .' ';
}



// $getName=$_GET['name'];
// $getAge=$_GET['age'];
// $getEmail=$_GET['email'];

// echo $getName .'<br/>';
// echo $getAge.'<br/>';
// echo $getEmail.'<br/>';

// print_r($_GET);

// $postName=$_POST['name'];
// echo $postName;
// print_r($_POST);

