namespace UNIVidaSoatService.Models.Soat
{
    public class VenQrListarGeneradosResponse
    {
        public int Secuencial { get; set; }
        public string IdentificadorVehiculo { get; set; }
        public int Gestion { get; set; }
        public int TVehiSoatPropFk { get; set; }
        public string FechaHoraSolicitud { get; set; }
        public int TParSimpleEstadoSolicitudFk { get; set; }
        public string TParSimpleEstadoSolicitudDescripcion { get; set; }
        public string FechaHoraEstado { get; set; }
        public string Efectivizado { get; set; }
        public string MensajeEfectivizacion { get; set; }
        public int TramiteSecuencial { get; set; }
        public int TParSimpleTramiteFk { get; set; }
        public decimal Importe { get; set; }
    }
}
