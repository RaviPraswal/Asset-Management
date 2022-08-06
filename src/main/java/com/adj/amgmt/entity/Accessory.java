package com.adj.amgmt.entity;

import java.math.BigDecimal;

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

@Data
@Entity
@Table(name = "ACCESSORY")
public class Accessory {
	@Id
	@Column(name="ID")
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int id;
	
	@Column(name="SKU_NUMBER")
	private String skuNumber;
	
	@Column(name = "NAME")
	private String name;
	
	@ManyToOne
	@JoinColumn(name = "ACCESSORY_TYPE_ID")
	private AccessoryTypes accessoryType;
	
	@Column(name = "DESCRIPTION")
	private String description;

	@Column(name = "PURCHASE_DATE")
	private String purchaseDate;
	
	@Column(name = "UNIT_COST")
	private double cost;
	
	@Column(name = "PURCHASE_QUANTITY")
	private int purchaseQuantity;
	
	@Column(name = "VENDOR")
	private String vendor;
	
	@Column(name = "BILL_NUMBER")
	private String billNumber;
	
	@Column(name = "BILL_DOCUMENT_NAME")
	private String fileName;
	
	@Column(name = "BILL_DOCUMENT_ID")
	private String billFileId;
	
	@Transient
	private MultipartFile file;
	
}
