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
using UNIVidaIntermediario.Utils;
using UNIVidaIntermediarioService.Models;
using UNIVidaSoatService.Models.Soatc;

namespace UNIVidaIntermediario
{
    public partial class VentaIntermediario : System.Web.UI.Page
    {

        protected List<ParObtenerTipoDocIdentidadResponse> TiposDocumentos
        {
            get
            {
                return ViewState["TiposDocumentos"] as List<ParObtenerTipoDocIdentidadResponse> ??
                       new List<ParObtenerTipoDocIdentidadResponse>();
            }
            set
            {
                ViewState["TiposDocumentos"] = value;
            }
        }
        private List<Beneficiario> ListaBeneficiarios
        {
            get
            {
                if (Session["Beneficiarios"] == null)
                    Session["Beneficiarios"] = new List<Beneficiario>();
                return (List<Beneficiario>)Session["Beneficiarios"];
            }
            set { Session["Beneficiarios"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //  ConfigurarValidadores();
            }
        }
        private void ParObtenerTipoDocIdentidad()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<ParObtenerTipoDocIdentidadResponse>>(
                "CoreSOAT",
                "Parametricas",
                "ParObtenerTipoDocIdentidad",
                new { }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlTipoDocumento,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Secuencial.ToString()
                );
                ddlTipoDocumento.Items.Insert(0, new ListItem("Seleccione una opción", "0"));
                TiposDocumentos = response.oSDatos;
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    response?.Mensaje
                );
            }
        }
        private void BuscarPersona()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<CliPN01ObtenerDatosResponse>>(
                "CoreTecnico",
                "ClientesPN",
                "CliPN01ObtenerDatos",
               new
               {
                   PerTParCliDocumentoIdentidadTipoFk = -1,
                   PerDocumentoIdentidadNumero = 6732326,
                   PerDocumentoIdentidadExtension = "",
                   PerTParGenDepartamentoFkDocumentoIdentidad = -1
               }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    response?.Mensaje
                );
            }
        }
        private void ConfigurarValidadores()
        {
            // Inicialmente deshabilitar todos los validadores específicos
            //revCedula.Enabled = false;
            //revPasaporte.Enabled = false;
        }
        protected void btnAnteriorAsegurado_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 0; // Volver al paso 1
        }
        protected void btnAnteriorTomador_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 1; // Volver al paso 2 (datos asegurado)
        }
        protected void btnSiguienteTomador_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 3;
            //if (ValidarSeleccionTomador())
            //{
            //    try
            //    {
            //        // Guardar selección en Session
            //        bool tomadorDiferente = rbTomadorDiferenteSi.Checked;
            //        Session["TomadorDiferente"] = tomadorDiferente;

            //        // Determinar el siguiente paso
            //        if (tomadorDiferente)
            //        {
            //            // Ir a formulario de datos del tomador
            //            mvFormulario.ActiveViewIndex = 3; // Paso 4: Datos del tomador
            //        }
            //        else
            //        {
            //            // Usar datos del asegurado como tomador
            //            CopiarDatosAseguradoATomador();
            //            // Ir directamente a selección de productos
            //            mvFormulario.ActiveViewIndex = 4; // Paso 5: Productos
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        MostrarMensaje($"Error al procesar selección: {ex.Message}", "danger");
            //    }
            //}
        }
        protected void btnSiguienteAsegurado_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 2;
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
        protected void ddlTipoDocumentoBuscar_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string tipoDoc = ddlTipoDocumentoBuscar.SelectedValue;

            //// Configurar validadores según tipo de documento
            //switch (tipoDoc)
            //{
            //    case "CI":
            //    case "CE":
            //        revCedula.Enabled = true;
            //        revPasaporte.Enabled = false;
            //        txtNumeroDocumentoBuscar.MaxLength = 8;
            //        break;

            //    case "PASAPORTE":
            //        revCedula.Enabled = false;
            //        revPasaporte.Enabled = true;
            //        txtNumeroDocumentoBuscar.MaxLength = 15;
            //        break;

            //    case "NIT":
            //        revCedula.Enabled = false;
            //        revPasaporte.Enabled = false;
            //        txtNumeroDocumentoBuscar.MaxLength = 10;
            //        divComplementoBuscar.Visible = true;
            //        break;

            //    default:
            //        revCedula.Enabled = false;
            //        revPasaporte.Enabled = false;
            //        divComplementoBuscar.Visible = false;
            //        break;
            //}

            //// Configurar FilteredTextBoxExtender según tipo de documento
            //ftbeNumeroDocumentoBuscar.ValidChars = "";

            //if (tipoDoc == "PASAPORTE")
            //{
            //    ftbeNumeroDocumentoBuscar.FilterType = FilterTypes.UppercaseLetters | FilterTypes.Numbers;
            //}
            //else if (tipoDoc == "NIT")
            //{
            //    ftbeNumeroDocumentoBuscar.FilterType = FilterTypes.Numbers;
            //}
            //else
            //{
            //    ftbeNumeroDocumentoBuscar.FilterType = FilterTypes.Numbers;
            //}
        }

        protected void btnBuscarAsegurado_Click(object sender, EventArgs e)
        {
            BuscarPersona();
            //if (Page.IsValid)
            //{
            //    try
            //    {
            //        string tipoDoc = ddlTipoDocumentoBuscar.SelectedValue;
            //        string numeroDoc = txtNumeroDocumentoBuscar.Text.Trim();
            //        string complemento = txtComplementoBuscar.Text.Trim();
            //        string departamento = ddlDepartamentoExpedicion.SelectedValue;

            //        // Buscar asegurado en base de datos
            //        DataTable dtAsegurado = BuscarAseguradoEnBD(tipoDoc, numeroDoc, complemento);

            //        if (dtAsegurado.Rows.Count > 0)
            //        {
            //            // Mostrar datos del asegurado encontrado
            //            MostrarDatosAsegurado(dtAsegurado.Rows[0]);
            //            pnlResultadoBusqueda.Visible = true;

            //            // Guardar en Session
            //            Session["AseguradoId"] = dtAsegurado.Rows[0]["Id"].ToString();
            //            Session["AseguradoNombre"] = dtAsegurado.Rows[0]["NombreCompleto"].ToString();
            //            Session["AseguradoDocumento"] = $"{tipoDoc}-{numeroDoc}";

            //            MostrarMensaje("Asegurado encontrado exitosamente", "success");
            //        }
            //        else
            //        {
            //            // No encontrado, preguntar si desea crear nuevo
            //            pnlResultadoBusqueda.Visible = false;
            //            MostrarMensaje("No se encontró el asegurado. ¿Desea registrarlo?", "warning");

            //            // Guardar datos para registro
            //            ViewState["DatosParaRegistro"] = new
            //            {
            //                TipoDocumento = tipoDoc,
            //                NumeroDocumento = numeroDoc,
            //                Complemento = complemento,
            //                Departamento = departamento
            //            };
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        MostrarMensaje($"Error al buscar asegurado: {ex.Message}", "danger");
            //    }
            //}
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
            //lblNombreAsegurado.InnerText = row["NombreCompleto"].ToString();
            //lblCorreoAsegurado.InnerText = row["Correo"].ToString();
            //lblCelularAsegurado.InnerText = row["Celular"].ToString();
            //lblDireccionAsegurado.InnerText = row["Direccion"].ToString();
        }

        protected void btnNuevoAsegurado_Click(object sender, EventArgs e)
        {
            // Limpiar formulario para nuevo registro
            LimpiarFormulario();
            // pnlResultadoBusqueda.Visible = false;

            // Opcional: Mostrar formulario extendido para nuevo asegurado
            // mvFormulario.ActiveViewIndex = 1; // Ir a vista de registro
        }

        protected void btnContinuarConAsegurado_Click(object sender, EventArgs e)
        {
            // Continuar al siguiente paso (selección de producto)
            mvFormulario.ActiveViewIndex = 1; // Ir a vista de productos

            // Actualizar título del paso 2 si es necesario
            //    tituloVentaNuevaRenovacion.InnerText = $"Nueva Venta - {Session["AseguradoNombre"]}";
        }

        protected void btnBuscarOtro_Click(object sender, EventArgs e)
        {
            LimpiarFormulario();
            // pnlResultadoBusqueda.Visible = false;
        }

        private void LimpiarFormulario()
        {
            //ddlTipoDocumentoBuscar.SelectedIndex = 0;
            //txtNumeroDocumentoBuscar.Text = "";
            //txtComplementoBuscar.Text = "";
            //ddlDepartamentoExpedicion.SelectedIndex = 0;
            //divComplementoBuscar.Visible = false;
            //pnlMensajeAsegurado.Visible = false;
        }
        protected void btnSiguienteBeneficiarios_Click(object sender, EventArgs e)
        {
            // Validar que si hay beneficiarios, la suma sea 100%
            if (ListaBeneficiarios.Count > 0)
            {
                int totalPorcentaje = ListaBeneficiarios.Sum(b => b.Porcentaje);
                if (totalPorcentaje != 100)
                {
                    MostrarMensaje($"La suma de porcentajes debe ser 100%. Actual: {totalPorcentaje}%", "warning");
                    return;
                }
            }

            // Guardar beneficiarios y continuar
            Session["Beneficiarios"] = ListaBeneficiarios;
            mvFormulario.ActiveViewIndex = Convert.ToInt32(Session["PasoProductos"]);
        }

        protected void btnAnteriorBeneficiarios_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = Convert.ToInt32(Session["PasoAnteriorBeneficiarios"]);
        }

        private void MostrarMensaje(string mensaje, string tipo)
        {
            //pnlMensajeAsegurado.Visible = true;
            //lblMensajeAsegurado.Text = mensaje;

            //switch (tipo)
            //{
            //    case "success":
            //        pnlMensajeAsegurado.CssClass = "alert alert-success alert-dismissible fade show";
            //        break;
            //    case "warning":
            //        pnlMensajeAsegurado.CssClass = "alert alert-warning alert-dismissible fade show";
            //        break;
            //    case "danger":
            //        pnlMensajeAsegurado.CssClass = "alert alert-danger alert-dismissible fade show";
            //        break;
            //    default:
            //        pnlMensajeAsegurado.CssClass = "alert alert-info alert-dismissible fade show";
            //        break;
            //}
        }
        protected void gvBeneficiarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvBeneficiarios.DataKeys[e.RowIndex].Value);
            var lista = ListaBeneficiarios;
            lista.RemoveAll(b => b.Id == id);
            ListaBeneficiarios = lista;

            //   CargarBeneficiarios();
        }

        // Editar beneficiario
        protected void gvBeneficiarios_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(gvBeneficiarios.DataKeys[e.NewEditIndex].Value);
            var beneficiario = ListaBeneficiarios.FirstOrDefault(b => b.Id == id);

            if (beneficiario != null)
            {
                // Llenar modal con datos del beneficiario
                ddlTipoDocumentoBeneficiario.SelectedValue = beneficiario.TipoDocumento;
                txtNumeroDocumentoBeneficiario.Text = beneficiario.NumeroDocumento;
                txtComplementoBeneficiario.Text = beneficiario.Complemento;
                txtNombreCompletoBeneficiario.Text = beneficiario.NombreCompleto;
                ddlParentesco.SelectedValue = beneficiario.Parentesco;
                txtPorcentaje.Text = beneficiario.Porcentaje.ToString();
                txtObservaciones.Text = beneficiario.Observaciones;

                // Mostrar complemento si es NIT
                if (beneficiario.TipoDocumento == "NIT")
                    divComplementoBeneficiario.Visible = true;

                // Configurar modal para edición
                lblModalTitulo.Text = "Editar Beneficiario";
                hfEsEdicion.Value = "true";
                hfBeneficiarioId.Value = beneficiario.Id.ToString();

                ScriptManager.RegisterStartupScript(this, GetType(), "AbrirModal",
                    "$('#modalAgregarBeneficiario').modal('show');", true);
            }
        }
        protected void btnGuardarBeneficiario_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    var beneficiario = new Beneficiario
                    {
                        TipoDocumento = ddlTipoDocumentoBeneficiario.SelectedValue,
                        NumeroDocumento = txtNumeroDocumentoBeneficiario.Text.Trim(),
                        Complemento = txtComplementoBeneficiario.Text.Trim(),
                        NombreCompleto = txtNombreCompletoBeneficiario.Text.Trim(),
                        Parentesco = ddlParentesco.SelectedValue,
                        Porcentaje = Convert.ToInt32(txtPorcentaje.Text),
                        Observaciones = txtObservaciones.Text.Trim()
                    };

                    // Verificar si es edición
                    if (hfEsEdicion.Value == "true" && !string.IsNullOrEmpty(hfBeneficiarioId.Value))
                    {
                        // Actualizar beneficiario existente
                        int id = Convert.ToInt32(hfBeneficiarioId.Value);
                        var lista = ListaBeneficiarios;
                        var index = lista.FindIndex(b => b.Id == id);
                        if (index != -1)
                        {
                            beneficiario.Id = id;
                            lista[index] = beneficiario;
                            ListaBeneficiarios = lista;
                        }
                    }
                    else
                    {
                        // Agregar nuevo beneficiario
                        beneficiario.Id = ListaBeneficiarios.Count > 0 ?
                            ListaBeneficiarios.Max(b => b.Id) + 1 : 1;

                        var lista = ListaBeneficiarios;
                        lista.Add(beneficiario);
                        ListaBeneficiarios = lista;
                    }

                    // Cerrar modal y actualizar lista
                    ScriptManager.RegisterStartupScript(this, GetType(), "CerrarModal",
                        "$('#modalAgregarBeneficiario').modal('hide');", true);

                    //    CargarBeneficiarios();
                    LimpiarModal();
                }
                catch (Exception ex)
                {
                    MostrarMensaje($"Error al guardar beneficiario: {ex.Message}", "danger");
                }
            }
        }

        private void LimpiarModal()
        {
            ddlTipoDocumentoBeneficiario.SelectedIndex = 0;
            txtNumeroDocumentoBeneficiario.Text = "";
            txtComplementoBeneficiario.Text = "";
            txtNombreCompletoBeneficiario.Text = "";
            ddlParentesco.SelectedIndex = 0;
            txtPorcentaje.Text = "";
            txtObservaciones.Text = "";
            divComplementoBeneficiario.Visible = false;
        }
        public class Beneficiario
        {
            public int Id { get; set; }
            public string TipoDocumento { get; set; }
            public string NumeroDocumento { get; set; }
            public string Complemento { get; set; }
            public string NombreCompleto { get; set; }
            public string Parentesco { get; set; }
            public string ParentescoNombre
            {
                get
                {
                    switch (Parentesco)
                    {
                        case "C": return "Cónyuge";
                        case "H": return "Hijo(a)";
                        case "P": return "Padre/Madre";
                        case "B": return "Hermano(a)";
                        case "O": return "Otro";
                        default: return Parentesco;
                    }
                }
            }
            public int Porcentaje { get; set; }
            public string Observaciones { get; set; }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }
    }

}