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
@Table(name = "ACCESSORY_TYPES")
public class AccessoryTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID")
	private int id;

	@Column(name = "TYPE_NAME")
	private String typeName;

	@Column(name = "PARENT_TYPE")
	private String parentType;
}
