namespace UNIVidaSoatService.Models.Soatc
{
    public class Emi03PolizaObtenerPDFResponse
    {
        public int TPolizaDetalleFk { get; set; }
        public CArchivosAdjuntos oArchivosAdjuntos { get; set; }
    }
    public class CArchivosAdjuntos
    {
        public string ArchivoDescripcion { get; set; }
        public byte[] ArchivoAdjunto { get; set; }
        public int ArchivoLongitud { get; set; }
        public string ArchivoNombre { get; set; }
        public string ArchivoExtension { get; set; }
        public string ArchivoTipoContenido { get; set; }
        public string ArchivoDirectorio { get; set; }
    }
}
