package com.adj.amgmt.dto;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@SuppressWarnings("deprecation")
@Data
public class AssetDTO {

	private int id;

	@NotBlank(message = "This Field is Required")
	private String skuNumber;

	@NotBlank(message = "Name is required")
	private String name;

	private String description;

	@NotBlank(message = "This Field is Required")
	private String model;

	@NotBlank(message = "This Field is Required")
	private String purchaseDate;

	@NotBlank(message = "This Field is Required")
	private String waranty;

	@DecimalMin(value="0", inclusive=true)
	@NotNull(message = "This Field is Required")
	private double cost;

	@NotBlank(message = "This Field is Required")
	private String vendor;

	@NotBlank(message = "This Field is Required")
	private String billNo;

	private AssetTypeDTO assetType;

	private String parentAsset;

	@NotNull(message = "Please choose a file")
	private MultipartFile file;
	
	private String billFileName;
	private String billFileId;
	 

}
