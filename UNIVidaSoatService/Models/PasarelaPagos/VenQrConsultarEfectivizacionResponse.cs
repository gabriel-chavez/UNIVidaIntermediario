namespace UNIVidaIntermediarioService.Models.PasarelaPagos
{
    public class VenQrConsultarEfectivizacionResponse
    {
        public bool Estado { get; set; }
        public string IdentificadorVehiculo { get; set; }
        public string Mensaje { get; set; }
        public int Secuencial { get; set; }
        public int TParCanalVentaFk { get; set; }
        public string TParSimpleEestadoSolicitudDescripcion { get; set; }
        public int TParSimpleEestadoSolicitudEjecucionFk { get; set; }
        public int TVehiSoatPropFk { get; set; }
        public string VentaVendedor { get; set; }
    }

    

}
