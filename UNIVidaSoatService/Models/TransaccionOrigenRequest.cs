namespace UNIVidaIntermediarioService.Models
{
    public class TransaccionOrigenRequest
    {
        public string TraOriCajero { get; set; }
        public int TraOriCanal { get; set; }
        public string TraOriEntidad { get; set; }
        public int TraOriIntermediario { get; set; }
        public string TraOriSucursal { get; set; }
        public string TraOriAgencia { get; set; }
    }
}
