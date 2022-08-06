package com.adj.amgmt.service;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adj.amgmt.dto.AccessoryDTO;
import com.adj.amgmt.dto.AccessoryTypesDTO;
import com.adj.amgmt.entity.AccessoryTypes;
import com.adj.amgmt.repository.AccessoryTypeRepository;

import lombok.Getter;
import lombok.Setter;

@Service
@Getter
@Setter
public class AccessoryTypesServiceImpl implements AccessoryTypeService {

	@Autowired
	AccessoryTypeRepository accessoryTypesRepository;

	@Autowired
	AccessoryService accessoryService;

	@Autowired
	ModelMapper modelMapper;

	public void saveAccessoryType(AccessoryTypesDTO accessoryTypeDTO) {
		try {
			AccessoryTypes accessoryType = modelMapper.map(accessoryTypeDTO, AccessoryTypes.class);
			accessoryTypesRepository.saveAndFlush(accessoryType);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean deleteAccessoryTypeById(int id) {

		try {
			List<AccessoryDTO> accessoryList = accessoryService.getAccessoryList();
			boolean flag = false;
			for (AccessoryDTO accessoryDTO : accessoryList) {
				if (accessoryDTO.getAccessoryType().getId() == id) {
					flag = true;// it means we have a mapping of accessory with accessory type
					break;
				} else {
					flag = false;
				}
			}
			if (flag == false) {
				accessoryTypesRepository.deleteById(id);
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;

	}

	public void updateAccessoryType(AccessoryTypes accessoryType) {
		try {
			accessoryTypesRepository.saveAndFlush(accessoryType);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public List<AccessoryTypesDTO> getAccessoryTypeList() {
		try {
			List<AccessoryTypes> accessoryTypeList = accessoryTypesRepository.findAll();
			List<AccessoryTypesDTO> accessoryTypeListDTO = modelMapper.map(accessoryTypeList,
					((TypeToken<List<AccessoryTypesDTO>>) new TypeToken<List<AccessoryTypesDTO>>() {
					}).getType());
			getParentTypes(accessoryTypeListDTO);
			return accessoryTypeListDTO;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<String> getParentTypes(List<AccessoryTypesDTO> accessoryTypeListDTO) {
		List<String> parentTypeList = new ArrayList<String>();
		for (AccessoryTypesDTO accessoryTypeDTO : accessoryTypeListDTO) {
			String typeName = accessoryTypeDTO.getTypeName();
			parentTypeList.add(typeName);
		}
		return parentTypeList;
	}

	public AccessoryTypesDTO getAccessoryTypeId(int accessoryTypeId) {
		try {
			AccessoryTypes accessoryType = accessoryTypesRepository.getById(accessoryTypeId);
			AccessoryTypesDTO accessoryTypeDTO = modelMapper.map(accessoryType, AccessoryTypesDTO.class);
			return accessoryTypeDTO;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
