package com.lockdoor.gg.dto.summonerDto;

import lombok.Data;

@Data
public class LeagueEntryDTO {

	String leagueId;
	String summonerId;
	String summonername;
	String queueType;
	String tier;
	String rank;
	int leaguePoints;
	int wins;
	int losses;
	boolean hotStreak;
	boolean veteran;
	boolean freshBlood;
	boolean inactive;
}
