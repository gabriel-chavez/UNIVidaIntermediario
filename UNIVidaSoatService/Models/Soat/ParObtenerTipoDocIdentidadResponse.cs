using System;

namespace UNIVidaIntermediarioService.Models
{
    [Serializable]

    public class ParObtenerTipoDocIdentidadResponse
    {
        public int Secuencial { get; set; }
        public string Descripcion { get; set; }
        public bool RequiereComplemento { get; set; }
    }
}
