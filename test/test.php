<?php
	/*Initiating username and password variables, generating current timestamp and hash*/
	$username = "kewelta";
	$password = "kewelta";	
	$timestamp  = round(microtime(true) * 1000);
	$hash = md5(md5($password).$timestamp);

	/*Specifying API call URL*/
	$url = "https://n29.epom.com/rest-api/sites/721/pricing.do";
	
	/*Specifying request parameters*/
	$post_data = array(
		"hash" => $hash,
		"timestamp" => $timestamp,
		"username" => $username
	);

	$json = "{\"paymentModel\":\"FIXED_PRICE\",\"pricingType\":\"CPM\",\"price\":2.0}";

	/*specifying curl options*/
	$options = array(
	  CURLOPT_URL => $url . "?" . http_build_query($post_data),
	  CURLOPT_PROXY => '10.6.56.19:808',
	  CURLOPT_SSL_VERIFYPEER => false,
	  CURLOPT_POST => true, // POST method is used
	  CURLOPT_POSTFIELDS => $json, //POST request body parameters
	  CURLOPT_HTTPHEADER => array('Content-type: application/json'), //This header is mandatory in case if parameters are passed in request body.
	  CURLOPT_RETURNTRANSFER => true
	 );

	/*connection initiation*/
	$curl = curl_init();
	/*Applying curl options to our curl instance*/
	curl_setopt_array($curl,$options);
	/*Executing the call*/	
	$result = curl_exec($curl);

	echo $result;	
?>