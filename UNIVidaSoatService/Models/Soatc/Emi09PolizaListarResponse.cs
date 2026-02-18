using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UNIVidaSoatService.Models.Soatc
{
    public class Emi09PolizaListarResponse
    {
        public string FacturaMaestroCorreoCliente { get; set; }
        public DateTime FacturaMaestroFechaEmision { get; set; }
        public string FacturaMaestroFechaEmisionFormato { get; set; }
        public int FacturaMaestroNumeroFactura { get; set; }
        public int PerDocumentoIdentidadNumero { get; set; }
        public string PlaPagDetHistEstDescripcion { get; set; }
        public int PlaPagDetHistEstFk { get; set; }
        public int PlaPagDetSecuencial { get; set; }
        public string PolDetCodigoCCI { get; set; }
        public float PolDetDescuento { get; set; }
        public DateTime PolDetFechaVigenciaFin { get; set; }
        public string PolDetFechaVigenciaFinFormato { get; set; }
        public DateTime PolDetFechaVigenciaIni { get; set; }
        public string PolDetFechaVigenciaIniFormato { get; set; }
        public float PolDetPrimaCobrada { get; set; }
        public float PolDetPrimaProducto { get; set; }
        public string PolDetPrimaProductoLiteral { get; set; }
        public int PolDetSecuencialFk { get; set; }
        public string PolDetTParEmiCanalVentaAbreviacion { get; set; }
        public string PolDetTParEmiCanalVentaDescripcion { get; set; }
        public int PolDetTParEmiCanalVentaFk { get; set; }
        public int PolDetTParEmiPolizaPV1EstFk { get; set; }
        public string PolDetTParEmiPolizaPV1EstFkAbreviacion { get; set; }
        public string PolDetTParEmiPolizaPV1EstFkDescripcion { get; set; }
        public string PolDetTParGenMonedaAbreviacion { get; set; }
        public string PolDetTParGenMonedaDescripcion { get; set; }
        public int PolDetTParGenMonedaFk { get; set; }
        public int PolDetTPolizaMaestroFk { get; set; }
        public int PolDetTUsuarioDatosFk { get; set; }
        public string PolMaeCodigoPoliza { get; set; }
        public string PolMaeTParPolizaEmisionDescripcion { get; set; }
        public string PolMaeTParPolizaEmisionFk { get; set; }
    }

    

}
