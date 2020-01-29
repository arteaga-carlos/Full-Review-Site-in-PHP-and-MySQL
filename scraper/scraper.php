<?php
$site = "https://www.jtracker.com/account/login.php";
$ch = curl_init($site);

$postData = 'username=admin.nation85&password=JnF!211335';



//curl_setopt($ch, CURLOPT_URL, $site);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
//curl_setopt($ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
//curl_setopt($ch, CURLOPT_COOKIEFILE, "cookie/cookie.txt");
//curl_setopt($ch, CURLOPT_COOKIEJAR, "cookie.txt");
//curl_setopt($ch, CURLOPT_REFERER, "https://s.ign.com/signin?isModal=true&r=http%3A%2F%2Fwww.ign.com%2F");
//curl_setopt($ch, CURLOPT_POST, TRUE);
//curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
//curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

# display server response
$document = curl_exec($ch);

/*$dom = new DOMDocument();
$dom->loadHTML($document);

$inputs = $dom->getElementsTagName('input');

foreach ($inputs as $input){
	
	if (preg_match('/name="CSRFToken"/', $input, $matches)){
		print_r($match);
	}
}*/

curl_close($ch);

?>