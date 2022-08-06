package com.adj.amgmt.dto;

import java.math.BigDecimal;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AccessoryDTO {
	private int id;
	
	@NotBlank(message = "This Field is Required")
	private String skuNumber;
	
	@NotBlank(message = "This Field is Required")
	private String name;
	
	private AccessoryTypesDTO accessoryType;
	
	private String description;

	@NotBlank(message = "This Field is Required")
	private String purchaseDate;
	
	@DecimalMin(value="0", inclusive=true)
	@NotNull(message = "This Field is Required")
	private double cost;
	
	@NotNull(message = "This Field is Required")
	@Min(value = 1)
	private int purchaseQuantity;
	
	@NotNull(message = "This Field is Required")
	private String vendor;
	
	@NotNull(message = "This Field is Required")
	private String billNumber;
	
	@NotNull(message = "Please choose a file")
	private MultipartFile file;
	
	private String billFileName;
	private String billFileId;
	
}
