using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UNIVidaIntermediarioService.Models.Soat;

namespace UNIVidaSoatService.Models.Soatc
{
    public class Emi01PolizaEmitirPDFResponse
    {
        public int PolMaeSecuencial { get; set; }
        public int PolDetSecuencial { get; set; }
        public ArchivosAdjuntos oArchivosAdjuntos { get; set; }
    }
    public class ArchivosAdjuntos
    {
        public string ArchivoAdjunto { get; set; }
        public string ArchivoDescripcion { get; set; }
        public string ArchivoDirectorio { get; set; }
        public string ArchivoExtension { get; set; }
        public int ArchivoLongitud { get; set; }
        public string ArchivoNombre { get; set; }
        public string ArchivoTipoContenido { get; set; }
    }
}
