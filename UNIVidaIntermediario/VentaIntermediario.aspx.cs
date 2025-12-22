using AjaxControlToolkit;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNIVidaIntermediario
{
    public partial class VentaIntermediario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ConfigurarValidadores();
            }
        }

        private void ConfigurarValidadores()
        {
            // Inicialmente deshabilitar todos los validadores específicos
            revCedula.Enabled = false;
            revPasaporte.Enabled = false;
        }

        protected void ddlTipoDocumentoBuscar_SelectedIndexChanged(object sender, EventArgs e)
        {
            string tipoDoc = ddlTipoDocumentoBuscar.SelectedValue;

            // Configurar validadores según tipo de documento
            switch (tipoDoc)
            {
                case "CI":
                case "CE":
                    revCedula.Enabled = true;
                    revPasaporte.Enabled = false;
                    txtNumeroDocumentoBuscar.MaxLength = 8;
                    break;

                case "PASAPORTE":
                    revCedula.Enabled = false;
                    revPasaporte.Enabled = true;
                    txtNumeroDocumentoBuscar.MaxLength = 15;
                    break;

                case "NIT":
                    revCedula.Enabled = false;
                    revPasaporte.Enabled = false;
                    txtNumeroDocumentoBuscar.MaxLength = 10;
                    divComplementoBuscar.Visible = true;
                    break;

                default:
                    revCedula.Enabled = false;
                    revPasaporte.Enabled = false;
                    divComplementoBuscar.Visible = false;
                    break;
            }

            // Configurar FilteredTextBoxExtender según tipo de documento
            ftbeNumeroDocumentoBuscar.ValidChars = "";

            if (tipoDoc == "PASAPORTE")
            {
                ftbeNumeroDocumentoBuscar.FilterType = FilterTypes.UppercaseLetters | FilterTypes.Numbers;
            }
            else if (tipoDoc == "NIT")
            {
                ftbeNumeroDocumentoBuscar.FilterType = FilterTypes.Numbers;
            }
            else
            {
                ftbeNumeroDocumentoBuscar.FilterType = FilterTypes.Numbers;
            }
        }

        protected void btnBuscarAsegurado_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string tipoDoc = ddlTipoDocumentoBuscar.SelectedValue;
                    string numeroDoc = txtNumeroDocumentoBuscar.Text.Trim();
                    string complemento = txtComplementoBuscar.Text.Trim();
                    string departamento = ddlDepartamentoExpedicion.SelectedValue;

                    // Buscar asegurado en base de datos
                    DataTable dtAsegurado = BuscarAseguradoEnBD(tipoDoc, numeroDoc, complemento);

                    if (dtAsegurado.Rows.Count > 0)
                    {
                        // Mostrar datos del asegurado encontrado
                        MostrarDatosAsegurado(dtAsegurado.Rows[0]);
                        pnlResultadoBusqueda.Visible = true;

                        // Guardar en Session
                        Session["AseguradoId"] = dtAsegurado.Rows[0]["Id"].ToString();
                        Session["AseguradoNombre"] = dtAsegurado.Rows[0]["NombreCompleto"].ToString();
                        Session["AseguradoDocumento"] = $"{tipoDoc}-{numeroDoc}";

                        MostrarMensaje("Asegurado encontrado exitosamente", "success");
                    }
                    else
                    {
                        // No encontrado, preguntar si desea crear nuevo
                        pnlResultadoBusqueda.Visible = false;
                        MostrarMensaje("No se encontró el asegurado. ¿Desea registrarlo?", "warning");

                        // Guardar datos para registro
                        ViewState["DatosParaRegistro"] = new
                        {
                            TipoDocumento = tipoDoc,
                            NumeroDocumento = numeroDoc,
                            Complemento = complemento,
                            Departamento = departamento
                        };
                    }
                }
                catch (Exception ex)
                {
                    MostrarMensaje($"Error al buscar asegurado: {ex.Message}", "danger");
                }
            }
        }

        private DataTable BuscarAseguradoEnBD(string tipoDoc, string numeroDoc, string complemento)
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["YourConnectionString"].ConnectionString))
            {
                string query = @"SELECT Id, NombreCompleto, Correo, Celular, Direccion, 
                                TipoDocumento, NumeroDocumento, Complemento
                         FROM Asegurados 
                         WHERE TipoDocumento = @TipoDoc 
                           AND NumeroDocumento = @NumeroDoc 
                           AND ISNULL(Complemento, '') = ISNULL(@Complemento, '')
                           AND Activo = 1";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@TipoDoc", tipoDoc);
                cmd.Parameters.AddWithValue("@NumeroDoc", numeroDoc);
                cmd.Parameters.AddWithValue("@Complemento", string.IsNullOrEmpty(complemento) ? (object)DBNull.Value : complemento);

                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }

            return dt;
        }

        private void MostrarDatosAsegurado(DataRow row)
        {
            lblNombreAsegurado.InnerText = row["NombreCompleto"].ToString();
            lblCorreoAsegurado.InnerText = row["Correo"].ToString();
            lblCelularAsegurado.InnerText = row["Celular"].ToString();
            lblDireccionAsegurado.InnerText = row["Direccion"].ToString();
        }

        protected void btnNuevoAsegurado_Click(object sender, EventArgs e)
        {
            // Limpiar formulario para nuevo registro
            LimpiarFormulario();
            pnlResultadoBusqueda.Visible = false;

            // Opcional: Mostrar formulario extendido para nuevo asegurado
            // mvFormulario.ActiveViewIndex = 1; // Ir a vista de registro
        }

        protected void btnContinuarConAsegurado_Click(object sender, EventArgs e)
        {
            // Continuar al siguiente paso (selección de producto)
          //  mvFormulario.ActiveViewIndex = 1; // Ir a vista de productos

            // Actualizar título del paso 2 si es necesario
            //tituloVentaNuevaRenovacion.InnerText = $"Nueva Venta - {Session["AseguradoNombre"]}";
        }

        protected void btnBuscarOtro_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            pnlResultadoBusqueda.Visible = false;
        }

        private void LimpiarFormulario()
        {
            ddlTipoDocumentoBuscar.SelectedIndex = 0;
            txtNumeroDocumentoBuscar.Text = "";
            txtComplementoBuscar.Text = "";
            ddlDepartamentoExpedicion.SelectedIndex = 0;
            divComplementoBuscar.Visible = false;
            pnlMensajeAsegurado.Visible = false;
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            pnlMensajeAsegurado.Visible = true;
            lblMensajeAsegurado.Text = mensaje;

            switch (tipo)
            {
                case "success":
                    pnlMensajeAsegurado.CssClass = "alert alert-success alert-dismissible fade show";
                    break;
                case "warning":
                    pnlMensajeAsegurado.CssClass = "alert alert-warning alert-dismissible fade show";
                    break;
                case "danger":
                    pnlMensajeAsegurado.CssClass = "alert alert-danger alert-dismissible fade show";
                    break;
                default:
                    pnlMensajeAsegurado.CssClass = "alert alert-info alert-dismissible fade show";
                    break;
            }
        }
        protected void btnSiguienteAsegurado_Click(object sender, EventArgs e)
        {
            //if (Page.IsValid && ValidarDatosAdicionales())
            //{
            //    try
            //    {
            //        // Guardar datos del asegurado
            //        GuardarDatosAsegurado();

            //        // Continuar al paso 3 (productos)
            //        mvFormulario.ActiveViewIndex = 2;

            //        // Actualizar título del paso 3
            //        string nombreCompleto = $"{txtPrimerNombre.Text} {txtApellidoPaterno.Text}";
            //        tituloVentaNuevaRenovacion.InnerText = $"Selección de Producto - {nombreCompleto}";
            //    }
            //    catch (Exception ex)
            //    {
            //        MostrarMensaje($"Error al guardar datos: {ex.Message}", "danger");
            //    }
            //}
        }

        protected void btnAnteriorAsegurado_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 0; // Volver al paso 1
        }


    }

}