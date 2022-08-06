package com.adj.amgmt.dto;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

@Data
public class AssetAssignmentDTO {

	private int id;
	
	private AssetDTO asset;	

	private EmployeeDTO employee;

	@NotBlank
	private String issueDate;

	@NotBlank(message = "This Field is Required")
	private String issueCondition;

	private String issueRemark;

	private String returnDate;

	private String returnCondition;

	private String reruntRemark;
	
	private String status;

}
