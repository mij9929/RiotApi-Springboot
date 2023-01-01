package com.lockdoor.gg.dto.matchDto;

import java.util.List;

import lombok.Data;

@Data
public class InfoDTO {
	public long gameCreation;
	public long gameDuration;
	public long gameEndTimestamp;
	public long gameId;
	public String gameMode;
	public String gameName;
	public long gameStartTimestamp;
	public String gameType;
	public String gameVersion;
	public List<ParticipantDTO> participants;
	public int queueId;
	public List<TeamDTO> teams;
	public String tournamentCode;
	
}
