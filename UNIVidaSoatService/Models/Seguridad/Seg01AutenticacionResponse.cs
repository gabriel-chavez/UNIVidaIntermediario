namespace UNIVidaIntermediarioService.Models.Seguridad
{
    public class Seg01AutenticacionResponse
    {
        public int SegExtSeguridadToken { get; set; }
        public object oTransUsuarioDatos { get; set; }
        public Otransusuariodatosexterno oTransUsuarioDatosExterno { get; set; }
    }

    public class Otransusuariodatosexterno
    {
        public string CodigoEntidad { get; set; }
        public int Intermediario { get; set; }
        public string TParRolDescripcion { get; set; }
        public int TParRolFk { get; set; }
    }    
}
