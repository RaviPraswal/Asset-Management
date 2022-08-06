package com.adj.amgmt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "ACCESSORY_ISSUES")
public class AccessoryIssue {

	@Id
	@Column(name = "ID")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;

	@ManyToOne
	@JoinColumn(name = "accessory_id")
	private Accessory accessory;

	@ManyToOne
	@JoinColumn(name = "employee_id")
	private Employee issuedToEmployee;

	@Column(name = "ISSUED_TO_NON_EMPLOYEE")
	private String issuedToNonEmployee;

	@Column(name = "ISSUE_DATE")
	private String issueDate;

	@Column(name = "ISSUE_QUANTITY")
	private int issueQuantity;

	@Column(name = "REMARK")
	private String remark;

}
