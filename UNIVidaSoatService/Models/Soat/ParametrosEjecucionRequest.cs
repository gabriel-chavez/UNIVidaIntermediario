using System.Collections.Generic;

namespace UNIVidaIntermediarioService.Models.Soat
{
    public class ParametrosEjecucionRequest
    {
        public int FactPrima { get; set; }
        public bool PdfConDiseno { get; set; }
        public string VehiPlaca { get; set; }
        public string FactNitCi { get; set; }
        public string SoatTParDepartamentoPcFk { get; set; }
        public string FactRazonSocial { get; set; }
        public int SoatTParVehiculoTipoFk { get; set; }
        public List<DocumentosSolicitados> LsoatDocumentosSolicitados { get; set; }
        public int SoatRosetaNumero { get; set; }
        public int SoatTParVehiculoUsoFk { get; set; }
        public string SoatTParDepartamentoVtFk { get; set; }
        public int SoatTParMedioPagoFk { get; set; }
        public int TparCriterioBusquedaDetalleFk { get; set; }
        public int FactTipoDocIdentidadFk { get; set; }
        public string FactCorreoCliente { get; set; }
        public string FactTelefonoCliente { get; set; }
        public int SoatTParGestionFk { get; set; }
        public string FactCiComplemento { get; set; }
    }
    public class DocumentosSolicitados
    {
        public bool DocumentoRequerido { get; set; }
        public int DocumentoTipo { get; set; }
    }
}
