<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
 <!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css"/>
<link rel="stylesheet" href="/resources/css/swiper.css">

<!-- Swiper -->
<section class="swiper-section">
<div class="swiper mySwiper">
	<div class="swiper-wrapper">
		<div class="swiper-slide">
			<div id="theme_title">
				<h4>
					루프탑에서 듣기 좋은 세련된 음악
				</h4>
				<div class="theme_song_data">
					총 26곡   |  2022.02.27
				</div>
			</div>
			
			<div class="theme_album_list">
				<ul class="theme_block">
					<c:forEach var="e" items="${songlist }" begin="0" end="3">
						<button class="theme_album" value="${e.song_id }" style="background-color:transparent; border: 0; outline:0;">
								<div class="theme_album_img" >
										<img src="${e.song_img }" alt="${e.song_title }">
								</div>
									<li>${e.song_title}</li>
									<li id="theme_album_name">${e.song_album}</li>
						</button><br>	
					</c:forEach>
				</ul>
				<ul class="theme_block">
					<!-- 추천 알고리즘 만들어서 띄울준비 혁모씨가 ... -->
					<c:forEach var="e" items="${songlist }" begin="4" end="8"> 			
						<button class="theme_album" value="${e.song_id }" style="background-color:transparent; border: 0; outline:0;">
								<div class="theme_album_img" >
										<img src="${e.song_img }" alt="${e.song_title }">
								</div>
									<li>${e.song_title}</li>
									<li id="theme_album_name">${e.song_album}</li>
						</button><br>
					</c:forEach>
				</ul>
				
			</div>
		</div>
			<div class="swiper-slide">Slide 2</div>
			<div class="swiper-slide">Slide 3</div>
	  	</div>
		<div class="swiper-button-next"></div>
		<div class="swiper-button-prev"></div>
		<div class="swiper-pagination"></div>
	</div>
</section>
<!-- Detail -->
<section id="songDetail">


</section>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	var swiper = new Swiper(".mySwiper", {
	    slidesPerView: 1,
	    spaceBetween: 30,
	    rewind: true,
	    keyboard: {
	      enabled: true,
	    },
	    pagination: {
	      el: ".swiper-pagination",
	      clickable: true,
	    },
	    navigation: {
	      nextEl: ".swiper-button-next",
	      prevEl: ".swiper-button-prev",
	    },
	});
	
	$(".theme_album").click(function() {
		$.ajax({
			url:"/song/showsongdetail",
			type:"get",
			data:{"songId": $(this).val()},
			dataType:"html",
			success:function(song_html){
				$("#songDetail").html(song_html);
			}
		})
	})
	
	function gologin(e) {
		e.preventDefault();
		location.replace("member/loginPage");
	}
</script>
		

		
		
		
   


