namespace UNIVidaSoatService.Models.Soat
{
    public class Ven01ValidarVendibleRequest
    {        
        public int SoatTParGestionFk { get; set; }        
        public string VehiPlaca { get; set; }
        public int TParCriterioBusquedaDetalleFk { get; set; }
        public CDatosFactura DatosFacturacion { get; set; }
    }
    public class CDatosFactura
    {        
        public string FactRazonSocial { get; set; }
        public string FactNitCi { get; set; }
        public string FactCorreoCliente { get; set; }
        public string FactTelefonoCliente { get; set; } 
        public int FactPrima { get; set; }
        public string FactCiComplemento { get; set; }
        public int FactTipoDocIdentidadFk { get; set; }
    }
}

