public class PdfSaveOnRefreshController {
    //PdfSaveOnRefreshController pdf = new PdfSaveOnRefreshController();
    Public String isPdf{get;set;}
    
    Public PdfSaveOnRefreshController(){
        isPdf = '';
    }
    Public void pdfMethod(){
        isPdf = 'pdf';
        Apexpages.currentPage().getHeaders().put('content-disposition', 'attachment; filename=bill.pdf');  
    }
}