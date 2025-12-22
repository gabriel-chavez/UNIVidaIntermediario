namespace UNIVidaSoatService.Models
{
    public class ServiceApiRequest
    {
        public string Sistema { get; set; }
        public string Modulo { get; set; }
        public string Metodo { get; set; }
        public ParametrosRequest Parametros { get; set; }
    }

}
