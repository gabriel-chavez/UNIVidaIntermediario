using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UNIVidaIntermediarioService.Models.Soat
{
    public class Ven05ObtenerPDFResponse
    {
        public int SoatNroComprobante { get; set; }
        public CArchivosAdjuntos oArchivosAdjuntos { get; set; }
    }
    public class CArchivosAdjuntos
    {
        public string ArchivoDescripcion { get; set; }        
        public byte[] ArchivoAdjunto { get; set; }
        public int ArchivoLongitud { get; set; }
        public string ArchivoNombre { get; set; }
        public string ArchivoExtension { get; set; }
        public string ArchivoTipoContenido { get; set; }
        public string ArchivoDirectorio { get; set; }
    }
}
