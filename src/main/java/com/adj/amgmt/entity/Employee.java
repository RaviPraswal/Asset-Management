
package com.adj.amgmt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "EMPLOYEE")
public class Employee {

	@Id

	@GeneratedValue(strategy = GenerationType.AUTO)

	@Column(name = "ID")
	private Integer employeeId;

	@Column(name = "EMAIL")
	private String email;

	@Column(name = "FIRST_NAME")
	private String firstName;

	@Column(name = "LAST_NAME")
	private String lastName;

	// unidirectional
	// 1.
	// @OneToOne(cascade = CascadeType.ALL)
	// Account account;

	// 1.1
	// @OneToOne(cascade = CascadeType.ALL)
	// @JoinTable(name = "EMPLOYEE_ACCOUNT", joinColumns = @JoinColumn(name =
	// "EMPLOYEE_ID", referencedColumnName = "ID"), inverseJoinColumns =
	// @JoinColumn(name = "ACCOUNT_ID", referencedColumnName = "ID", unique = true))
	// Account account;

	// bidirectional
	// 2.
	// @OneToOne
	// @PrimaryKeyJoinColumn
	// private Account account;

	// OneToMany
	// 1.
	//@OneToMany(cascade=CascadeType.ALL)
	//@JoinColumn(name="EMPLOYEE_ID")
	//private Set<Account> accounts;

	
	// 2. 
	// @OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	// @JoinTable(name = "EMPLOYEE_ACCOUNT", joinColumns = {  @JoinColumn(name="EMPLOYEE_ID",referencedColumnName="ID")},inverseJoinColumns={ @JoinColumn(name = "ACCOUNT_ID", referencedColumnName = "ID") }) 
	//private Set<Account> accounts;

	
	//@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	//@JoinTable(name = "EMPLOYEE_ASSET", joinColumns = {@JoinColumn(referencedColumnName = "ID") }, inverseJoinColumns = {@JoinColumn(referencedColumnName = "SKU_NUMBER") })
	//private List<Asset> assets;

}
