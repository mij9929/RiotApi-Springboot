<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">

<link rel="stylesheet" href="css/style.css">
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
							<input name="summonerName" class="form-control" placeholder="소환사검색">
							<button class="btn btn-primary">Search</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br />
	<div class="container d-flex bg-light ">
		<div class=card style="width: 150px; heigth: 150px;">
			<img
				src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/profileicon/${summoner.profileIconId}.png"
				class="card-img-top">
		</div>
		<div class="d-flex flex-column mb-3">
			<h2>${summoner.name}</h2>
			<h6>
				<span class="badge bg-secondary"> 레벨:
					${summoner.summonerLevel} </span>
			</h6>
		</div>
	</div>
	<br />
	<c:forEach var="league" items="${leagueEntry}">
		<c:if test="${league.queueType eq 'RANKED_SOLO_5x5'}">
			<c:set var="soloLeague" value="${league}" />
		</c:if>
		<c:if test="${league.queueType eq 'RANKED_FLEX_SR'}">
			<c:set var="flexLeague" value="${league}" />
		</c:if>
	</c:forEach>
	<div class="container d-flex justify-content-around bg-light">
		<div class="container d-flex flex-row">
			<div>
				<c:choose>
					<c:when test="${soloLeague.tier eq null}">
						<img src="/img/tier/unrank.png"
							style="width: 190px; height: 190px;">
					</c:when>
					<c:otherwise>
						<img src="/img/tier/${soloLeague.tier}.png"
							style="width: 190px; height: 190px;">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="container">
				<p class="fw-semibold" style="font-size: 40px;">솔로 랭크</p>
				<p class="fw-semibold" style="font-size: 25px;">등급:
					${soloLeague.tier} ${soloLeague.rank}</p>
				<p class="fw-semibold" style="font-size: 20px; color: green">${soloLeague.leaguePoints}
					LP</p>
				<p>${soloLeague.wins}승&nbsp;${soloLeague.losses}패</p>
			</div>
		</div>
		<div class="container d-flex flex-row">
			<div>
				<c:choose>
					<c:when test="${flexLeague.tier eq null}">
						<img src="/img/tier/unrank.png"
							style="width: 190px; height: 190px;">
					</c:when>
					<c:otherwise>
						<img src="/img/tier/${flexLeague.tier}.png"
							style="width: 190px; height: 190px;">
					</c:otherwise>
				</c:choose>
			</div>
			<div class="container">
				<p class="fw-semibold" style="font-size: 40px;">자유 랭크</p>
				<p class="fw-semibold" style="font-size: 25px">등급:
					${flexLeague.tier} ${flexLeague.rank}</p>
				<p class="fw-semibold" style="font-size: 20px; color: green">${flexLeague.leaguePoints}LP</p>
				<p>${flexLeague.wins}승&nbsp${flexLeague.losses}패</p>
			</div>
		</div>
	</div>
	<br />
	<br />
	<br />
	<div class="container text-center">
		<table class="table align-middle table-bordered">
			<thead>
				<tr class="table-light">
					<th scope="col">승</th>
					<th scope="col">챔피언</th>
					<th scope="col">스펠/룬</th>
					<th scope="col">KDA</th>
					<th scope="col">킬관여</th>
					<th scope="col">아이템</th>
					<th scope="col">TEAM</th>
					<th scope="col">레벨/CS/골드</th>
					<th scope="col">플레이 타임</th>
					<th scope="col">더보기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<c:forEach var="match" items="${matches}" varStatus="status">
						<c:set var="teamTotalKill1" value='0' />
						<c:set var="teamTotalkill2" value='0' />
						<c:set var="teamMaxDamage1" value='0' />
						<c:set var="teamMaxDamage2" value='0' />
						<c:set var="teamMaxTakenDamage1" value='0' />
						<c:set var="teamMaxTakenDamage2" value='0' />

						<c:forEach var="laner" items="${match.info.participants}">
							<c:if test="${laner.summonerName eq summoner.name}">
								<c:set var="me" value="${laner}" />
							</c:if>
							<c:choose>
								<c:when test="${laner.teamId eq '100'}">
									<c:if
										test="${laner.totalDamageDealtToChampions gt teamMaxDamage1}">
										<c:set var="teamMaxDamage1"
											value="${laner.totalDamageDealtToChampions }" />
									</c:if>

									<c:if test="${laner.totalDamageTaken gt teamMaxTakenDamage1}">
										<c:set var="teamMaxTakenDamage1"
											value="${laner.totalDamageTaken }" />
									</c:if>

									<c:set var="teamTotalKill1"
										value="${laner.kills + teamTotalKill1}" />
								</c:when>

								<c:otherwise>
									<c:if
										test="${laner.totalDamageDealtToChampions gt teamMaxDamage2}">
										<c:set var="teamMaxDamage2"
											value="${laner.totalDamageDealtToChampions }" />
									</c:if>

									<c:if test="${laner.totalDamageTaken gt teamMaxTakenDamage2}">
										<c:set var="teamMaxTakenDamage2"
											value="${laner.totalDamageTaken }" />
									</c:if>
									<c:set var="teamTotalKill2"
										value="${laner.kills + teamTotalKill2}" />

								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${laner.teamPosition eq 'TOP'}">
									<c:choose>
										<c:when test="${laner.teamId eq '100'}">
											<c:set var="top1" value="${laner}" />
										</c:when>
										<c:otherwise>
											<c:set var="top2" value="${laner}" />
										</c:otherwise>
									</c:choose>
								</c:when>

								<c:when test="${laner.teamPosition eq 'MIDDLE'}">
									<c:choose>
										<c:when test="${laner.teamId eq '100'}">
											<c:set var="mid1" value="${laner}" />
										</c:when>
										<c:otherwise>
											<c:set var="mid2" value="${laner}" />
										</c:otherwise>
									</c:choose>
								</c:when>

								<c:when test="${laner.teamPosition eq 'JUNGLE'}">
									<c:choose>
										<c:when test="${laner.teamId eq '100'}">
											<c:set var="jug1" value="${laner}" />
										</c:when>
										<c:otherwise>
											<c:set var="jug2" value="${laner}" />
										</c:otherwise>
									</c:choose>
								</c:when>

								<c:when test="${laner.teamPosition eq 'BOTTOM'}">
									<c:choose>
										<c:when test="${laner.teamId eq '100'}">
											<c:set var="ad1" value="${laner}" />
										</c:when>
										<c:otherwise>
											<c:set var="ad2" value="${laner}" />
										</c:otherwise>
									</c:choose>
								</c:when>

								<c:when test="${laner.teamPosition eq 'UTILITY'}">
									<c:choose>
										<c:when test="${laner.teamId eq '100'}">
											<c:set var="sup1" value="${laner}" />
										</c:when>
										<c:otherwise>
											<c:set var="sup2" value="${laner}" />
										</c:otherwise>
									</c:choose>
								</c:when>
							</c:choose>
						</c:forEach>

						<c:choose>
							<c:when test="${me.win}">
								<tr class="table-info">
							</c:when>
							<c:otherwise>
								<tr class="table-danger">
							</c:otherwise>
						</c:choose>

						<c:forEach var="style" items="${me.perks.styles}"
							varStatus="index">
							<c:if test="${index.count eq 1}">
								<c:forEach var="select" items="${style.selections}"
									varStatus="index2">
									<c:if test="${index2.count eq 1}">
										<c:set var="MainRune" value="${select.perk}" />
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>

						<c:set var="gameTime" value="${match.info.gameDuration}" />
						<c:set var="sec" value="${gameTime%60}" />
						<c:set var="min" value="${(gameTime-sec)/60}" />

						<td><c:choose>
								<c:when test="${me.win}">
									<p class="fs-5 fw-bold">승리</p>
								</c:when>
								<c:otherwise>
									<p class="fs-5 fw-bold">패배</p>
								</c:otherwise>
							</c:choose> <c:choose>
								<c:when test="${match.info.queueId eq '420'}">
									<h6>솔랭</h6>
								</c:when>
								<c:when test="${match.info.queueId eq '430'}">
									<h6>일반</h6>
								</c:when>
								<c:when test="${match.info.queueId eq '440'}">
									<h6>자랭</h6>>
												</c:when>
								<c:when test="${match.info.queueId eq '450'}">
									<h6>
										무작위 <br>총력전
									</h6>
								</c:when>
								<c:when test="${match.info.queueId eq '850'}">
									<h6>AI 상대대전</h6>
								</c:when>
							</c:choose> <fmt:parseNumber var="min" value="${min}" integerOnly="true" />
						</td>

						<td><img
							src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${me.championName}.png"
							style="width: 70px; height: 70px;"></td>

						<td><p>
								<img
									src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${me.summonerSpell1Name}.png"
									style="width: 30px; height: 30px;"> <img
									src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${me.summonerSpell2Name}.png"
									style="width: 30px; height: 30px;">
							<p>
								<img
									src="https://opgg-static.akamaized.net/images/lol/perk/${MainRune}.png"
									style="width: 30px; height: 30px;"></td>


						<td><c:set var="total" value="${me.kills + me.assists}" /> <c:set
								var="kda" value="${total /me.deaths}" /> <c:choose>
								<c:when test="${kda lt '2' }">
									<h6 class="fw-bolder" style="color: gray;">
										평점:
										<fmt:formatNumber value="${kda}" pattern="0.00" />
									</h6>
								</c:when>

								<c:when test="${kda lt '3' }">
									<h6 class="fw-bolder" style="color: green;">
										평점:
										<fmt:formatNumber value="${kda}" pattern="0.00" />
									</h6>
								</c:when>

								<c:when test="${kda lt '4' }">
									<h6 class="fw-bolder" style="color: blue;">
										평점:
										<fmt:formatNumber value="${kda}" pattern="0.00" />
									</h6>
								</c:when>

								<c:otherwise>
									<h6 class="fw-bolder" style="color: red;">
										평점:
										<fmt:formatNumber value="${kda}" pattern="0.00" />
									</h6>
								</c:otherwise>

							</c:choose>
							<h5 class="fw-lighter">${me.kills}/${me.deaths}/${me.assists}</h5>
						</td>

						<td><c:if test="${me.teamId eq '100' }">
								<c:set var="killParticipation" value="${total / teamTotalKill1}" />
							</c:if> <c:if test="${me.teamId eq '200' }">
								<c:set var="killParticipation" value="${total / teamTotalKill2}" />
							</c:if> <fmt:formatNumber type="percent" value="${killParticipation}"
								pattern="0%" /></td>

						<td>
							<table class="table table-bordered">
								<tbody>
									<tr>
										<c:forTokens var="item" delims=","
											items="${me.item0},${me.item1},${me.item2},${me.item3}">
											<c:if test="${item ne '0'}">
												<td><img
													src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/item/${item}.png"
													style="width: 30px; height: 30px;"></td>
											</c:if>
											<c:if test="${item eq '0'}">
												<td><img src="/img/item/none_item.png"
													style="width: 30px; height: 30px;"></td>
											</c:if>
										</c:forTokens>
									</tr>

									<tr>
										<c:forTokens var="item" delims=","
											items="${me.item4},${me.item5},${me.item6}">
											<c:if test="${item ne '0'}">
												<td><img
													src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/item/${item}.png"
													style="width: 30px; height: 30px;"></td>
											</c:if>
											<c:if test="${item eq '0'}">
												<td><img src="/img/item/none_item.png"
													style="width: 30px; height: 30px;"></td>
											</c:if>
										</c:forTokens>
									</tr>
								</tbody>
							</table>
						</td>
						<td>
							<table class="table table-bordered">
								<tbody>
									<tr>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${top1.championName}.png"
											style="width: 30px; height: 30px;"></td>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${jug1.championName}.png"
											style="width: 30px; height: 30px;"></td>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${mid1.championName}.png"
											style="width: 30px; height: 30px;"></td>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${ad1.championName}.png"
											style="width: 30px; height: 30px;"></td>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${sup1.championName}.png"
											style="width: 30px; height: 30px;"></td>
									</tr>
									<tr>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${top2.championName}.png"
											style="width: 30px; height: 30px;"></td>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${jug2.championName}.png"
											style="width: 30px; height: 30px;"></td>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${mid2.championName}.png"
											style="width: 30px; height: 30px;"></td>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${ad2.championName}.png"
											style="width: 30px; height: 30px;"></td>
										<td><img
											src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${sup2.championName}.png"
											style="width: 30px; height: 30px;"></td>
									</tr>
								</tbody>
							</table>
						</td>

						<td>
							<h6>${me.champLevel}LV</h6>
							<h6>${me.goldEarned}Gold</h6>
							<h6>${me.totalMinionsKilled}CS</h6>
						</td>

						<td><h6>${min}분${sec}초</h6></td>

						<td><button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#details${status.index}">
								<!-- Modal buttons -->
								더보기
							</button>

							<div class="modal fade bd-example-modal-lg"
								id="details${status.index}" tabindex="-1"
								aria-labelledby=detailsLabel " aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered modal-lg">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="detailsLabel">자세히 보기</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"></button>
										</div>
										<div class="modal-body">
											<table class="table">
												<thead>
													<tr>
														<th scope="col">챔피언</th>
														<th scope="col">소환사 이름</th>
														<th scope="col">스펠</th>
														<th scope="col">레벨</th>
														<th scope="col">KDA</th>
														<th scope="col">가한 피해량</th>
														<th scope="col">받은 피해량</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${top1.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${top1.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${top1.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${top1.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${top1.champLevel }</td>
														<td>${top1.kills}/${top1.deaths}/${top1.assists}(<fmt:formatNumber
																value="${top1.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-danger"
																	role="progressbar"
																	style="width: ${top1.totalDamageDealtToChampions/teamMaxDamage1 * 100}%"
																	aria-valuenow="${top1.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage1 }"></div>
															</div>
															<h6>${top1.totalDamageDealtToChampions}</h6></td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${top1.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${top1.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${top1.totalDamageTaken}</h6></td>
													</tr>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${jug1.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${jug1.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${jug1.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${jug1.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${jug1.champLevel }</td>
														<td>${jug1.kills}/${jug1.deaths}/${jug1.assists}(<fmt:formatNumber
																value="${jug1.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-danger"
																	role="progressbar"
																	style="width: ${jug1.totalDamageDealtToChampions/teamMaxDamage1 * 100}%"
																	aria-valuenow="${jug1.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage1 }"></div>
															</div>
															<h6>${jug1.totalDamageDealtToChampions}</h6></td>

														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${jug1.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${jug1.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${jug1.totalDamageTaken}</h6></td>

													</tr>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${mid1.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${mid1.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${mid1.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${mid1.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${mid1.champLevel }</td>
														<td>${mid1.kills}/${mid1.deaths}/${mid1.assists}(<fmt:formatNumber
																value="${mid1.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-danger"
																	role="progressbar"
																	style="width: ${mid1.totalDamageDealtToChampions/teamMaxDamage1 * 100}%"
																	aria-valuenow="${mid1.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage1 }"></div>
															</div>
															<h6>${mid1.totalDamageDealtToChampions}</h6></td>

														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${mid1.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${mid1.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${mid1.totalDamageTaken}</h6></td>

													</tr>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${ad1.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${ad1.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${ad1.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${ad1.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${ad1.champLevel }</td>
														<td>${ad1.kills}/${ad1.deaths}/${ad1.assists}(<fmt:formatNumber
																value="${ad1.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-danger"
																	role="progressbar"
																	style="width: ${ad1.totalDamageDealtToChampions/teamMaxDamage1 * 100}%"
																	aria-valuenow="${ad1.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage1 }"></div>
															</div>
															<h6>${ad1.totalDamageDealtToChampions}</h6></td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${ad1.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${ad1.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${ad1.totalDamageTaken}</h6></td>

													</tr>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${sup1.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${sup1.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${sup1.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${sup1.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${sup1.champLevel }</td>
														<td>${sup1.kills}/${sup1.deaths}/${sup1.assists}(<fmt:formatNumber
																value="${sup1.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-danger"
																	role="progressbar"
																	style="width: ${sup1.totalDamageDealtToChampions/teamMaxDamage1 * 100}%"
																	aria-valuenow="${sup1.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage1 }"></div>
															</div>
															<h6>${sup1.totalDamageDealtToChampions}</h6></td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${sup1.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${sup1.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${sup1.totalDamageTaken}</h6></td>
													</tr>
												</tbody>
											</table>

											<table class="table">
												<thead>
													<tr>
														<th scope="col">챔피언</th>
														<th scope="col">소환사 이름</th>
														<th scope="col">스펠</th>
														<th scope="col">레벨</th>
														<th scope="col">KDA</th>
														<th scope="col">가한 피해량</th>
														<th scope="col">받은 피해량</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${top2.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${top2.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${top2.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${top2.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${top2.champLevel}</td>
														<td>${top2.kills}/${top2.deaths}/${top2.assists}(<fmt:formatNumber
																value="${top2.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar bg-danger" role="progressbar"
																	style="width: ${top2.totalDamageDealtToChampions/teamMaxDamage2 * 100}%"
																	aria-valuenow="${top2.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage2 }"></div>
															</div>
															<h6>${top2.totalDamageDealtToChampions}</h6></td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${top2.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${top2.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${top2.totalDamageTaken}</h6></td>
													</tr>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${jug2.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${jug2.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${jug2.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${jug2.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${jug2.champLevel }</td>
														<td>${jug2.kills}/${jug2.deaths}/${jug2.assists}(<fmt:formatNumber
																value="${jug2.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar bg-danger" role="progressbar"
																	style="width: ${jug2.totalDamageDealtToChampions/teamMaxDamage2 * 100}%"
																	aria-valuenow="${jug2.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage2 }"></div>
															</div>
															<h6>${jug2.totalDamageDealtToChampions}</h6></td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${jug2.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${jug2.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${jug2.totalDamageTaken}</h6></td>


													</tr>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${mid2.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${mid2.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${mid2.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${mid2.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${mid2.champLevel }</td>
														<td>${mid2.kills}/${mid2.deaths}/${mid2.assists}(<fmt:formatNumber
																value="${mid2.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar bg-danger" role="progressbar"
																	style="width: ${mid2.totalDamageDealtToChampions/teamMaxDamage2 * 100}%"
																	aria-valuenow="${mid2.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage2 }"></div>
															</div>
															<h6>${mid2.totalDamageDealtToChampions}</h6></td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${mid2.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${mid2.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${mid2.totalDamageTaken}</h6></td>
													</tr>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${ad2.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${ad2.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${ad2.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${ad2.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${ad2.champLevel }</td>
														<td>${ad2.kills}/${ad2.deaths}/${ad2.assists}(<fmt:formatNumber
																value="${ad2.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar bg-danger" role="progressbar"
																	style="width: ${ad2.totalDamageDealtToChampions/teamMaxDamage2 * 100}%"
																	aria-valuenow="${ad2.totalDamageDealtToChampions/teamMaxDamage2 * 100}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage2}"></div>
															</div>
															<h6>${ad2.totalDamageDealtToChampions}</h6></td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${ad2.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${ad2.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${ad2.totalDamageTaken}</h6></td>
													</tr>
													<tr>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/champion/${sup2.championName}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${sup2.summonerName}</td>
														<td><img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${sup2.summonerSpell1Name}.png"
															style="width: 30px; height: 30px;"> <img
															src="http://ddragon.leagueoflegends.com/cdn/12.22.1/img/spell/${sup2.summonerSpell2Name}.png"
															style="width: 30px; height: 30px;"></td>
														<td>${sup2.champLevel }</td>
														<td>${sup2.kills}/${sup2.deaths}/${sup2.assists}(<fmt:formatNumber
																value="${sup2.kdas}" pattern="0.00" />)
														</td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-danger"
																	role="progressbar"
																	style="width: ${sup2.totalDamageDealtToChampions/teamMaxDamage2 * 100}%"
																	aria-valuenow="${sup2.totalDamageDealtToChampions}"
																	aria-valuemin="0" aria-valuemax="${teamMaxDamage2 }"></div>
															</div>
															<h6>${sup2.totalDamageDealtToChampions}</h6></td>
														<td><div class="progress">
																<div class="progress-bar progress-bar-striped bg-info"
																	role="progressbar"
																	style="width: ${sup2.totalDamageTaken/teamMaxTakenDamage1 * 100}%"
																	aria-valuenow="${sup2.totalDamageTaken}"
																	aria-valuemin="0"
																	aria-valuemax="${teamMaxTakenDamage1 }"></div>
															</div>
															<h6>${sup2.totalDamageTaken}</h6></td>
													</tr>
												</tbody>
											</table>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div></td>
					</c:forEach>
				</tr>
			</tbody>
		</table>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>