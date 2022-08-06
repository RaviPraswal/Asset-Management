
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

@Entity
@Data
@Table(name = "ASSET_ASSIGNMENT")
public class AssetAssignment {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID")
	private int id;
	
	@ManyToOne
	@JoinColumn(name = "asset_id")
	private Asset asset;	

	@ManyToOne
	@JoinColumn(name = "employee_id")
	private Employee employee;

	@Column(name = "ISSUE_DATE", nullable = false)
	private String issueDate;

	@Column(name = "ISSUE_CONDITION")
	private String issueCondition;

	@Column(name = "ISSUE_REMARK")
	private String issueRemark;

	@Column(name = "RETURN_DATE")
	private String returnDate;

	@Column(name = "RETURN_CONDITION")
	private String returnCondition;

	@Column(name = "RETURN_REMARK")
	private String reruntRemark;
	
	@Column(name = "STATUS")
	private String status;

	
}
