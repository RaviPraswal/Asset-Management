package com.adj.amgmt.service;

import java.util.List;

import com.adj.amgmt.dto.AssetDTO;
import com.adj.amgmt.entity.Asset;
import com.adj.amgmt.entity.AssetTypes;

public interface AssetService {
	public List<AssetTypes> loadAssetTypes();
	public void save(AssetDTO assetDTO);
	public void deleteAssetById(int id);
	public void updateAsset(Asset asset);
	public List<AssetDTO> getAssetList();
	public AssetDTO getAssetById(int assetId);
	//void getDataFromExcel(MultipartFile excelFile) throws EncryptedDocumentException, IOException;
}
