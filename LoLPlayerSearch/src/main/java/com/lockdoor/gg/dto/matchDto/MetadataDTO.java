package com.lockdoor.gg.dto.matchDto;

import java.util.List;

import lombok.Data;

@Data
public class MetadataDTO {
	public String dataVersion;
	public String matchId;
	public List<String> participants;
}
