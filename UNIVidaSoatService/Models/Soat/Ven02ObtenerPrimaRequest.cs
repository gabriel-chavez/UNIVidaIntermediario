namespace UNIVidaSoatService.Models
{
    public class Ven02ObtenerPrimaRequest
    {
        public string SoatTParDepartamentoPcFk { get; set; }
        public int SoatTParVehiculoTipoFk { get; set; }
        public int SoatTParVehiculoUsoFk { get; set; }
        public string VehiPlaca { get; set; }
        public int SoatTParGestionFk { get; set; }
    }

    
}
