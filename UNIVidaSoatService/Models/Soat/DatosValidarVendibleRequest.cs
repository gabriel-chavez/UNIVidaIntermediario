namespace UNIVidaSoatService.Models
{
    public class DatosValidarVendibleRequest
    {
        public string VehiPlaca { get; set; }
        public int SoatTParGestionFk { get; set; }
        public int VehiTParPlacaTipo { get; set; }
    }
}
