using System.Configuration;

namespace UNIVidaIntermediario.Utils
{
    public class ParametrosConfiguracion
    {
        public string CodigoSistema { get; private set; }
        public int TipoTramite { get; private set; }
        public int TraOriCanal { get; set; }

        public ParametrosConfiguracion()
        {

            TipoTramite = int.Parse(ConfigurationManager.AppSettings["TipoTramite"]);
            TraOriCanal = int.Parse(ConfigurationManager.AppSettings["TraOriCanal"]);
            CodigoSistema = "022";
        }
    }
}