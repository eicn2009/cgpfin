<%@ page language="java" contentType="text/html;charset=UTF-8"
	language="java"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Hello index.jsp</title>
</head>
<body>
<div style="padding:200px;background-color: gray">
<p style="margin:100px;padding:0;background-color: white;">
this is a paragraph!
</p>
<p style="margin:100px;padding:0;background-color: white;">
this is another paragraph!
</p>
</div>

<div style="text-align:center"> 
  <button onclick="playPause()">播放/暂停</button> 
  <button onclick="makeBig()">放大</button>
  <button onclick="makeSmall()">缩小</button>
  <button onclick="makeNormal()">普通</button>
  <br> 
  <video id="video1" src="http://video.mb.moko.cc/2016-11-23/7bd032ff-86f6-4992-990b-fb0af80609e4.mov" width="420">
<!--     <source src="http://video.mb.moko.cc/2016-09-12/0d45bb55-d750-43c1-90bd-457e36984d05.mov" type="video/mp4"> -->
<!--     <source src="http://video.mb.moko.cc/2016-09-12/0d45bb55-d750-43c1-90bd-457e36984d05.mov" type="video/ogg"> -->
    您的浏览器不支持 HTML5 video 标签。
  </video>
</div> 
<script type="text/javascript">

	var myVideo = document.getElementById("video1");

	function playPause() {
		if (myVideo.paused)
			myVideo.play();
		else
			myVideo.pause();
	}

	function makeBig() {
		myVideo.width = 560;
	}

	function makeSmall() {
		myVideo.width = 320;
	}

	function makeNormal() {
		myVideo.width = 420;
	}
</script>
</body>
</html>
