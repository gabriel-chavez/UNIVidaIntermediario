using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNIVidaIntermediario
{
    public partial class UCDatosPersonales : System.Web.UI.UserControl
    {
        // Eventos personalizados
        public event EventHandler DatosGuardados;
        public event EventHandler DatosCambiados;

        // Propiedades públicas
        public string TipoPersona
        {
            get { return hfTipoPersona.Value; }
            set
            {
                hfTipoPersona.Value = value;
                ConfigurarTitulos();
            }
        }

        public bool ModoLectura
        {
            get { return Convert.ToBoolean(hfModoLectura.Value); }
            set
            {
                hfModoLectura.Value = value.ToString();
                SetModoLectura(value);
            }
        }

        public bool ValidacionHabilitada
        {
            set { HabilitarValidacion(value); }
        }

        public string ValidationGroup
        {
            set { SetValidationGroup(value); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConfigurarTitulos();
            }
        }

        private void ConfigurarTitulos()
        {
            //switch (TipoPersona)
            //{
            //    case "ASEGURADO":
            //        ltlTitulo.Text = "DATOS DEL ASEGURADO";
            //        ltlSubtitulo.Text = "Complete los datos del asegurado";
            //        badgeTipoPersona.InnerText = "Asegurado";
            //        break;

            //    case "TOMADOR":
            //        ltlTitulo.Text = "DATOS DEL TOMADOR";
            //        ltlSubtitulo.Text = "Complete los datos del tomador";
            //        badgeTipoPersona.InnerText = "Tomador";
            //        break;

            //    case "BENEFICIARIO":
            //        ltlTitulo.Text = "DATOS DEL BENEFICIARIO";
            //        ltlSubtitulo.Text = "Complete los datos del beneficiario";
            //        badgeTipoPersona.InnerText = "Beneficiario";
            //        break;

            //    default:
            //        ltlTitulo.Text = "DATOS PERSONALES";
            //        ltlSubtitulo.Text = "Complete los datos personales";
            //        badgeTipoPersona.InnerText = TipoPersona;
            //        break;
            //}
        }

        private void SetModoLectura(bool modoLectura)
        {
            txtApellidoPaterno.Enabled = !modoLectura;
            txtApellidoMaterno.Enabled = !modoLectura;
            txtApellidoCasada.Enabled = !modoLectura;
            txtPrimerNombre.Enabled = !modoLectura;
            txtSegundoNombre.Enabled = !modoLectura;
            txtFechaNacimiento.Enabled = !modoLectura;
            ddlSexo.Enabled = !modoLectura;
            ddlEstadoCivil.Enabled = !modoLectura;
            ddlNacionalidad.Enabled = !modoLectura;
            ddlDeptoResidencia.Enabled = !modoLectura;
            ddlDeptoContratacion.Enabled = !modoLectura;
            txtCelular.Enabled = !modoLectura;
            txtEmail.Enabled = !modoLectura;
            txtDireccion.Enabled = !modoLectura;

            //if (modoLectura)
            //{
            //    datosPersonalesContainer.Attributes["class"] = "datos-personales-container modo-lectura";
            //}
            //else
            //{
            //    datosPersonalesContainer.Attributes["class"] = "datos-personales-container modo-edicion";
            //}
        }

        private void HabilitarValidacion(bool habilitar)
        {
            rfvApellidoPaterno.Enabled = habilitar;
            rfvApellidoMaterno.Enabled = habilitar;
            rfvPrimerNombre.Enabled = habilitar;
            rfvFechaNacimiento.Enabled = habilitar;
            rfvSexo.Enabled = habilitar;
            rfvEstadoCivil.Enabled = habilitar;
            rfvNacionalidad.Enabled = habilitar;
            rfvDeptoResidencia.Enabled = habilitar;
            rfvDeptoContratacion.Enabled = habilitar;
            rfvCelular.Enabled = habilitar;
            rfvEmail.Enabled = habilitar;
            rfvDireccion.Enabled = habilitar;
          //  revCelular.Enabled = habilitar;
            revEmail.Enabled = habilitar;
            vsDatosPersonales.Enabled = habilitar;
        }

        private void SetValidationGroup(string validationGroup)
        {
            rfvApellidoPaterno.ValidationGroup = validationGroup;
            rfvApellidoMaterno.ValidationGroup = validationGroup;
            rfvPrimerNombre.ValidationGroup = validationGroup;
            rfvFechaNacimiento.ValidationGroup = validationGroup;
            rfvSexo.ValidationGroup = validationGroup;
            rfvEstadoCivil.ValidationGroup = validationGroup;
            rfvNacionalidad.ValidationGroup = validationGroup;
            rfvDeptoResidencia.ValidationGroup = validationGroup;
            rfvDeptoContratacion.ValidationGroup = validationGroup;
            rfvCelular.ValidationGroup = validationGroup;
            rfvEmail.ValidationGroup = validationGroup;
            rfvDireccion.ValidationGroup = validationGroup;
         //   revCelular.ValidationGroup = validationGroup;
            revEmail.ValidationGroup = validationGroup;
            vsDatosPersonales.ValidationGroup = validationGroup;
        }

        // Métodos para cargar datos
        public void CargarDatosDocumento(string tipoDoc, string numeroDoc, string complemento, string deptoExpedicion)
        {
            txtTipoDocumento.Text = ConvertirTipoDocumento(tipoDoc);
            txtNumeroDocumento.Text = numeroDoc;
            txtDeptoExpedicion.Text = ConvertirDepartamento(deptoExpedicion);

            if (!string.IsNullOrEmpty(complemento))
            {
                divComplementoContainer.Visible = true;
                txtComplemento.Text = complemento;
            }
        }

        public void CargarDatosPersonales(Dictionary<string, object> datos)
        {
            if (datos.ContainsKey("ApellidoPaterno"))
                txtApellidoPaterno.Text = datos["ApellidoPaterno"].ToString();

            if (datos.ContainsKey("ApellidoMaterno"))
                txtApellidoMaterno.Text = datos["ApellidoMaterno"].ToString();

            if (datos.ContainsKey("ApellidoCasada"))
                txtApellidoCasada.Text = datos["ApellidoCasada"].ToString();

            if (datos.ContainsKey("PrimerNombre"))
                txtPrimerNombre.Text = datos["PrimerNombre"].ToString();

            if (datos.ContainsKey("SegundoNombre"))
                txtSegundoNombre.Text = datos["SegundoNombre"].ToString();

            if (datos.ContainsKey("FechaNacimiento") && datos["FechaNacimiento"] != DBNull.Value)
            {
                DateTime fecha = Convert.ToDateTime(datos["FechaNacimiento"]);
                txtFechaNacimiento.Text = fecha.ToString("dd/MM/yyyy");
            }

            if (datos.ContainsKey("Sexo"))
                ddlSexo.SelectedValue = datos["Sexo"].ToString();

            if (datos.ContainsKey("EstadoCivil"))
                ddlEstadoCivil.SelectedValue = datos["EstadoCivil"].ToString();

            if (datos.ContainsKey("Nacionalidad"))
                ddlNacionalidad.SelectedValue = datos["Nacionalidad"].ToString();

            if (datos.ContainsKey("DeptoResidencia"))
                ddlDeptoResidencia.SelectedValue = datos["DeptoResidencia"].ToString();

            if (datos.ContainsKey("DeptoContratacion"))
                ddlDeptoContratacion.SelectedValue = datos["DeptoContratacion"].ToString();

            if (datos.ContainsKey("Celular"))
                txtCelular.Text = datos["Celular"].ToString();

            if (datos.ContainsKey("Email"))
                txtEmail.Text = datos["Email"].ToString();

            if (datos.ContainsKey("Direccion"))
                txtDireccion.Text = datos["Direccion"].ToString();
        }

        public Dictionary<string, object> ObtenerDatos()
        {
            return new Dictionary<string, object>
            {
                {"TipoPersona", TipoPersona},
                {"TipoDocumento", txtTipoDocumento.Text},
                {"NumeroDocumento", txtNumeroDocumento.Text},
                {"Complemento", txtComplemento.Text},
                {"DeptoExpedicion", txtDeptoExpedicion.Text},
                {"ApellidoPaterno", txtApellidoPaterno.Text},
                {"ApellidoMaterno", txtApellidoMaterno.Text},
                {"ApellidoCasada", txtApellidoCasada.Text},
                {"PrimerNombre", txtPrimerNombre.Text},
                {"SegundoNombre", txtSegundoNombre.Text},
                {"FechaNacimiento", ParseFecha(txtFechaNacimiento.Text)},
                {"Sexo", ddlSexo.SelectedValue},
                {"EstadoCivil", ddlEstadoCivil.SelectedValue},
                {"Nacionalidad", ddlNacionalidad.SelectedValue},
                {"DeptoResidencia", ddlDeptoResidencia.SelectedValue},
                {"DeptoContratacion", ddlDeptoContratacion.SelectedValue},
                {"Celular", txtCelular.Text},
                {"Email", txtEmail.Text},
                {"Direccion", txtDireccion.Text}
            };
        }

        public void Limpiar()
        {
            txtApellidoPaterno.Text = "";
            txtApellidoMaterno.Text = "";
            txtApellidoCasada.Text = "";
            txtPrimerNombre.Text = "";
            txtSegundoNombre.Text = "";
            txtFechaNacimiento.Text = "";
            ddlSexo.SelectedIndex = 0;
            ddlEstadoCivil.SelectedIndex = 0;
            ddlNacionalidad.SelectedIndex = 0;
            ddlDeptoResidencia.SelectedIndex = 0;
            ddlDeptoContratacion.SelectedIndex = 0;
            txtCelular.Text = "";
            txtEmail.Text = "";
            txtDireccion.Text = "";
        }

        public bool Validar()
        {
            if (!Page.IsValid)
                return false;

            // Validación adicional de fecha
            if (!string.IsNullOrEmpty(txtFechaNacimiento.Text))
            {
                DateTime fechaNac;
                if (DateTime.TryParseExact(txtFechaNacimiento.Text, "dd/MM/yyyy",
                    null, System.Globalization.DateTimeStyles.None, out fechaNac))
                {
                    int edad = DateTime.Now.Year - fechaNac.Year;
                    if (DateTime.Now < fechaNac.AddYears(edad)) edad--;

                    if (edad < 18)
                    {
                        MostrarMensaje("La persona debe ser mayor de 18 años", "warning");
                        return false;
                    }
                }
            }

            return true;
        }

        public void MostrarMensaje(string mensaje, string tipo = "info")
        {
            //divMensajeInfo.Visible = true;
            //ltlMensajeInfo.Text = mensaje;

            //switch (tipo)
            //{
            //    case "success":
            //        divMensajeInfo.CssClass = "alert alert-success mb-4";
            //        break;
            //    case "warning":
            //        divMensajeInfo.CssClass = "alert alert-warning mb-4";
            //        break;
            //    case "danger":
            //        divMensajeInfo.CssClass = "alert alert-danger mb-4";
            //        break;
            //    default:
            //        divMensajeInfo.CssClass = "alert alert-info mb-4";
            //        break;
            //}
        }

        // Métodos auxiliares
        private string ConvertirTipoDocumento(string tipoDoc)
        {
            switch (tipoDoc.ToUpper())
            {
                case "CI": return "Cédula de Identidad";
                case "PASAPORTE": return "Pasaporte";
                case "NIT": return "NIT";
                case "CE": return "Cédula de Extranjería";
                default: return tipoDoc;
            }
        }

        private string ConvertirDepartamento(string codigo)
        {
            Dictionary<string, string> departamentos = new Dictionary<string, string>
            {
                {"LP", "La Paz"}, {"CB", "Cochabamba"}, {"SC", "Santa Cruz"},
                {"OR", "Oruro"}, {"PT", "Potosí"}, {"TJ", "Tarija"},
                {"CH", "Chuquisaca"}, {"BE", "Beni"}, {"PD", "Pando"}
            };

            return departamentos.ContainsKey(codigo) ? departamentos[codigo] : codigo;
        }

        private DateTime? ParseFecha(string fechaTexto)
        {
            DateTime fecha;
            if (DateTime.TryParseExact(fechaTexto, "dd/MM/yyyy",
                null, System.Globalization.DateTimeStyles.None, out fecha))
            {
                return fecha;
            }
            return null;
        }

    }
}