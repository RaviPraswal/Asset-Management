package com.adj.amgmt.service;

import java.util.List;

import com.adj.amgmt.dto.AssetTypeDTO;
import com.adj.amgmt.entity.AssetTypes;

public interface AssetTypeService {

	public void saveAssetType(AssetTypeDTO assetTypeDTO);

	public void deleteAssetTypeById(int id);

	public AssetTypeDTO getAssetTypeById(int assetType);

	public void updateAssetType(AssetTypes assetType);

	public List<AssetTypeDTO> getAssetTypeList();
}
