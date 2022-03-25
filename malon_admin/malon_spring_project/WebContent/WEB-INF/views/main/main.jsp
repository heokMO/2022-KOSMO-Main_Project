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
			<div class="swiper-slide" style="background: #4F594F;">
			
				<div id="theme_title">
					<h4>
						${thema1 }
					</h4>
					<div class="theme_song_data">
						 총 8곡   |  2022.02.27
					</div>
				</div>
				
				<div class="theme_album_list">
				   <ul class="theme_block">
				      <c:forEach var="e" items="${songlist }" begin="0" end="3">
				         <button class="theme_album" value="${e.song_id }" 
				         style="background-color:transparent; border: 0; outline:0;">
				            <div class="theme_album_img" >
				               <img src="${e.song_img }" alt="${e.song_title }">
				            </div>
				            <li>${e.song_title}</li>
				            <li id="theme_album_name">${e.song_album}</li>
				         </button>
				         <br>
				      </c:forEach>
				   </ul>
				   <ul class="theme_block">
				      <!-- 추천 알고리즘 만들어서 띄울준비 혁모씨가 ... -->
				      <c:forEach var="e" items="${songlist }" begin="4" end="7">          
				         <button class="theme_album" value="${e.song_id }" 
				         style="background-color:transparent; border: 0; outline:0;">
				            <div class="theme_album_img" >
				               <img src="${e.song_img }" alt="${e.song_title }">
				            </div>
				            <li>${e.song_title}</li>
				            <li id="theme_album_name">${e.song_album}</li>
				         </button>
				         <br>
				      </c:forEach>
				   </ul>
				   
				</div>
			</div>
			<div class="swiper-slide" style="background: #8080c0;">

				<div id="theme_title">
					<h4>
						${thema2 }
					</h4>
					<div class="theme_song_data">
						 총 8곡   |  2022.03.13
					</div>
				</div>
				
				<div class="theme_album_list">
				   <ul class="theme_block">
				      <c:forEach var="e" items="${songlist }" begin="8" end="11">
				         <button class="theme_album" value="${e.song_id }" 
				         style="background-color:transparent; border: 0; outline:0;">
				            <div class="theme_album_img" >
				               <img src="${e.song_img }" alt="${e.song_title }">
				            </div>
				            <li>${e.song_title}</li>
				            <li id="theme_album_name">${e.song_album}</li>
				         </button>
				         <br>
				      </c:forEach>
				   </ul>
				   <ul class="theme_block">
				      <!-- 추천 알고리즘 만들어서 띄울준비 혁모씨가 ... -->
				      <c:forEach var="e" items="${songlist }" begin="12" end="15">          
				         <button class="theme_album" value="${e.song_id }" 
				         style="background-color:transparent; border: 0; outline:0;">
				            <div class="theme_album_img" >
				               <img src="${e.song_img }" alt="${e.song_title }">
				            </div>
				            <li>${e.song_title}</li>
				            <li id="theme_album_name">${e.song_album}</li>
				         </button>
				         <br>
				      </c:forEach>
				   </ul>
				   
				</div>
			</div>
			<div class="swiper-slide" style="background: #408080;">
			
				<div id="theme_title">
					<h4>
						잠들기 전에 듣는 기절 송
					</h4>
					<div class="theme_song_data">
						 총 8곡   |  2022.03.12
					</div>
				</div>
				
				<div class="theme_album_list">
				   <ul class="theme_block">
				      <c:forEach var="e" items="${songlist }" begin="16" end="19">
				         <button class="theme_album" value="${e.song_id }" 
				         style="background-color:transparent; border: 0; outline:0;">
				            <div class="theme_album_img" >
				               <img src="${e.song_img }" alt="${e.song_title }">
				            </div>
				            <li>${e.song_title}</li>
				            <li id="theme_album_name">${e.song_album}</li>
				         </button>
				         <br>
				      </c:forEach>
				   </ul>
				   <ul class="theme_block">
				      <!-- 추천 알고리즘 만들어서 띄울준비 혁모씨가 ... -->
				      <c:forEach var="e" items="${songlist }" begin="20" end="23">          
				         <button class="theme_album" value="${e.song_id }" 
				         style="background-color:transparent; border: 0; outline:0;">
				            <div class="theme_album_img" >
				               <img src="${e.song_img }" alt="${e.song_title }">
				            </div>
				            <li>${e.song_title}</li>
				            <li id="theme_album_name">${e.song_album}</li>
				         </button>
				         <br>
				      </c:forEach>
				   </ul>
				   
				</div>
			</div>
		</div>
	<div class="swiper-button-next"></div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-pagination"></div>
	</div>
</section>

<!-- Detail -->
<section id="randomsong"></section>
<section id="songDetail"></section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
   $.ajax({
      url:"/song/randomSong",
      type:"get",
      dataType:"html",
      success:function(song_html){
         $("#randomsong").html(song_html);
      }
   })
});


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
         const offset = $("#songDetail").offset(); 
         $('html, body').animate({scrollTop: offset.top}, 500);
      }
   })
})

</script>