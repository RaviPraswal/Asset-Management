package com.adj.amgmt.service;

import java.util.List;

import com.adj.amgmt.dto.AccessoryTypesDTO;
import com.adj.amgmt.entity.AccessoryTypes;

public interface AccessoryTypeService {
	public void saveAccessoryType(AccessoryTypesDTO accessoryTypeDTO);

	public boolean deleteAccessoryTypeById(int id);

	public void updateAccessoryType(AccessoryTypes accessoryType);

	public List<AccessoryTypesDTO> getAccessoryTypeList();

	public AccessoryTypesDTO getAccessoryTypeId(int accessoryTypeId);
}
