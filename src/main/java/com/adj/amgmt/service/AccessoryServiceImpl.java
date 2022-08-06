package com.adj.amgmt.service;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import org.bson.BsonBinarySubType;
import org.bson.types.Binary;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.adj.amgmt.dto.AccessoryDTO;
import com.adj.amgmt.dto.AccessoryExcelImporter;
import com.adj.amgmt.dto.AccessoryIssueDTO;
import com.adj.amgmt.dto.AssetExcelImporter;
import com.adj.amgmt.entity.Accessory;
import com.adj.amgmt.entity.Asset;
import com.adj.amgmt.entity.Bill;
import com.adj.amgmt.repository.AccessoryRepository;
import com.adj.amgmt.repository.BillRepository;

import lombok.Getter;
import lombok.Setter;

@Service
@Getter
@Setter
public class AccessoryServiceImpl implements AccessoryService {

	@Autowired
	AccessoryRepository accessoryRepository;

	@Autowired
	BillRepository billRepo;

	@Autowired
	AccessoryIssueService accessoryIssueService;

	@Autowired
	ModelMapper modelMapper;

	public void saveAccessory(AccessoryDTO accessoryDTO) {
		Bill bill = new Bill();
		String fileName = "";
		try {
			Accessory accessory = modelMapper.map(accessoryDTO, Accessory.class);

			fileName = accessory.getFile().getOriginalFilename();
			accessory.setFileName(fileName);

			bill.setFileName(fileName);
			bill.setFileBill(new Binary(BsonBinarySubType.BINARY, accessory.getFile().getBytes()));
			Bill savedBill = billRepo.insert(bill);

			accessory.setFileName(accessoryDTO.getFile().getOriginalFilename());
			accessory.setBillFileId(savedBill.getId());
			accessoryRepository.saveAndFlush(accessory);
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	public boolean deleteAccessoryBySkuId(int id) {

		try {
			List<AccessoryIssueDTO> accessoryIssuesList = accessoryIssueService.getAccessoryIssuesList();
			boolean flag = false;
			for (AccessoryIssueDTO accessoryIssueDTO : accessoryIssuesList) {
				AccessoryDTO accessory = accessoryIssueDTO.getAccessory();
				if (accessory.getId() == id) {
					flag = true;
					break;
				} else {
					flag = false;
				}
			}
			if (flag == false) {
				accessoryRepository.deleteById(id);
				return true;
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;
	}

	public void updateAccessory(Accessory accessory) {
		try {
			accessoryRepository.saveAndFlush(accessory);
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	public List<AccessoryDTO> getAccessoryList() {
		try {
			List<Accessory> accessoryList = accessoryRepository.findAll();
			List<AccessoryDTO> accessoryListDTO = Arrays.asList(modelMapper.map(accessoryList, AccessoryDTO[].class));
			return accessoryListDTO;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	public AccessoryDTO getAccessoryById(int accessoryId) {

		try {
			Accessory accessory = accessoryRepository.getById(accessoryId);
			AccessoryDTO accessoryDTO = modelMapper.map(accessory, AccessoryDTO.class);
			//accessoryDTO.setBillFileName(accessory.getFileName());
			return accessoryDTO;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	//method to get data excel from database	
		public void saveExcelData(MultipartFile file) {
		    try {
		      List<Accessory> accessoryList = AccessoryExcelImporter.excelToAccessory(file.getInputStream());
		      System.out.println("assets service-----------------  " +accessoryList);
		      accessoryRepository.saveAll(accessoryList);
		    } catch (IOException e) {
		      throw new RuntimeException("fail to store excel data: " + e.getMessage());
		    }
		  }


}
