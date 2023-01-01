package com.lockdoor.gg.dto.matchDto;

import java.util.List;

import lombok.Data;

@Data
public class ParticipantDTO {
	public int assists;
	public int kills;
	public int deaths;
	public double kdas;
	public String mainRune;
	public List<String> subRunes;
	/*public int baronKills;
	public int bountyLevel;
	public int champExperience;*/
	public int champLevel;
	public int championId;
	public String championName;
	/*public int championTransform;
	public int consumablesPurchased;
	public int damageDealtToBuildings;
	public int damageDealtToObjectives;
	public int damageDealtToTurrets;
	public int damageSelfMitigated;*/
	
	/*public int detectorWardsPlaced;
	public int doubleKills;
	public int dragonKills;
	public boolean firstBloodAssist;
	public boolean firstBloodKill;
	public boolean firstTowerAssist;
	public boolean firstTowerKill;
	public boolean gameEndedlnEarlySurrender;
	public boolean gameEndedlnSurrender;*/
	public int goldEarned;
	public int goldSpent;
	/*public String individualPosition;
	public int inhibitorKills;
	public int inhibitorTakedowns;
	public int inhibitorsLost;*/
	public int item0;
	public int item1;
	public int item2;
	public int item3;
	public int item4;
	public int item5;
	public int item6;
	//public int itemsPurchased;
	//public int killingSprees;
	
	public String lane;
	/*public int largestCriticalStrike;
	public int largestKillingSpree;
	public int largestMultiKill;
	public int longestTimeSpentLiving;
	public int magicDamageDealt;
	public int magicDamageDealtToChampions;
	public int magicDamageTaken;
	public int neutralMinionsKilled;
	public int nexusKills;
	public int nexusLost;
	public int objectiveStolen;
	public int objectviesStolenAssists;*/
	public int participantId;
	//public int pentaKills;
	public PerksDTO perks;
	/*public int physicalDamageDealt;
	public int physicalDamageDealtToChampions;
	public int physicalDamageTaken;
	public int profileIcon;
	public String puuid;
	//public int quadraKills;
	public String riotIdName;
	public String riotIdTagline;*/
	/*public String role;
	public int sightWardsBoughtInGame;
	public int spell1Casts;
	public int spell2Casts;
	public int spell3Casts;
	public int spell4Casts;
	*/
	public int summoner1Casts;
	public int summoner1Id;
	public int summoner2Casts;
	public int summoner2Id;
	public String summonerSpell1Name;
	public String summonerSpell2Name;
/*	public String summonerId;
	public int summonerLevel;*/
	public String summonerName;
	//public boolean teamEarlySurrendered;
	public int teamId;
	public String teamPosition;
	/*public int timeCCingOthers;
	public int timePlayed;*/
	public int totalDamageDealt;
	public int totalDamageDealtToChampions;
	public int totalDamageShieldedOnTeammates;
	public int totalDamageTaken;
	public int totalHeal;
	public int totalHealsOnteammates;
	public int totalMinionsKilled;
	/*public int totalTimeCCDealt;
	public int totalTimeSpentDead;
	public int totalUnitsHealed;
	public int tripleKills;
	public int trueDamageDealt;
	public int trueDamageDealtToChamipons;
	public int trueDamageTaken;
	public int turretKills;
	public int turretTakedowns;
	public int turretsLost;
	public int unrealKills;
	public int visionScore;
	public int visionWardsBoughtInGame;
	public int wardsKilled;
	public int wardsPlaced;*/
	public boolean win;
	
	public void setKda() {
		double kda = (double)(this.kills+this.assists)/this.deaths;
		this.kdas = kda;
	}

	
}
