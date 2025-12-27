using System;

namespace UNIVidaIntermediarioService.Models.Soat
{
    public class VenQrListarGeneradosRequest
    {
        public string VentaVendedor { get; set; }
        public DateTime Fecha { get; set; }
        public int TParVentaCanalFk { get; set; }
        public int TParSimpleEstadoSolicitudFk { get; set; }
        public string IdentificadorVehiculo { get; set; }
    }
}
