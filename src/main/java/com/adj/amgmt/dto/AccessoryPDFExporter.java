package com.adj.amgmt.dto;

import java.awt.Color;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import com.adj.amgmt.entity.Employee;
import com.adj.amgmt.service.EmployeeService;
import com.adj.amgmt.service.EmployeeServiceImpl;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class AccessoryPDFExporter {

	private List<AccessoryIssueDTO> listAccessoryIssue;
	public AccessoryPDFExporter( List<AccessoryIssueDTO> listAccessoryIssue) {
		this.listAccessoryIssue = listAccessoryIssue;
	}

	private void writeTableHeader(PdfPTable table) {
		PdfPCell cell = new PdfPCell();
		cell.setBackgroundColor(Color.GRAY);
		cell.setPadding(5);

		Font font = FontFactory.getFont(FontFactory.HELVETICA);
		font.setColor(Color.WHITE);
		cell.setPhrase(new Phrase("S.no", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Sku Number", font));
		table.addCell(cell);
		cell.setPhrase(new Phrase("Accessory", font));
		table.addCell(cell);
		cell.setPhrase(new Phrase("Purchase Date", font));
		table.addCell(cell);
		cell.setPhrase(new Phrase("Employee", font));
		table.addCell(cell);
		cell.setPhrase(new Phrase("Non-Employee", font));
		table.addCell(cell);		
		cell.setPhrase(new Phrase("Issue Date", font));
		table.addCell(cell);
	}

	private void writeTableData(PdfPTable table) {
		int i=1;
		for (AccessoryIssueDTO accessoryissueDTO : listAccessoryIssue) {
			table.addCell(String.valueOf(i));
			table.addCell(accessoryissueDTO.getAccessory().getSkuNumber());
			table.addCell(accessoryissueDTO.getAccessory().getName());
			table.addCell(accessoryissueDTO.getAccessory().getPurchaseDate());
			if (accessoryissueDTO.getIssuedToEmployee()!= null) {
				table.addCell(accessoryissueDTO.getIssuedToEmployee().getFirstName());
				table.addCell(accessoryissueDTO.getIssuedToNonEmployee());
			}
			if((accessoryissueDTO.getIssuedToEmployee()==null) &&(accessoryissueDTO.getIssuedToNonEmployee()!=null)){
			table.addCell(String.valueOf(accessoryissueDTO.getIssuedToEmployee()));
			table.addCell(accessoryissueDTO.getIssuedToNonEmployee());
			}
			table.addCell(String.valueOf(accessoryissueDTO.getIssueDate()));
			i++;
		}

	}

	public void export(HttpServletResponse response) throws DocumentException, IOException {
		Document document = new Document(PageSize.A4);
		PdfWriter.getInstance(document, response.getOutputStream());

		document.open();
		Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
		font.setSize(18);
		font.setColor(Color.GRAY);

		Paragraph p = new Paragraph("Accessory Report", font);
		p.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(p);
		Paragraph p1 = new Paragraph("___________________________________");
		p1.setAlignment(Paragraph.ALIGN_CENTER);
		document.add(p1);
		Paragraph p2 = new Paragraph("      ", font);
		p2.setSpacingAfter(10);
		document.add(p2);

		PdfPTable table = new PdfPTable(7);
		table.setWidthPercentage(100f);
		table.setWidths(new float[] { 3.5f, 5.5f, 5.5f, 5.5f, 6f, 6f, 5.5f });
		table.setSpacingBefore(10);

		writeTableHeader(table);
		writeTableData(table);

		document.add(table);

		document.close();

	}
}
