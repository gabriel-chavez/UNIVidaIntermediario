namespace UNIVidaIntermediarioService.Models.PasarelaPagos
{
    public class ObtenerRequest
    {
        public int CodigoUnico { get; set; }
        public int TipoTramite { get; set; }
        public string ParametrosEjecucion { get; set; }
        public Odatosqr oDatosQR { get; set; }
    }

    public class Odatosqr
    {
        public int Importe { get; set; }
        public string Referencia { get; set; }
        public string CorreoNotificacion { get; set; }
        public string Variable1 { get; set; }
        public string Variable2 { get; set; }
        public string Variable3 { get; set; }
        public string Variable4 { get; set; }
        public string Variable5 { get; set; }
    }

}
