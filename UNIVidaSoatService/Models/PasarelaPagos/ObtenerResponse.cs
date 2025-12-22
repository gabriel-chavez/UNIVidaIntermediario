namespace UNIVidaSoatService.Models.PasarelaPagos
{
    public class ObtenerResponse
    {
        public string CodigoQR { get; set; }
        public double Importe { get; set; }
        public string Moneda { get; set; }
        public int Secuencial { get; set; }
    }
}
