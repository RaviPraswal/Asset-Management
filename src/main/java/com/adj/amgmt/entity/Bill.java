package com.adj.amgmt.entity;

import javax.persistence.Id;
import javax.persistence.Lob;

import org.bson.types.Binary;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Document(collection = "Bill")
public class Bill {

	
	@Id
	private String id;
	private String fileName;
	private Binary fileBill;

	@Lob
	private byte[] data;

	private String type;
}
