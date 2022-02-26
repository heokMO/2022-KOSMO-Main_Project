<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>       
<div id="article">
   <h1>어서오쇼</h1>
</div>
  <!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css"/>
<link rel="stylesheet" href="/resources/css/test.css">

<!-- Swiper -->
<section class="swiper-section">
<div class="swiper mySwiper">
	<div class="swiper-wrapper">
		<div class="swiper-slide">
			<div>
				<h4>
					날씨별
				</h4>
			</div>
			
			<div>
				<ul>
					<c:forEach var="e" items="${songlist }">
						<button class="show-song-detail" value="${e.song_id }">
							${e.song_title } / ${e.song_artist }
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
	
	$(".show-song-detail").click(function() {
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
	
</script>
		

		
		
		
   


