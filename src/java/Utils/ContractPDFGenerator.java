/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import Model.Booking;
import Model.Representative;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.*;
import java.text.SimpleDateFormat;

/**
 *
 * @author nongducdai
 */
public class ContractPDFGenerator {

    private static final Font TITLE_FONT = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.DARK_GRAY);
    private static final Font HEADER_FONT = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, BaseColor.BLACK);
    private static final Font SUBHEADER_FONT = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK);
    private static final Font NORMAL_FONT = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, BaseColor.BLACK);
    private static final Font BOLD_FONT = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.BLACK);
    private static final Font SMALL_FONT = new Font(Font.FontFamily.HELVETICA, 8, Font.NORMAL, BaseColor.GRAY);

    private static final BaseColor HEADER_COLOR = new BaseColor(59, 130, 246);
    private static final BaseColor ACCENT_COLOR = new BaseColor(249, 250, 251);

    public void generateContractPDF(Booking booking, String outputPath) throws DocumentException, IOException {
        Document document = new Document(PageSize.A4, 40, 40, 50, 50);
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(outputPath));

        // Add header and footer
        writer.setPageEvent(new HeaderFooterPageEvent(booking));

        document.open();

        // Document title
        addDocumentHeader(document, booking);

        // Contract content
        addContractDate(document, booking);
        addPartyInformation(document, booking);

        if (booking.getRepresentative() != null && booking.getRepresentative().getFull_name() != null) {
            addRepresentativeInfo(document, booking);
        }

        addPropertyDetails(document, booking);
        addBookingTerms(document, booking);
        addPaymentDetails(document, booking);
        addTermsAndConditions(document);
        addSignatureSection(document, booking);

        document.close();
    }

    private void addDocumentHeader(Document document, Booking booking) throws DocumentException {
        // Header background
        PdfPTable headerTable = new PdfPTable(1);
        headerTable.setWidthPercentage(100);
        PdfPCell headerCell = new PdfPCell();
        headerCell.setBackgroundColor(HEADER_COLOR);
        headerCell.setPadding(20);
        headerCell.setBorder(Rectangle.NO_BORDER);

        Paragraph headerText = new Paragraph();
        headerText.setAlignment(Element.ALIGN_CENTER);

        Chunk title = new Chunk("HOMESTAY BOOKING CONTRACT\n",
                new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD, BaseColor.WHITE));
        Chunk contractId = new Chunk("Contract #BK-" + booking.getId() + "-"
                + new SimpleDateFormat("yyyyMMdd").format(booking.getCreated_at()),
                new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, new BaseColor(220, 238, 255)));

        headerText.add(title);
        headerText.add(contractId);
        headerCell.addElement(headerText);
        headerTable.addCell(headerCell);

        document.add(headerTable);
        document.add(new Paragraph(" ")); // Spacing
    }

    private void addContractDate(Document document, Booking booking) throws DocumentException {
        Paragraph dateSection = new Paragraph();
        dateSection.setAlignment(Element.ALIGN_CENTER);
        dateSection.setSpacingAfter(15);

        dateSection.add(new Chunk("BOOKING AGREEMENT\n", HEADER_FONT));
        dateSection.add(new Chunk("This contract is made on ", NORMAL_FONT));
        dateSection.add(new Chunk(new SimpleDateFormat("EEEE, MMMM dd, yyyy").format(booking.getCreated_at()), BOLD_FONT));

        document.add(dateSection);
    }

    private void addPartyInformation(Document document, Booking booking) throws DocumentException {
        // Create table for guest and host info
        PdfPTable partyTable = new PdfPTable(2);
        partyTable.setWidthPercentage(100);
        partyTable.setSpacingBefore(10);
        partyTable.setSpacingAfter(15);

        // Guest Information
        PdfPCell guestCell = new PdfPCell();
        guestCell.setPadding(15);
        guestCell.setBackgroundColor(ACCENT_COLOR);

        Paragraph guestInfo = new Paragraph();
        guestInfo.add(new Chunk("👤 GUEST INFORMATION\n", SUBHEADER_FONT));
        guestInfo.add(new Chunk("Name: ", BOLD_FONT));
        guestInfo.add(new Chunk(booking.getTenant().getFirst_name() + " " + booking.getTenant().getLast_name() + "\n", NORMAL_FONT));
        guestInfo.add(new Chunk("Email: ", BOLD_FONT));
        guestInfo.add(new Chunk(booking.getTenant().getEmail() + "\n", NORMAL_FONT));
        guestInfo.add(new Chunk("Phone: ", BOLD_FONT));
        guestInfo.add(new Chunk(booking.getTenant().getPhone() + "\n", NORMAL_FONT));
        guestInfo.add(new Chunk("Booking Date: ", BOLD_FONT));
        guestInfo.add(new Chunk(new SimpleDateFormat("dd/MM/yyyy HH:mm").format(booking.getCreated_at()), NORMAL_FONT));

        guestCell.addElement(guestInfo);
        partyTable.addCell(guestCell);

        // Host Information
        PdfPCell hostCell = new PdfPCell();
        hostCell.setPadding(15);
        hostCell.setBackgroundColor(ACCENT_COLOR);

        Paragraph hostInfo = new Paragraph();
        hostInfo.add(new Chunk("🏠 HOST INFORMATION\n", SUBHEADER_FONT));
        hostInfo.add(new Chunk("Name: ", BOLD_FONT));
        hostInfo.add(new Chunk(booking.getHomestay().getOwner().getFirst_name() + " "
                + booking.getHomestay().getOwner().getLast_name() + "\n", NORMAL_FONT));
        hostInfo.add(new Chunk("Email: ", BOLD_FONT));
        hostInfo.add(new Chunk(booking.getHomestay().getOwner().getEmail() + "\n", NORMAL_FONT));
        hostInfo.add(new Chunk("Phone: ", BOLD_FONT));
        hostInfo.add(new Chunk(booking.getHomestay().getOwner().getPhone() + "\n", NORMAL_FONT));
        hostInfo.add(new Chunk("Property: ", BOLD_FONT));
        hostInfo.add(new Chunk(booking.getHomestay().getName(), NORMAL_FONT));

        hostCell.addElement(hostInfo);
        partyTable.addCell(hostCell);

        document.add(partyTable);
    }

    private void addRepresentativeInfo(Document document, Booking booking) throws DocumentException {
        Paragraph repSection = new Paragraph();
        repSection.add(new Chunk("👔 AUTHORIZED REPRESENTATIVE\n", SUBHEADER_FONT));
        repSection.setSpacingBefore(10);
        repSection.setSpacingAfter(15);

        PdfPTable repTable = new PdfPTable(2);
        repTable.setWidthPercentage(100);

        Representative rep = booking.getRepresentative();

        repTable.addCell(createInfoCell("Name:", rep.getFull_name()));
        repTable.addCell(createInfoCell("Phone:", rep.getPhone()));
        repTable.addCell(createInfoCell("Email:", rep.getEmail()));
        repTable.addCell(createInfoCell("Relationship:", rep.getRelationship()));

        if (rep.getAdditional_notes() != null && !rep.getAdditional_notes().isEmpty()) {
            PdfPCell notesCell = new PdfPCell();
            notesCell.setColspan(2);
            notesCell.setPadding(8);
            Paragraph notes = new Paragraph();
            notes.add(new Chunk("Notes: ", BOLD_FONT));
            notes.add(new Chunk(rep.getAdditional_notes(), NORMAL_FONT));
            notesCell.addElement(notes);
            repTable.addCell(notesCell);
        }

        document.add(repSection);
        document.add(repTable);

        // Add note about representative
        Paragraph repNote = new Paragraph();
        repNote.setSpacingBefore(5);
        repNote.setSpacingAfter(15);
        repNote.add(new Chunk("Note: ", new Font(Font.FontFamily.HELVETICA, 9, Font.BOLD, BaseColor.ORANGE)));
        repNote.add(new Chunk("The above representative is authorized to check-in on behalf of the primary guest and must present valid identification.",
                new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL, BaseColor.ORANGE)));
        repNote.setIndentationLeft(20);
        document.add(repNote);
    }

    private void addPropertyDetails(Document document, Booking booking) throws DocumentException {
        Paragraph propSection = new Paragraph();
        propSection.add(new Chunk("🏢 PROPERTY DETAILS\n", SUBHEADER_FONT));
        propSection.setSpacingBefore(10);
        propSection.setSpacingAfter(10);
        document.add(propSection);

        PdfPTable propTable = new PdfPTable(2);
        propTable.setWidthPercentage(100);
        propTable.setSpacingAfter(15);

        propTable.addCell(createInfoCell("Property Name:", booking.getHomestay().getName()));
        propTable.addCell(createInfoCell("Property Type:",
                booking.getHomestay().isIs_whole_house() ? "Whole House" : "Room Booking"));
        propTable.addCell(createInfoCell("Star Rating:", booking.getHomestay().getStar() + " stars"));

        String fullAddress = String.format("%s, %s, %s, %s",
                booking.getHomestay().getAddress().getDetail(),
                booking.getHomestay().getAddress().getWard(),
                booking.getHomestay().getAddress().getDistrict(),
                booking.getHomestay().getAddress().getProvince());

        PdfPCell addressCell = new PdfPCell();
        addressCell.setColspan(2);
        addressCell.setPadding(8);
        Paragraph address = new Paragraph();
        address.add(new Chunk("Full Address: ", BOLD_FONT));
        address.add(new Chunk(fullAddress, NORMAL_FONT));
        addressCell.addElement(address);
        propTable.addCell(addressCell);

        if (booking.getRoom() != null) {
            propTable.addCell(createInfoCell("Room Name:", booking.getRoom().getName()));
            propTable.addCell(createInfoCell("Room Rating:", booking.getRoom().getStar() + " stars"));
        }

        document.add(propTable);
    }

    private void addBookingTerms(Document document, Booking booking) throws DocumentException {
        Paragraph termsSection = new Paragraph();
        termsSection.add(new Chunk("📅 BOOKING TERMS\n", SUBHEADER_FONT));
        termsSection.setSpacingBefore(10);
        termsSection.setSpacingAfter(10);
        document.add(termsSection);

        PdfPTable termsTable = new PdfPTable(2);
        termsTable.setWidthPercentage(100);
        termsTable.setSpacingAfter(15);

        SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, dd/MM/yyyy");

        termsTable.addCell(createInfoCell("Check-in Date:", dateFormat.format(booking.getCheck_in())));
        termsTable.addCell(createInfoCell("Check-out Date:", dateFormat.format(booking.getCheckout())));

        // Calculate nights
        long diffInMillies = booking.getCheckout().getTime() - booking.getCheck_in().getTime();
        long nights = diffInMillies / (1000 * 60 * 60 * 24);

        termsTable.addCell(createInfoCell("Duration:", nights + " nights"));
        termsTable.addCell(createInfoCell("Check-in Time:", "After 12:00 PM"));
        termsTable.addCell(createInfoCell("Check-out Time:", "Before 11:00 AM"));
        termsTable.addCell(createInfoCell("Booking Status:", booking.getStatus().getName()));

        document.add(termsTable);

        // Special requests
        if (booking.getNote() != null && !booking.getNote().isEmpty()) {
            Paragraph specialRequests = new Paragraph();
            specialRequests.setSpacingBefore(5);
            specialRequests.setSpacingAfter(15);
            specialRequests.add(new Chunk("Special Requests: ", BOLD_FONT));
            specialRequests.add(new Chunk(booking.getNote(), NORMAL_FONT));
            document.add(specialRequests);
        }
    }

    private void addPaymentDetails(Document document, Booking booking) throws DocumentException {
        Paragraph paymentSection = new Paragraph();
        paymentSection.add(new Chunk("💰 PAYMENT BREAKDOWN\n", SUBHEADER_FONT));
        paymentSection.setSpacingBefore(10);
        paymentSection.setSpacingAfter(10);
        document.add(paymentSection);

        PdfPTable paymentTable = new PdfPTable(2);
        paymentTable.setWidthPercentage(100);
        paymentTable.setSpacingAfter(15);

        // Calculate accommodation cost
        double accommodationCost = booking.getTotal_price() - booking.getService_fee() - booking.getCleaning_fee();
        double pricePerNight = booking.getHomestay().isIs_whole_house()
                ? booking.getHomestay().getPrice_per_night() : booking.getRoom().getPrice_per_night();
        long nights = (long) (accommodationCost / pricePerNight);

        String accommodationType = booking.getHomestay().isIs_whole_house() ? "Accommodation" : "Room Rate";
        paymentTable.addCell(createPaymentCell(String.format("%s (₫%,.0f × %d nights)",
                accommodationType, pricePerNight, nights), accommodationCost));

        paymentTable.addCell(createPaymentCell("Service Fee", booking.getService_fee()));
        paymentTable.addCell(createPaymentCell("Cleaning Fee", booking.getCleaning_fee()));

        // Total row
        PdfPCell totalLabelCell = new PdfPCell(new Phrase("Total Amount",
                new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK)));
        totalLabelCell.setPadding(8);
        totalLabelCell.setBorderWidth(2);
        totalLabelCell.setBorderColor(BaseColor.BLACK);

        PdfPCell totalValueCell = new PdfPCell(new Phrase(String.format("₫%,.0f", booking.getTotal_price()),
                new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, BaseColor.BLACK)));
        totalValueCell.setPadding(8);
        totalValueCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        totalValueCell.setBorderWidth(2);
        totalValueCell.setBorderColor(BaseColor.BLACK);

        paymentTable.addCell(totalLabelCell);
        paymentTable.addCell(totalValueCell);

        // Deposit and balance
        paymentTable.addCell(createHighlightCell("Deposit Paid (20%)", booking.getDeposit(),
                new BaseColor(59, 130, 246))); // Blue
        paymentTable.addCell(createHighlightCell("Balance Due at Check-in",
                booking.getTotal_price() - booking.getDeposit(), new BaseColor(249, 115, 22))); // Orange

        document.add(paymentTable);
    }

    private void addTermsAndConditions(Document document) throws DocumentException {
        Paragraph termsSection = new Paragraph();
        termsSection.add(new Chunk("⚖️ TERMS AND CONDITIONS SUMMARY\n", SUBHEADER_FONT));
        termsSection.setSpacingBefore(10);
        termsSection.setSpacingAfter(10);
        document.add(termsSection);

        PdfPTable termsTable = new PdfPTable(2);
        termsTable.setWidthPercentage(100);
        termsTable.setSpacingAfter(15);

        // Cancellation Policy
        PdfPCell cancelCell = new PdfPCell();
        cancelCell.setPadding(10);
        cancelCell.setBackgroundColor(ACCENT_COLOR);

        Paragraph cancelPolicy = new Paragraph();
        cancelPolicy.add(new Chunk("Cancellation Policy:\n", BOLD_FONT));
        cancelPolicy.add(new Chunk("• Free cancellation up to 48 hours before check-in\n", SMALL_FONT));
        cancelPolicy.add(new Chunk("• Cancellations within 48 hours forfeit deposit\n", SMALL_FONT));
        cancelPolicy.add(new Chunk("• No-shows result in full charge", SMALL_FONT));

        cancelCell.addElement(cancelPolicy);
        termsTable.addCell(cancelCell);

        // House Rules
        PdfPCell rulesCell = new PdfPCell();
        rulesCell.setPadding(10);
        rulesCell.setBackgroundColor(ACCENT_COLOR);

        Paragraph houseRules = new Paragraph();
        houseRules.add(new Chunk("House Rules:\n", BOLD_FONT));
        houseRules.add(new Chunk("• Check-in: After 12:00 PM\n", SMALL_FONT));
        houseRules.add(new Chunk("• Check-out: Before 11:00 AM\n", SMALL_FONT));
        houseRules.add(new Chunk("• Quiet hours: 10:00 PM - 8:00 AM\n", SMALL_FONT));
        houseRules.add(new Chunk("• No smoking indoors", SMALL_FONT));

        rulesCell.addElement(houseRules);
        termsTable.addCell(rulesCell);

        document.add(termsTable);

        // Important note
        Paragraph importantNote = new Paragraph();
        importantNote.setSpacingBefore(5);
        importantNote.setSpacingAfter(15);
        importantNote.add(new Chunk("Important: ", new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.BLUE)));
        importantNote.add(new Chunk("By proceeding with this booking, both parties agree to all terms and conditions as outlined in the full contract agreement. This document serves as a legally binding contract.",
                new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL, BaseColor.BLUE)));
        importantNote.setIndentationLeft(20);
        document.add(importantNote);
    }

    private void addSignatureSection(Document document, Booking booking) throws DocumentException {
        Paragraph sigSection = new Paragraph();
        sigSection.add(new Chunk("✍️ DIGITAL AGREEMENT\n", SUBHEADER_FONT));
        sigSection.setSpacingBefore(10);
        sigSection.setSpacingAfter(10);
        document.add(sigSection);

        PdfPTable sigTable = new PdfPTable(2);
        sigTable.setWidthPercentage(100);
        sigTable.setSpacingAfter(20);

        // Guest Agreement
        PdfPCell guestSigCell = new PdfPCell();
        guestSigCell.setPadding(15);
        guestSigCell.setBorder(PdfPCell.BOX);
        guestSigCell.setBorderColor(BaseColor.GRAY);

        Paragraph guestSig = new Paragraph();
        guestSig.setAlignment(Element.ALIGN_CENTER);
        guestSig.add(new Chunk("Guest Agreement\n\n", BOLD_FONT));
        guestSig.add(new Chunk("Digitally agreed on:\n", NORMAL_FONT));
        guestSig.add(new Chunk(new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(booking.getCreated_at()) + "\n\n", SMALL_FONT));
        guestSig.add(new Chunk(booking.getTenant().getFirst_name() + " " + booking.getTenant().getLast_name() + "\n",
                new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, new BaseColor(59, 130, 246))));
        guestSig.add(new Chunk("Digital Signature", SMALL_FONT));

        guestSigCell.addElement(guestSig);
        sigTable.addCell(guestSigCell);

        // Host Acknowledgment
        PdfPCell hostSigCell = new PdfPCell();
        hostSigCell.setPadding(15);
        hostSigCell.setBorder(PdfPCell.BOX);
        hostSigCell.setBorderColor(BaseColor.GRAY);

        Paragraph hostSig = new Paragraph();
        hostSig.setAlignment(Element.ALIGN_CENTER);
        hostSig.add(new Chunk("Host Acknowledgment\n\n", BOLD_FONT));
        hostSig.add(new Chunk("Property managed by:\n", NORMAL_FONT));
        hostSig.add(new Chunk("FUHF Platform\n\n", SMALL_FONT));
        hostSig.add(new Chunk(booking.getHomestay().getOwner().getFirst_name() + " "
                + booking.getHomestay().getOwner().getLast_name() + "\n",
                new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD, new BaseColor(34, 197, 94))));
        hostSig.add(new Chunk("Host Representative", SMALL_FONT));

        hostSigCell.addElement(hostSig);
        sigTable.addCell(hostSigCell);

        document.add(sigTable);
    }

    // Helper methods
    private PdfPCell createInfoCell(String label, String value) {
        PdfPCell cell = new PdfPCell();
        cell.setPadding(8);
        cell.setBorder(Rectangle.NO_BORDER);

        Paragraph p = new Paragraph();
        p.add(new Chunk(label + " ", BOLD_FONT));
        p.add(new Chunk(value, NORMAL_FONT));
        cell.addElement(p);

        return cell;
    }

    private PdfPCell createPaymentCell(String label, double value) {
        PdfPCell labelCell = new PdfPCell(new Phrase(label, NORMAL_FONT));
        labelCell.setPadding(8);
        labelCell.setBorder(Rectangle.NO_BORDER);

        PdfPCell valueCell = new PdfPCell(new Phrase(String.format("₫%,.0f", value), NORMAL_FONT));
        valueCell.setPadding(8);
        valueCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
        valueCell.setBorder(Rectangle.NO_BORDER);

        return labelCell; // Return both cells in actual implementation
    }

    private PdfPCell createHighlightCell(String label, double value, BaseColor color) {
        PdfPCell labelCell = new PdfPCell(new Phrase(label,
                new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, color)));
        labelCell.setPadding(8);
        labelCell.setBorder(Rectangle.NO_BORDER);

        return labelCell;
    }

    // Inner class for header/footer
    class HeaderFooterPageEvent extends PdfPageEventHelper {

        private Booking booking;

        public HeaderFooterPageEvent(Booking booking) {
            this.booking = booking;
        }

        @Override
        public void onEndPage(PdfWriter writer, Document document) {
            // Footer
            PdfPTable footer = new PdfPTable(1);
            footer.setTotalWidth(document.getPageSize().getWidth() - document.leftMargin() - document.rightMargin());

            PdfPCell footerCell = new PdfPCell();
            footerCell.setBorder(Rectangle.NO_BORDER);
            footerCell.setHorizontalAlignment(Element.ALIGN_CENTER);

            Paragraph footerText = new Paragraph();
            footerText.setAlignment(Element.ALIGN_CENTER);
            footerText.add(new Chunk("This contract was generated electronically by FUHF Homestay Platform on "
                    + new SimpleDateFormat("EEEE, MMMM dd, yyyy 'at' HH:mm:ss").format(booking.getCreated_at()) + "\n", SMALL_FONT));
            footerText.add(new Chunk("Contract Reference: BK-" + booking.getId() + "-"
                    + new SimpleDateFormat("yyyyMMdd").format(booking.getCreated_at()) + " | Platform Version: 2.0\n", SMALL_FONT));
            footerText.add(new Chunk("For support, contact: support@fuhf.com | Emergency: +84 123 456 789", SMALL_FONT));

            footerCell.addElement(footerText);
            footer.addCell(footerCell);

            footer.writeSelectedRows(0, -1, document.leftMargin(),
                    document.bottomMargin() + footer.getTotalHeight(), writer.getDirectContent());
        }
    }
}
