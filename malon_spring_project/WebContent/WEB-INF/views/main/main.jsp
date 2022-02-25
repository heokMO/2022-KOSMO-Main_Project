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
			       	<a>
						<div>
							<h4>
								날씨별
							</h4>
						</div>
					
						<div>
							<ul>
								<div>
									<c:forEach var="e" items="${songlist }"> 			
										<a href="/song/showsongdetail?songId=${e.song_id}">
											<li>${e.song_album}</li>
										</a>
									</c:forEach>
								</div>
							</ul>
						</div>
					</a>
			   </div>
		       <div class="swiper-slide">Slide 2</div>
		       <div class="swiper-slide">Slide 3</div>
		  </div>
		     <div class="swiper-button-next"></div>
		     <div class="swiper-button-prev"></div>
		     <div class="swiper-pagination"></div>
	</div>
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

</script>
		

		
		
		
   


