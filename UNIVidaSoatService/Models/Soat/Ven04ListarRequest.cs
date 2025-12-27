using System;

namespace UNIVidaIntermediarioService.Models.Soat
{
    public class Ven04ListarRequest
    {
        public DateTime SoatVentaFecha { get; set; }

        public string VehiPlaca { get; set; }

        public int SoatTParGestionFk { get; set; }
    }
}
