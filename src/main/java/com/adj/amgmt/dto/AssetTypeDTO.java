package com.adj.amgmt.dto;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class AssetTypeDTO {

	private int id;
	
	
	@NotBlank(message = "This Field is Required")
	private String typeName;
	private String parentType;
}
