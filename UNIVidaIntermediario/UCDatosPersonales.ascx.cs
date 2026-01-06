using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UNIVidaIntermediario.Utils;
using UNIVidaSoatService.Models.Soatc;

namespace UNIVidaIntermediario
{
    public partial class UCDatosPersonales : System.Web.UI.UserControl
    {
        public string ValidationGroup { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarParametricas();
                AplicarValidationGroup();
            }
        }

        private void CargarParametricas()
        {
            ParObtenerTipoDocIdentidad();
            ParObtenerDepartamento();
            ParObtenerGenero();
            ParObtenerEstadoCivil();
            ParObtenerNacionalidad();
        }
        public OEdatosCliente ObtenerDatosFormulario()
        {
            try
            {
                OEdatosCliente datos = new OEdatosCliente()
                {
                    PerDocumentoIdentidadExtension = txtComplementoDocumento.Text,
                    PerDocumentoIdentidadNumero = hfNumeroDocumento.Value,
                    PerTParGenDepartamentoFkDocumentoIdentidad = int.Parse(ddlDeptoDocumento.SelectedValue),
                    PerTParCliDocumentoIdentidadTipoFk = int.Parse(ddlTipoDocumento.SelectedValue),

                    PerNacimientoFecha = ObtenerFechaFormateada(txtFechaNacimiento.Text),

                    PerApellidoMaterno = string.IsNullOrWhiteSpace(txtApellidoMaterno.Text)
                        ? null
                        : txtApellidoMaterno.Text.Trim().ToUpper(),

                    PerApellidoPaterno = string.IsNullOrWhiteSpace(txtApellidoPaterno.Text)
                        ? null
                        : txtApellidoPaterno.Text.Trim().ToUpper(),

                    PerCorreoElectronico = string.IsNullOrWhiteSpace(txtEmail.Text)
                        ? null
                        : txtEmail.Text.Trim(),

                    PerDomicilioParticular = string.IsNullOrWhiteSpace(txtDireccion.Text)
                        ? null
                        : txtDireccion.Text.Trim().ToUpper(),

                    PerNombrePrimero = string.IsNullOrWhiteSpace(txtPrimerNombre.Text)
                        ? null
                        : txtPrimerNombre.Text.Trim().ToUpper(),

                    PerNombreSegundo = string.IsNullOrWhiteSpace(txtSegundoNombre.Text)
                        ? null
                        : txtSegundoNombre.Text.Trim().ToUpper(),

                    PerTelefonoMovil = string.IsNullOrWhiteSpace(txtCelular.Text)
                        ? null
                        : txtCelular.Text.Trim(),

                    PerTParCliGeneroFk = int.Parse(ddlSexo.SelectedValue),
                    PerTParGenActividadEconomicaFk = 0,
                    PerTParGenDepartamentoFkNacimiento = 0,
                    PerTParGenPaisFkNacionalidad = int.Parse(ddlNacionalidad.SelectedValue),

                    PolMaeTParGenDepartamentoFk = int.Parse(ddlDeptoResidencia.SelectedValue),
                    oConyuge = null,

                };

                return datos;
            }
            catch (Exception ex)
            {
                // Manejar error
                throw new Exception($"Error al obtener datos del formulario: {ex.Message}");
            }
        }
        private string ObtenerFechaFormateada(string fecha)
        {
            if (DateTime.TryParseExact(fecha, "dd/MM/yyyy",
                System.Globalization.CultureInfo.InvariantCulture,
                System.Globalization.DateTimeStyles.None, out DateTime fechaDate))
            {
                return fechaDate.ToString("yyyy-MM-dd");
            }
            return string.Empty;
        }

