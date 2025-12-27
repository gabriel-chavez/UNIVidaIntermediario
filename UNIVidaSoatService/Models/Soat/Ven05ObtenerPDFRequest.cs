namespace UNIVidaIntermediarioService.Models.Soat
{
    public class Ven05ObtenerPDFRequest
    {
        public bool PdfConDiseño { get; set; }
        public int SoatNroComprobante { get; set; }
        public Lsoatdocumentossolicitado[] lSoatDocumentosSolicitados { get; set; }
    }
    public class Lsoatdocumentossolicitado
    {
        public int DocumentoTipo { get; set; }
        public bool DocumentoRequerido { get; set; }
    }

}
