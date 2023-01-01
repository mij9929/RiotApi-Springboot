package com.lockdoor.gg.service;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.lockdoor.gg.dto.matchDto.MatchDTO;
import com.lockdoor.gg.dto.summonerDto.LeagueEntryDTO;
import com.lockdoor.gg.dto.summonerDto.SummonerDTO;
import com.lockdoor.gg.exception.RestTeamplateErrorHandler;

@Service
public class RiotApiService {

	private static final String summoner = "https://kr.api.riotgames.com/lol/summoner/v4/summoners/by-name/";
	private static final String tier = "https://kr.api.riotgames.com/lol/league/v4/entries/by-summoner/";
	private static final String matchIds = "https://asia.api.riotgames.com/lol/match/v5/matches/by-puuid/";
	private static final String matches_game_info = "https://asia.api.riotgames.com//lol/match/v5/matches/";
	private static final String token = "X-Riot-Token";
	private static final String key = "RGAPI-fa826d07-5212-4a27-83cf-6c50bc5141b4";
	private static final String url = "https://developer.riotgames.com";

	public String setSpellName(int spellKey) {
		String spellName = "";
		Map<Integer, String> spellMap = new HashMap<Integer, String>();

		JSONParser parser = new JSONParser();

		try {
			FileReader reader = new FileReader(
					"/Users/user/Documents/workspace/LoLPlayerSearch/src/main/resources/static/json/summonerSpell.json");
			Object obj = parser.parse(reader);
			JSONObject jsonObj = (JSONObject) obj;

			reader.close();

			JSONObject data = (JSONObject) jsonObj.get("data");

			Iterator<String> iterator = data.keySet().iterator();

			while (iterator.hasNext()) {
				String spell = iterator.next();
				JSONObject spellData = (JSONObject) data.get(spell);
				String key = spellData.get("key").toString();

				if (spellKey == Integer.parseInt(key)) {
					spellName = spell;
				}
			}

			return spellName;

		} catch (IOException | ParseException e) {
			e.printStackTrace();
		}

		return "error";
	}

	public static final HttpHeaders StaticHeaders() {

		HttpHeaders headers = new HttpHeaders();

		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers.add("Origin", url);
		headers.add(token, key);

		return headers;

	}

	public SummonerDTO SummonerInfo(String summonerName) { // SummonerName = 소환
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.setErrorHandler(new RestTeamplateErrorHandler());

		// Header
		HttpHeaders headers = StaticHeaders();

		// request
		HttpEntity<SummonerDTO> httpEntity = new HttpEntity<SummonerDTO>(headers);
		ResponseEntity<SummonerDTO> responseEntity = restTemplate.exchange(summoner + summonerName, HttpMethod.GET,
				httpEntity, SummonerDTO.class);

		SummonerDTO summonerDto = responseEntity.getBody();

		return summonerDto;

	}

	public Set<LeagueEntryDTO> SummonerRank(String encryptedSummonerId) {
		RestTemplate restTemplate = new RestTemplate();

		// Header
		HttpHeaders headers = StaticHeaders();

		// request
		HttpEntity<Set<LeagueEntryDTO>> httpEntity = new HttpEntity<Set<LeagueEntryDTO>>(headers);
		ResponseEntity<Set> responseEntity = restTemplate.exchange(tier + encryptedSummonerId, HttpMethod.GET,
				httpEntity, Set.class);

		Set<LeagueEntryDTO> leagueEntryDTO = responseEntity.getBody();

		return leagueEntryDTO;

	}

	public MatchDTO matchInfo(String gameId) {

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = StaticHeaders();

		HttpEntity<MatchDTO> httpEntity = new HttpEntity<MatchDTO>(headers);
		ResponseEntity<MatchDTO> responseEntity = restTemplate.exchange(matches_game_info + gameId, HttpMethod.GET,
				httpEntity, MatchDTO.class);

		MatchDTO match = responseEntity.getBody();

		// 스펠 번호에 해당하는 스펠 이름 Set
		for (int i = 0; i < match.getInfo().getParticipants().size(); i++) {
			int spell1 = match.getInfo().getParticipants().get(i).getSummoner1Id();
			int spell2 = match.getInfo().getParticipants().get(i).getSummoner2Id();
			match.getInfo().getParticipants().get(i).setSummonerSpell1Name(setSpellName(spell1));
			match.getInfo().getParticipants().get(i).setSummonerSpell2Name(setSpellName(spell2));
			match.getInfo().getParticipants().get(i).setKda();
		}

		// 라인 설정
		ArrayList<String> lineList = new ArrayList<>();
		lineList.add("TOP");
		lineList.add("JUNGLE");
		lineList.add("MIDDLE");
		lineList.add("BOTTOM");
		lineList.add("UTILITY");

		if (match.getInfo().queueId == 450) { // 450 == 무작위 총력전, 아무 라인
			int index1 = 0;
			int index2 = 0;
			for (int i = 0; i < 10; i++) {
				if (match.getInfo().getParticipants().get(i).teamId == 100) {
					match.getInfo().getParticipants().get(i).setTeamPosition(lineList.get(index1));
					index1++;
				} else {
					match.getInfo().getParticipants().get(i).setTeamPosition(lineList.get(index2));
					index2++;
				}
			}
		}
		return match;
	}

	public List<MatchDTO> recentMatchList(String puuid) {
		RestTemplate restTemplate = new RestTemplate();

		// Header
		HttpHeaders headers = StaticHeaders();

		HttpEntity<List<String>> httpEntity = new HttpEntity<List<String>>(headers);

		ResponseEntity<List> responseEntity = restTemplate.exchange(matchIds + puuid + "/ids", HttpMethod.GET,
				httpEntity, List.class);
		List<String> matchIds = responseEntity.getBody();

		List<MatchDTO> matchList = new ArrayList<>();
		for (int i = 0; i < matchIds.size(); i++) {
			MatchDTO match = this.matchInfo(matchIds.get(i));
			matchList.add(match);
		}

		return matchList;

	}

}