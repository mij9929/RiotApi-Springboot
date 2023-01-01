<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link rel="stylesheet" href="/css/style.css">
<style>
.copy-container {
	text-align: center;
}

p {
	color: #000;
	font-size: 24px;
	letter-spacing: .2px;
	margin: 0;
}
</style>
</head>
<body>

	<br />

	<div class="container">
		<div class="container">
			<div class="row">
				<div class="col"
					style="font-size: 50px; font-weight: bold; font-style: italic;">
					<Strong>Lck.GG</Strong>
				</div>
				<div class="col-10">
					<div class="search">
						<i class="fa fa-search"></i>
						<form action="/search" method="GET">
							<input name="summonerName" class="form-control"
								placeholder="소환사검색">
							<button class="btn btn-primary">Search</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br />

	<div class="container">
		<div class="copy-container center-xy">
			<p>소환사를 찾을 수 없습니다.</p>
			<span class="handle"></span>
		</div>
	</div>


	<script>
		var $copyContainer = $(".copy-container"), $replayIcon = $('#cb-replay'), $copyWidth = $(
				'.copy-container').find('p').width();

		var mySplitText = new SplitText($copyContainer, {
			type : "words"
		}), splitTextTimeline = new TimelineMax();
		var handleTL = new TimelineMax();

		//WIP - need to clean up, work on initial state and handle issue with multiple lines on mobile

		var tl = new TimelineMax();

		tl.add(function() {
			animateCopy();
			blinkHandle();
		}, 0.2)

		function animateCopy() {
			mySplitText.split({
				type : "chars, words"
			})
			splitTextTimeline.staggerFrom(mySplitText.chars, 0.001, {
				autoAlpha : 0,
				ease : Back.easeInOut.config(1.7),
				onComplete : function() {
					animateHandle()
				}
			}, 0.05);
		}

		function blinkHandle() {
			handleTL.fromTo('.handle', 0.4, {
				autoAlpha : 0
			}, {
				autoAlpha : 1,
				repeat : -1,
				yoyo : true
			}, 0);
		}

		function animateHandle() {
			handleTL.to('.handle', 0.7, {
				x : $copyWidth,
				ease : SteppedEase.config(12)
			}, 0.05);
		}

		$('#cb-replay').on('click', function() {
			splitTextTimeline.restart()
			handleTL.restart()
		})
	</script>
</body>
</html>