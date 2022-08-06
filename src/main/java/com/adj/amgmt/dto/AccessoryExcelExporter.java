package com.adj.amgmt.dto;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class AccessoryExcelExporter {

	private XSSFWorkbook workbook;
    private XSSFSheet sheet;
	private List<AccessoryDTO> accessoryList;
	
	public AccessoryExcelExporter(List<AccessoryDTO> accessoryList) {
		this.accessoryList = accessoryList;
		workbook= new XSSFWorkbook();
	}
	private void writeHeaderLine() {
		sheet = workbook.createSheet("Assets");
		Row row = sheet.createRow(0);
		 CellStyle style = workbook.createCellStyle();
		 System.out.println("after cell style    ");
	        XSSFFont font = workbook.createFont();
	        System.out.println("after font   ");
	        font.setBold(true);
	        font.setFontHeight(14);
	        style.setFont(font);
	         
	        createCell(row, 0, "#", style);      
	        createCell(row, 1, "Sku number", style);       
	        createCell(row, 2, "Name", style);
	        createCell(row, 3, "Purchase Date", style);
	        createCell(row, 4, "Purchase Qty", style);
	        createCell(row, 5, "Cost", style);
	        createCell(row, 6, "Vendor", style);
	        createCell(row, 7, "Bill-Number", style);
	        createCell(row, 8, "Bill-Document", style);
		
	}
	 private void createCell(Row row, int columnCount, Object value, CellStyle style) {
	        sheet.autoSizeColumn(columnCount);
	        Cell cell = row.createCell(columnCount);
	        if (value instanceof Integer) {
	            cell.setCellValue((Integer) value);
	        } else if (value instanceof Boolean) {
	            cell.setCellValue((Boolean) value);
	        }else {
	            cell.setCellValue((String) value);
	        }
	        cell.setCellStyle(style);
	    }
	private void writeDataLine() throws IOException {
		int rowCount = 1;
		 
        CellStyle style = workbook.createCellStyle();
        XSSFFont font = workbook.createFont();
        font.setFontHeight(14);
        style.setFont(font);
                 
       for (AccessoryDTO accessoryDTO : accessoryList) {		
		
        	//System.out.println("exporter   " +assetDTO.getName());
            Row row = sheet.createRow(rowCount++);
            int columnCount = 0;
             
            createCell(row, columnCount++, accessoryDTO.getId(), style);
            createCell(row, columnCount++, accessoryDTO.getSkuNumber(), style);
            createCell(row, columnCount++, accessoryDTO.getName(), style);
            createCell(row, columnCount++, accessoryDTO.getPurchaseDate(), style);
            createCell(row, columnCount++, accessoryDTO.getPurchaseQuantity(), style);
            createCell(row, columnCount++, String.valueOf(accessoryDTO.getCost()), style);
            createCell(row, columnCount++, accessoryDTO.getVendor(), style);
            createCell(row, columnCount++, accessoryDTO.getBillNumber(), style);
            createCell(row, columnCount++, accessoryDTO.getFile(), style);
             
        }
	}
	public void export(HttpServletResponse response) throws IOException {
		System.out.println("export classsssssss");
		writeHeaderLine();
		writeDataLine();
		
		ServletOutputStream outputStream = response.getOutputStream();
		workbook.write(outputStream);
		workbook.close();
		
		outputStream.close();
	}

}
