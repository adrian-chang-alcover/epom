<?php
	define("DEBUG",false);
	
	$username = "kewelta";
	$password = "kewelta";	
	$timestamp  = round(microtime(true) * 1000);
	$hash = md5(md5($password).$timestamp);
		
	$url = "https://n29.epom.com/rest-api/banner/create.do";	
	/*Getting the full path to your file*/
	$file_name_with_full_path = realpath('300x250.gif');
	/*Specifying MIME type of the file*/
	$filetype = "image/gif";
	
	$post_data = array(
		"hash" => $hash,
		"timestamp" => $timestamp,
		"username" => $username,
		"placementType" => "SITE_PLACEMENT",
		"campaignId" => "1261",
		"active" => "true",
		"name" => "test_banner_1",
		"weight" => "1",
		"bannerType" => "LOCAL_FILE",
		"imageBannerLink" => "http://qwe.com",
		"imageFile" => "@$file_name_with_full_path;type=$filetype",
		"url" => "http://qwe.com",
		"adUnitId" => "1"
	);
	
	$options = array(
		CURLOPT_URL => $url,
		CURLOPT_SSL_VERIFYPEER => false,
		CURLOPT_POST => true,		
		CURLOPT_POSTFIELDS => $post_data, 
		CURLOPT_HTTPHEADER => array("Content-type: multipart/form-data"),		
		CURLOPT_RETURNTRANSFER => true
	);
	
	$curl = curl_init();
	
	curl_setopt_array($curl,$options);	

	echo curl_exec($curl);
	
	if(DEBUG){
		echo "\n\n";
		echo $url;
		print_r($post_data);
	}		
?>