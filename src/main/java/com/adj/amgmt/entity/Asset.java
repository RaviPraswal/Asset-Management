package com.adj.amgmt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Entity
@Table(name = "ASSETS")
@Data
public class Asset {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ASSET_ID")
	private int id;

	@Column(name = "SKU_NUMBER")
	private String skuNumber;

	@Column(name = "NAME", nullable = false)
	private String name;

	@Column(name = "DESCRIPTION", nullable = false)
	private String description;

	@Column(name = "MODEL", nullable = false)
	private String model;

	@Column(name = "PURCHASE_DATE", nullable = false)
	private String purchaseDate;

	@Column(name = "WARANTY", nullable = false)
	private String waranty;

	@Column(name = "COST", nullable = false)
	private double cost;

	@Column(name = "VENDOR", nullable = false)
	private String vendor;

	@Column(name = "BILL_NO", nullable = false)
	private String billNo;
	
	@ManyToOne
	@JoinColumn(name = "assetType_id")
	private AssetTypes assetType;

	@Column(name = "parent_Asset")
	private String parentAsset;

	@Transient
	private MultipartFile file;              
	
	@Column(name = "BILL_DOCUMENT_NAME")
	private String fileName;
	
	@Column(name = "BILL_DOCUMENT_ID")
	private String billFileId;
	
	
}
