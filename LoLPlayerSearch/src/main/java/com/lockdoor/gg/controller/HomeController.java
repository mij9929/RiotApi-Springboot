package com.lockdoor.gg.controller;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lockdoor.gg.dto.matchDto.MatchDTO;
import com.lockdoor.gg.dto.summonerDto.LeagueEntryDTO;
import com.lockdoor.gg.dto.summonerDto.SummonerDTO;
import com.lockdoor.gg.service.RiotApiService;

@Controller
public class HomeController {

	@Autowired
	RiotApiService riotApiService;
	
	@GetMapping("/")
	public String home() {
		return "main";
	}

	@GetMapping("/search")
	public String search(@RequestParam String summonerName, Model model) {
		
		SummonerDTO summonerDto;
		summonerDto = riotApiService.SummonerInfo(summonerName);
		
		Set<LeagueEntryDTO> leagueEntryDTO= riotApiService.SummonerRank(summonerDto.getId());
		List<MatchDTO>matches = riotApiService.recentMatchList(summonerDto.getPuuid());
		model.addAttribute("summoner", summonerDto);
		model.addAttribute("leagueEntry", leagueEntryDTO);
		model.addAttribute("matches", matches);
		return "search";
	}
	
}
