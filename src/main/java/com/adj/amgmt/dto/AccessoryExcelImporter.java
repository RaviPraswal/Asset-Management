package com.adj.amgmt.dto;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.adj.amgmt.entity.Accessory;

public class AccessoryExcelImporter {

	public static String TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	static String[] HEADERs = {"skuNumber", "name","Purchase Date","purchase Qty","cost, vendor", "billNumber","bill-document"};
	static String SHEET = "AccessoryData";

	public static boolean hasExcelFormat(MultipartFile file) {
		if (!TYPE.equals(file.getContentType())) {
			return false;
		}
		return true;
	}

	public static List<Accessory> excelToAccessory(InputStream is) throws IOException {
		try {
			Workbook workbook = new XSSFWorkbook(is);
			Sheet sheet = workbook.getSheet(SHEET);
			Iterator<Row> rows = sheet.iterator();
			List<Accessory> accessoryList = new ArrayList<Accessory>();
			int rowNumber = 0;
			while (rows.hasNext()) {
				Row currentRow = rows.next();
				// skip header
				if (rowNumber == 0) {
					rowNumber++;
					continue;
				}
				Iterator<Cell> cellsInRow = currentRow.iterator();
				Accessory accessory = new Accessory();
				int cellIdx = 0;
				while (cellsInRow.hasNext()) {
					Cell currentCell = cellsInRow.next();
					System.out.println("cell------------- " +currentCell.getColumnIndex());
					switch (cellIdx) {
					case 0:
						accessory.setSkuNumber(currentCell.getStringCellValue());
						break;
					case 1:
						accessory.setName(currentCell.getStringCellValue());
						break;
					case 2:
						accessory.setPurchaseDate(currentCell.getStringCellValue());
						break;
					case 3:
						accessory.setPurchaseQuantity((int) currentCell.getNumericCellValue());
						break;
					case 4:
						double cost=currentCell.getNumericCellValue();
						accessory.setCost(cost);
						System.out.println("cost-------- " +accessory.getCost());
						break;
					case 5:
						accessory.setVendor(currentCell.getStringCellValue());
						break;
					case 6:
						accessory.setBillNumber(currentCell.getStringCellValue());
						break;
					case 7:
						accessory.setFileName(currentCell.getStringCellValue());
						break;

					default:
						break;
					}
					cellIdx++;					
				}
				accessoryList.add(accessory);
				workbook.close();
			}
			return accessoryList;
		} catch (IOException e) {
			throw new RuntimeException("fail to parse Excel file: " + e.getMessage());

		}
	}
}
