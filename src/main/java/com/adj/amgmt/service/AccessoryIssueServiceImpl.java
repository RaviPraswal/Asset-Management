package com.adj.amgmt.service;

import java.util.List;
import java.util.Optional;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adj.amgmt.dto.AccessoryDTO;
import com.adj.amgmt.dto.AccessoryIssueDTO;
import com.adj.amgmt.entity.Accessory;
import com.adj.amgmt.entity.AccessoryIssue;
import com.adj.amgmt.repository.AccessoryIssueRepository;
import com.adj.amgmt.repository.AccessoryRepository;

import lombok.Getter;
import lombok.Setter;

@Service
@Getter
@Setter
public class AccessoryIssueServiceImpl implements AccessoryIssueService {

	@Autowired
	AccessoryIssueRepository accessoryIssueRepository;

	@Autowired
	AccessoryRepository accessoryRepository;

	@Autowired
	ModelMapper modelMapper;

	public List<AccessoryIssueDTO> getAccessoryIssuesList() {

		try {
			List<AccessoryIssue> accessoryIssueList = accessoryIssueRepository.findAll();
			List<AccessoryIssueDTO> accessoryIssueListDTO = modelMapper.map(accessoryIssueList,
					((TypeToken<List<AccessoryIssueDTO>>) new TypeToken<List<AccessoryIssueDTO>>() {
					}).getType());
			return accessoryIssueListDTO;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	public boolean saveAccessoryIssue(AccessoryIssueDTO accessoryIssueDTO) {

		try {
			AccessoryIssue accessoryIssue = modelMapper.map(accessoryIssueDTO, AccessoryIssue.class);
			AccessoryDTO accessory = accessoryIssueDTO.getAccessory();// accessory from form
			Optional<Accessory> accessoryById = accessoryRepository.findById(accessory.getId());// accessory from DB
			if (accessoryIssueDTO.getIssueQuantity() > accessoryById.get().getPurchaseQuantity()) {
				return false;
			} else if (accessoryIssueDTO.getIssueQuantity() <= accessoryById.get().getPurchaseQuantity()) {
				accessoryIssueRepository.saveAndFlush(accessoryIssue);
				accessoryById.get().setPurchaseQuantity(
						(accessoryById.get().getPurchaseQuantity() - accessoryIssueDTO.getIssueQuantity()));
				accessoryRepository.save(accessoryById.get());
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;

	}

	public void deleteAccessoryIssueById(int id) {
		try {
			accessoryIssueRepository.deleteById(id);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public void updateAccessoryIssue(AccessoryIssue accessoryIssues) {
		try {
			accessoryIssueRepository.saveAndFlush(accessoryIssues);
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	public AccessoryIssueDTO getAccessoryIssueById(int accessoryIssueId) {
		try {
			AccessoryIssue accessoryIssue = accessoryIssueRepository.getReferenceById(accessoryIssueId);
			AccessoryIssueDTO accessoryIssueDTO = modelMapper.map(accessoryIssue, AccessoryIssueDTO.class);
			return accessoryIssueDTO;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
		
	}

}
