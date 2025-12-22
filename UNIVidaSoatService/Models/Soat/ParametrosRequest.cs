namespace UNIVidaSoatService.Models
{
    public class ParametrosRequest
    {
        public object oEDatos { get; set; } = new { };
        public SeguridadExternaRequest oESeguridadExterna { get; set; }
        public TransaccionOrigenRequest oETransaccionOrigen { get; set; }
    }
}
