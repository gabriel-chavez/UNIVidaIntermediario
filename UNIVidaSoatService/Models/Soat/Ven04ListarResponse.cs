

using System;

namespace UNIVidaIntermediarioService.Models.Soat
{
    public class Ven04ListarResponse
    {    
        public int RcvCantidadSoat { get; set; }
        public int RcvCantidadSoatAnulados { get; set; }
        public int RcvCantidadSoatRevertidos { get; set; }
        public int RcvCantidadSoatValidos { get; set; }
        public int RcvFormularioImporte { get; set; }
        public Lsoatdatosventa[] lSoatDatosVenta { get; set; }
    }

    public class Lsoatdatosventa
    {
        public string FactAutorizacionNumero { get; set; }
        public DateTime FactFecha { get; set; }
        public int FactNumero { get; set; }
        public int FactPrima { get; set; }
        public int SoatNroComprobante { get; set; }
        public int SoatTParGenericaEstadoFk { get; set; }
        public string VehiPlaca { get; set; }
    }

}