        public void CargarDatos(CliPN01ObtenerDatosResponse dto)
        {
            if (dto == null) return;
            if (dto.EsNuevo)
            {
                txtPrimerNombre.Text = string.Empty;
                txtSegundoNombre.Text = string.Empty;
                txtApellidoPaterno.Text = string.Empty;
                txtApellidoMaterno.Text = string.Empty;
                txtApellidoCasada.Text = string.Empty;
                txtFechaNacimiento.Text = string.Empty;
                ddlDeptoResidencia.SelectedIndex = 0;
                ddlSexo.SelectedIndex = 0;
                ddlEstadoCivil.SelectedIndex = 0;
                ddlNacionalidad.SelectedIndex = 0;
                txtCelular.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtDireccion.Text = string.Empty;

                // Mostrar campos de documento
                rowTipoDocumento.Visible = true;
                rowComplementoDocumento.Visible = true;
                rowDeptoDocumento.Visible = true;

                // Si ya viene PerDocumentoIdentidadNumero, mostrarlo
                ltlNumeroDocumento.Text = dto.PerDocumentoIdentidadNumero.ToString();

                ltlTipoDocumento.Visible = false;
                ltlComplementoDocumento.Visible = false;
                ltlDepartamentoDocumento.Visible = false;

                divDepartamento.Visible = false;
                spanGuion.Visible = false;
                divSeparador.Visible = false;
                divDatosDocumentoIdentidad.Visible = true;

            }
            else
            {
                ltlTipoDocumento.Text = dto.PerTParCliDocumentoIdentidadTipoAbreviacion ?? "CI";

                ltlNumeroDocumento.Text = dto.PerDocumentoIdentidadNumero.ToString();

                if (!string.IsNullOrWhiteSpace(dto.PerDocumentoIdentidadExtension))
                {
                    spanComplemento.Visible = true;
                    ltlComplementoDocumento.Text = dto.PerDocumentoIdentidadExtension;
                }
                else
                {
                    spanComplemento.Visible = false;
                }

                ltlDepartamentoDocumento.Text = dto.PerTParGenDepartamentoDescripcionDocumentoIdentidad;

                txtApellidoPaterno.Text = dto.PerApellidoPaterno;
                txtApellidoMaterno.Text = dto.PerApellidoMaterno;
                txtApellidoCasada.Text = dto.PerApellidoCasada;

                txtPrimerNombre.Text = dto.PerNombrePrimero;
                txtSegundoNombre.Text = dto.PerNombreSegundo;

                if (dto.PerNacimientoFecha != DateTime.MinValue)
                    txtFechaNacimiento.Text = dto.PerNacimientoFecha.ToString("dd/MM/yyyy");

                // Sexo (según tu combo)
                ddlSexo.SelectedValue = dto.PerTParCliGeneroFk.ToString();
                // Estado civil
                ddlEstadoCivil.SelectedValue = dto.PerTParCliEstadoCivilFk.ToString();

                // Nacionalidad
                ddlNacionalidad.SelectedValue = dto.PerTParGenPaisFkNacionalidad.ToString();

                txtCelular.Text = dto.PerTelefonoMovil;
                txtEmail.Text = dto.PerCorreoElectronico;
                txtDireccion.Text = dto.PerDomicilioParticular;

                ltlTipoDocumento.Visible = true;
                ltlComplementoDocumento.Visible = true;
                ltlDepartamentoDocumento.Visible = true;
                divDepartamento.Visible = true;
                spanGuion.Visible = true;
                divSeparador.Visible = true;
                divDatosDocumentoIdentidad.Visible = false;

                hfNumeroDocumento.Value = dto.PerDocumentoIdentidadNumero.ToString();
                ddlTipoDocumento.SelectedValue = dto.PerTParCliDocumentoIdentidadTipoFk.ToString();
                txtComplementoDocumento.Text = dto.PerDocumentoIdentidadExtension;
                ddlDeptoDocumento.SelectedValue = dto.PerTParGenDepartamentoFkDocumentoIdentidad.ToString();

            }


        }


        private void ParObtenerTipoDocIdentidad()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<Par01ObtenerParametricasResponse>>(
                "CoreTecnico",
                "Parametrica",
                "Par01ObtenerParametricas",
                new
                {
                    ParIdentificadorParametricaFk = 1
                }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlTipoDocumento,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Identificador.ToString()
                );
                ddlTipoDocumento.Items.Insert(0, new ListItem("Seleccione una opción", "0"));
                //TiposDocumentos = response.oSDatos;
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this.Page,
                    "error",
                    response?.Mensaje
                );
            }
        }
        private void ParObtenerDepartamento()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<Par01ObtenerParametricasResponse>>(
                "CoreTecnico",
                "Parametrica",
                "Par01ObtenerParametricas",
                new
                {
                    ParIdentificadorParametricaFk = 9
                }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlDeptoDocumento,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Identificador.ToString()
                );
                WebFormHelpers.CargarDropDownList(
                    ddlDeptoResidencia,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Identificador.ToString()
                );
                //ddlDeptoDocumento.Items.Insert(0, new ListItem("Seleccione una opción", "0"));                
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this.Page,
                    "error",
                    response?.Mensaje
                );
            }
        }
        private void ParObtenerGenero()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<Par01ObtenerParametricasResponse>>(
                "CoreTecnico",
                "Parametrica",
                "Par01ObtenerParametricas",
                new
                {
                    ParIdentificadorParametricaFk = 3
                }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlSexo,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Identificador.ToString()
                );
                ddlSexo.Items.Insert(0, new ListItem("Seleccione una opción", "0"));
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this.Page,
                    "error",
                    response?.Mensaje
                );
            }
        }
        private void ParObtenerEstadoCivil()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<Par01ObtenerParametricasResponse>>(
                "CoreTecnico",
                "Parametrica",
                "Par01ObtenerParametricas",
                new
                {
                    ParIdentificadorParametricaFk = 2
                }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlEstadoCivil,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Identificador.ToString()
                );
                //ddlDeptoDocumento.Items.Insert(0, new ListItem("Seleccione una opción", "0"));                
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this.Page,
                    "error",
                    response?.Mensaje
                );
            }
        }
        private void ParObtenerNacionalidad()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<Par01ObtenerParametricasResponse>>(
                "CoreTecnico",
                "Parametrica",
                "Par01ObtenerParametricas",
                new
                {
                    ParIdentificadorParametricaFk = 17
                }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlNacionalidad,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Identificador.ToString()
                );
                //ddlDeptoDocumento.Items.Insert(0, new ListItem("Seleccione una opción", "0"));                
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this.Page,
                    "error",
                    response?.Mensaje
                );
            }
        }
        private void AplicarValidationGroup()
        {
            if (string.IsNullOrEmpty(ValidationGroup))
                return;

            AsignarValidationGroupRecursivo(this);
        }

        private void AsignarValidationGroupRecursivo(Control parent)
        {
            foreach (Control ctrl in parent.Controls)
            {
                if (ctrl is BaseValidator validator)
                {
                    validator.ValidationGroup = ValidationGroup;
                    validator.Enabled = true;
                }

                // 🔁 Recorrer hijos
                if (ctrl.HasControls())
                {
                    AsignarValidationGroupRecursivo(ctrl);
                }
            }
        }


    }
}