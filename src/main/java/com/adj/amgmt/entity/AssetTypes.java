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
@Table(name = "ASSET_TYPES")
public class AssetTypes {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ASSET_TYPE_ID")
	private int id;
	
	@Column(name = "TYPE_NAME")
	private String typeName;
	
	@Column(name = "PARENT_TYPE")
	private String parentType;
	
		
}
