namespace UNIVidaSoatService.Models
{
    public class Ven01ValidarVendibleYObtenerDatosResponse
    {
        public string VehiMarca { get; set; }
        public string VehiModelo { get; set; }
        public string VehiAnio { get; set; }
        public string VehiColor { get; set; }
        public string VehiMotor { get; set; }
        public string VehiChasis { get; set; }
        public string VehiCapacidadCarga { get; set; }
        public string VehiCilindrada { get; set; }
        public string VehiAcople { get; set; }
        public string SoatTParDepartamentoVtFk { get; set; }
        public string PropTomador { get; set; }
        public string PropCi { get; set; }
        public string PropNit { get; set; }
        public string PropDireccion { get; set; }
        public string PropTelefono { get; set; }
        public string PropCelular { get; set; }
        public string VehiPlaca { get; set; }
        public int SoatTParGestionFk { get; set; }
        public int SoatTParVehiculoTipoFk { get; set; }
        public string SoatTParVehiculoTipoDescripcion { get; set; }
        public int SoatTParVehiculoUsoFk { get; set; }
        public string SoatTParVehiculoUsoDescripcion { get; set; }
        public string SoatTParDepartamentoPcFk { get; set; }
        public string SoatTParDepartamentoPcDescripcion { get; set; }
        public int SoatRosetaNumero { get; set; }
    }
}
