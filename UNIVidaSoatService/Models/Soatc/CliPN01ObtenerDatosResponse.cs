using System;

namespace UNIVidaSoatService.Models.Soatc
{

    public class CliPN01ObtenerDatosResponse
    {
        public string PerApellidoCasada { get; set; }
        public string PerApellidoMaterno { get; set; }
        public string PerApellidoPaterno { get; set; }
        public string PerCorreoElectronico { get; set; }
        public string PerDocumentoIdentidadExtension { get; set; }
        public int PerDocumentoIdentidadNumero { get; set; }
        public string PerDomicilioComercial { get; set; }
        public string PerDomicilioParticular { get; set; }
        public int PerEdad { get; set; }
        public DateTime PerFechaAdicion { get; set; }
        public string PerFechaAdicionFormato { get; set; }
        public DateTime PerNacimientoFecha { get; set; }
        public string PerNacimientoFechaFormato { get; set; }
        public string PerNombrePrimero { get; set; }
        public string PerNombreSegundo { get; set; }
        public string PerNumeroIdentificacionTributaria { get; set; }
        public int PerSecuencial { get; set; }
        public string PerTParCliDocumentoIdentidadTipoAbreviacion { get; set; }
        public string PerTParCliDocumentoIdentidadTipoDescripcion { get; set; }
        public int PerTParCliDocumentoIdentidadTipoFk { get; set; }
        public string PerTParCliEstadoCivilAbreviacion { get; set; }
        public string PerTParCliEstadoCivilDescripcion { get; set; }
        public int PerTParCliEstadoCivilFk { get; set; }
        public string PerTParCliGeneroAbreviacion { get; set; }
        public string PerTParCliGeneroDescripcion { get; set; }
        public int PerTParCliGeneroFk { get; set; }
        public string PerTParCliProfesionAbreviacion { get; set; }
        public string PerTParCliProfesionDescripcion { get; set; }
        public int PerTParCliProfesionFk { get; set; }
        public string PerTParCliRegistroEstadoAbreviacion { get; set; }
        public string PerTParCliRegistroEstadoDescripcion { get; set; }
        public string PerTParCliRegistroTipoAbreviacion { get; set; }
        public string PerTParCliRegistroTipoDescripcion { get; set; }
        public int PerTParCliRegistroTipoFk { get; set; }
        public string PerTParCliSituacionLaboralDescripcion { get; set; }
        public int PerTParCliSituacionLaboralFk { get; set; }
        public string PerTParGenActividadEconomicaAbreviacion { get; set; }
        public string PerTParGenActividadEconomicaDescripcion { get; set; }
        public int PerTParGenActividadEconomicaFk { get; set; }
        public string PerTParGenActividadEconomicaSecDescripcion { get; set; }
        public int PerTParGenActividadEconomicaSecFk { get; set; }
        public string PerTParGenDepartamentoAbreviacionDocumentoIdentidad { get; set; }
        public string PerTParGenDepartamentoAbreviacionNacimiento { get; set; }
        public string PerTParGenDepartamentoDescripcionDocumentoIdentidad { get; set; }
        public string PerTParGenDepartamentoDescripcionNacimiento { get; set; }
        public int PerTParGenDepartamentoFkDocumentoIdentidad { get; set; }
        public int PerTParGenDepartamentoFkNacimiento { get; set; }
        public string PerTParGenNivelIngresosAbreviacion { get; set; }
        public string PerTParGenNivelIngresosDescripcion { get; set; }
        public int PerTParGenNivelIngresosFk { get; set; }
        public string PerTParGenPaisAbreviacionNacionalidad { get; set; }
        public string PerTParGenPaisAbreviacionResidencia { get; set; }
        public string PerTParGenPaisDescripcionNacionalidad { get; set; }
        public string PerTParGenPaisDescripcionPaisNacionalidad { get; set; }
        public string PerTParGenPaisDescripcionResidencia { get; set; }
        public int PerTParGenPaisFkNacionalidad { get; set; }
        public int PerTParGenPaisFkResidencia { get; set; }
        public int PerTPersonaFk { get; set; }
        public string PerTelefonoFijo { get; set; }
        public string PerTelefonoMovil { get; set; }
        public int PerTrabajoAnioIngreso { get; set; }
        public string PerTrabajoCargo { get; set; }
        public string PerTrabajoCargoSec { get; set; }
        public string PerTrabajoLugar { get; set; }

        public Odatosgenericos oDatosGenericos { get; set; }
        public Oformulariorespaldoprincipal oFormularioRespaldoPrincipal { get; set; }
    }

    public class Odatosgenericos
    {
        public DateTime DatGenFecha { get; set; }
        public string DatGenFechaFormato { get; set; }
        public int DatGenSecuencial { get; set; }
        public string DatGenTParGenDepartamentoAbreviacion { get; set; }
        public string DatGenTParGenDepartamentoDescripcion { get; set; }
        public int DatGenTParGenDepartamentoFk { get; set; }
        public int DatGenTSucursalFk { get; set; }
    }

    public class Oformulariorespaldoprincipal
    {
        public int FRPNumeroPrincipal { get; set; }
        public int FRPNumeroSecundario { get; set; }
        public int FRPSecuencial { get; set; }
        public int FRPTArchivoAdjuntoFk { get; set; }
    }

}
