package com.lockdoor.gg.dto.matchDto;

import java.util.List;

import lombok.Data;

@Data
public class PerkStyleDTO {
	public String description;
	public List<PerkStyleSelectionDTO> selections;
	public int style;
}
