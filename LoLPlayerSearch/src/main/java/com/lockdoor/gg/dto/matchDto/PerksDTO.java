package com.lockdoor.gg.dto.matchDto;

import java.util.List;

import lombok.Data;

@Data
public class PerksDTO {
	public PerkStatsDTO statPerks;
	public List<PerkStyleDTO> styles;

}
