using System;

namespace UNIVidaSoatService.Models
{
    [Serializable]

    public class ParObtenerTipoDocIdentidadResponse
    {
        public int Secuencial { get; set; }
        public string Descripcion { get; set; }
        public bool RequiereComplemento { get; set; }
    }
}
