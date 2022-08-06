package com.adj.amgmt.service;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.adj.amgmt.dto.AssetDTO;
import com.adj.amgmt.dto.AssetTypeDTO;
import com.adj.amgmt.entity.AssetTypes;
import com.adj.amgmt.repository.AssetTypeRepository;

import lombok.Getter;
import lombok.Setter;

@Service
@Getter
@Setter
public class AssetTypesServiceImpl {

	@Autowired
	AssetTypeRepository assetTypeRepository;

	@Autowired
	AssetsServiceImpl assetsService;

	@Autowired
	ModelMapper modelMapper;

	public void saveAssetType(AssetTypeDTO assetTypeDTO) {
		try {
			AssetTypes assetType = modelMapper.map(assetTypeDTO, AssetTypes.class);
			assetTypeRepository.saveAndFlush(assetType);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public void deleteAssetTypeById(int id) {

		/*try {
			List<AssetDTO> assetList = assetsService.getAssetList();
			boolean flag = false;
			for (AssetDTO assetDTO : assetList) {
				if (assetDTO.getAssetType().getId() == id) {
					flag = true;// it means we have a mapping of asset with asset type
					break;
				} else {
					flag = false;
				}
			}
			if (flag == false) {
				return true;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return false;*/
		assetTypeRepository.deleteById(id);
	}

	public AssetTypeDTO getAssetTypeById(int assetType) {
		try {
			AssetTypes assetTypeById = assetTypeRepository.getById(assetType);
			AssetTypeDTO assetTypeDTO = modelMapper.map(assetTypeById, AssetTypeDTO.class);
			return assetTypeDTO;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;

	}

	public void updateAssetType(AssetTypes assetType) {
		try {
			assetTypeRepository.saveAndFlush(assetType);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	public List<AssetTypeDTO> getAssetTypeList() {
		try {
			List<AssetTypes> assetTypeList = assetTypeRepository.findAll();
			List<AssetTypeDTO> assetTypeListDTO = modelMapper.map(assetTypeList,
					((TypeToken<List<AssetTypeDTO>>) new TypeToken<List<AssetTypeDTO>>() {
					}).getType());
			getParentTypes(assetTypeListDTO);
			return assetTypeListDTO;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	public List<String> getParentTypes(List<AssetTypeDTO> assetTypeListDTO) {
		List<String> parentTypeList = new ArrayList<String>();
		for (AssetTypeDTO assetTypeDTO : assetTypeListDTO) {
			String typeName = assetTypeDTO.getTypeName();
			parentTypeList.add(typeName);
		}
		return parentTypeList;
	}

}
