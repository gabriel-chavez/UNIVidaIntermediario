using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UNIVidaSoatService.Models.Soatc
{
    public class Emi01PolizaEmitirPDFRequest
    {

        public int PolMaeTParGenDepartamentoFk { get; set; }
        public int PolMaeTProductoPlanPrimaFk { get; set; }
        public List<Lpolbenbeneficiario> lPolBenBeneficiario { get; set; }
        public OEdatosCliente oEDatosAsegurado { get; set; }
        public OEdatosCliente oEDatosTomador { get; set; }
        public Oetransaccionidentificador oETransaccionIdentificador { get; set; }
    }

    public class OEdatosCliente
    {
        public string PerApellidoMaterno { get; set; }
        public string PerApellidoPaterno { get; set; }
        public string PerCorreoElectronico { get; set; }
        public string PerDocumentoIdentidadExtension { get; set; }
        public string PerDocumentoIdentidadNumero { get; set; }
        public string PerDomicilioParticular { get; set; }
        public string PerNacimientoFecha { get; set; }
        public string PerNombrePrimero { get; set; }
        public string PerNombreSegundo { get; set; }
        public int PerTParCliDocumentoIdentidadTipoFk { get; set; }
        public int PerTParCliGeneroFk { get; set; }
        public int PerTParGenActividadEconomicaFk { get; set; }
        public int PerTParGenDepartamentoFkDocumentoIdentidad { get; set; }
        public int PerTParGenDepartamentoFkNacimiento { get; set; }
        public int PerTParGenPaisFkNacionalidad { get; set; }
        public string PerTelefonoMovil { get; set; }
        public int PolMaeTParGenDepartamentoFk { get; set; }
        public Oconyuge oConyuge { get; set; }
    }

    public class Oconyuge
    {
        public string PerConDocumentoIdentidadNumero { get; set; }
        public string PerConNombreCompleto { get; set; }
        public int PerConTParGenActividadEconomicaFk { get; set; }
    }

    
    public class Oconyuge1
    {
        public string PerConDocumentoIdentidadNumero { get; set; }
        public string PerConNombreCompleto { get; set; }
        public int PerConTParGenActividadEconomicaFk { get; set; }
    }

    public class Oetransaccionidentificador
    {
        public string TraIdeLlaveA { get; set; }
        public string TraIdeLlaveB { get; set; }
        public object traIdeLlaveC { get; set; }
    }

    public class Lpolbenbeneficiario
    {
        public int Id { get; set; }
        public string PolBenNombreCompleto { get; set; }
        public int PolBenBeneficioPorcentaje { get; set; }
        public int PolBenTParEmiBeneficiarioParentescoFk { get; set; }
    }

}
