using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UNIVidaSoatService.Models.Soatc
{
    public class CliPN03ValidarCoberturaAseguradoResponse
    {
        public int PerDocumentoIdentidadNumero { get; set; }
        public string PerDocumentoIdentidadExtension { get; set; }
        public string PerTParGenDepartamentoAbreviacionDocumentoIdentidad { get; set; }
        public string PolDetFechaVigenciaIniFormato { get; set; }
        public string PolDetFechaVigenciaFinFormato { get; set; }
        public string PolDetCodigoCCI { get; set; }
        public string MensajeVigencia { get; set; }
        public string DatosAsegurado { get; set; }
    }
}
