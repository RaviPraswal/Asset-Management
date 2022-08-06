package com.adj.amgmt.dto;

import javax.validation.Valid;
import javax.validation.constraints.Min;

import org.hibernate.validator.constraints.NotBlank;

import com.adj.amgmt.entity.Accessory;
import com.adj.amgmt.entity.Employee;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
public class AccessoryIssueDTO {

	private int id;

	private AccessoryDTO accessory;

	private EmployeeDTO issuedToEmployee;

	private String issuedToNonEmployee;

	@NotBlank(message = "This Field is Required")
	private String issueDate;

	@Min(value = 1)
	private int issueQuantity;

	private String remark;

}
