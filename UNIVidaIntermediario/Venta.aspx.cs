using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using UNIVidaIntermediario.Utils;
using UNIVidaIntermediarioService.Models;
using UNIVidaIntermediarioService.Models.PasarelaPagos;
using UNIVidaSoatService.Models.Soatc;

namespace UNIVidaIntermediario
{
    public partial class Venta : System.Web.UI.Page
    {
        private static readonly Random _random = new Random();

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
        protected CliPN01ObtenerDatosResponse DatosAsegurado
        {
            get
            {
                return ViewState["DatosAsegurado"] as CliPN01ObtenerDatosResponse ??
                       new CliPN01ObtenerDatosResponse();
            }
            set
            {
                ViewState["DatosAsegurado"] = value;
            }
        }
        protected CliPN01ObtenerDatosResponse DatosTomador
        {
            get
            {
                return ViewState["DatosTomador"] as CliPN01ObtenerDatosResponse ??
                       new CliPN01ObtenerDatosResponse();
            }
            set
            {
                ViewState["DatosTomador"] = value;
            }
        }


        private List<Lpolbenbeneficiario> ListaBeneficiarios
        {
            get
            {
                if (Session["Beneficiarios"] == null)
                    Session["Beneficiarios"] = new List<Lpolbenbeneficiario>();
                return (List<Lpolbenbeneficiario>)Session["Beneficiarios"];
            }
            set { Session["Beneficiarios"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ParObtenerTipoDocIdentidad();
            }
            if (Request["__EVENTTARGET"] == "NuevoAsegurado")
            {
                NuevoAsegurado();
            }
            if (Request["__EVENTTARGET"] == "NuevoTomador")
            {
                NuevoTomador();
            }
        }
        private void NuevoAsegurado()
        {

            DatosAsegurado = new CliPN01ObtenerDatosResponse() { PerDocumentoIdentidadNumero = int.Parse(txtDocumentoBusqueda.Text) };
            DatosAsegurado.EsNuevo = true;
            mvFormulario.ActiveViewIndex = 1;
            CargarDatosPaso2();
        }
        private void NuevoTomador()
        {

            DatosTomador = new CliPN01ObtenerDatosResponse() { PerDocumentoIdentidadNumero = int.Parse(txtDocumentoBusquedaTomador.Text) };
            DatosTomador.EsNuevo = true;
            mvFormulario.ActiveViewIndex = 4;
            CargarDatosPaso4();
        }
        protected void gvClientes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarCliente")
            {
                // Separar los datos del CommandArgument
                int perSecuencial = int.Parse(e.CommandArgument.ToString());
                List<CliPN01ObtenerDatosResponse> asegurados = (List<CliPN01ObtenerDatosResponse>)Session["MultiplesAsegurados"];
                DatosAsegurado = asegurados.Where(x => x.PerSecuencial == perSecuencial).FirstOrDefault();
                var validaCobertura = ValidarCoberturaAsegurado();
                if (validaCobertura.Exito)
                {
                    WebFormHelpers.EjecutarNotificacion(
                                        this,
                                        "info",
                                        "El cliente cuenta con cobertura de SOATC con los siguientes datos: " + validaCobertura.oSDatos.DatosAsegurado
                                    );
                }
                else
                {
                    mvFormulario.ActiveViewIndex = 1; // paso 2
                    CargarDatosPaso2();
                }

            }
        }

        protected void gvClientesTomador_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SeleccionarCliente")
            {
                // Separar los datos del CommandArgument
                int perSecuencial = int.Parse(e.CommandArgument.ToString());
                List<CliPN01ObtenerDatosResponse> tomador = (List<CliPN01ObtenerDatosResponse>)Session["MultiplesAsegurados"];
                DatosTomador = tomador.Where(x => x.PerSecuencial == perSecuencial).FirstOrDefault();
                mvFormulario.ActiveViewIndex = 4; // paso 5
                CargarDatosPaso4();
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
        private ServiceApiResponse<CliPN03ValidarCoberturaAseguradoResponse> ValidarCoberturaAsegurado()
        {

            var response = WebFormHelpers.ConsumirMetodoApi<CliPN03ValidarCoberturaAseguradoResponse>(
                "CoreTecnico",
                "ClientesPN",
                "CliPN03ValidarCoberturaAsegurado",
                new
                {
                    TPolizaDetalleFk = -1,
                    TParCliDocumentoIdentidadTipoFk = DatosAsegurado.PerTParCliDocumentoIdentidadTipoFk,
                    DocumentoIdentidadNumero = DatosAsegurado.PerDocumentoIdentidadNumero,
                    DocumentoIdentidadExtension = DatosAsegurado.PerDocumentoIdentidadExtension
                }
            );
            return response;
        }

        private void BuscarAsegurado()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<CliPN01ObtenerDatosResponse>>(
                "CoreTecnico",
                "ClientesPN",
                "CliPN01ObtenerDatos",
               new
               {
                   PerTParCliDocumentoIdentidadTipoFk = -1,
                   PerDocumentoIdentidadNumero = txtDocumentoBusqueda.Text,
                   PerDocumentoIdentidadExtension = "",
                   PerTParGenDepartamentoFkDocumentoIdentidad = -1
               }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                //WebFormHelpers.EjecutarNotificacion(
                //    this,
                //    "success",
                //    response?.Mensaje
                //);
                if (response.oSDatos.Count() == 1)
                {
                    DatosAsegurado = response.oSDatos[0];
                    DatosAsegurado.EsNuevo = false;
                    var validaCobertura = ValidarCoberturaAsegurado();
                    if (validaCobertura.Exito)
                    {
                        WebFormHelpers.EjecutarNotificacion(
                                            this,
                                            "info",
                                            "El cliente cuenta con cobertura de SOATC con los siguientes datos: " + validaCobertura.oSDatos.DatosAsegurado
                                        );

                    }
                    else
                    {
                        mvFormulario.ActiveViewIndex = 1; // paso 2
                        CargarDatosPaso2();

                    }
                    gvClientes.DataSource = null;
                    divGridAsegurados.Visible = false;

                }
                else
                {
                    divGridAsegurados.Visible = true;
                    gvClientes.DataSource = response.oSDatos;
                    Session["MultiplesAsegurados"] = response.oSDatos;
                    gvClientes.DataBind();

                }
            }
            else
            {

                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    response?.Mensaje
                );
                if (response?.Mensaje == "La información del cliente no pudo ser obtenida.")
                {
                    string script = @"
                    Swal.fire({
                        title: 'Atención!',
                        text: 'El cliente no se encuentra registrado. ¿Desea registrarlo ahora?',
                        type: 'info', // en v7.x se usa 'type' en lugar de 'icon'
                        showCancelButton: true,
                        confirmButtonText: 'Sí',
                        cancelButtonText: 'No',
                        allowOutsideClick: false
                    }).then(function(result){
                        if(result.value) { // en v7.x se usa 'value' para saber si confirmó
                            __doPostBack('NuevoAsegurado');
                        }
                    });
                ";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SwalBackend", script, true);

                }

            }
        }
        private void BuscarTomador()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<CliPN01ObtenerDatosResponse>>(
                "CoreTecnico",
                "ClientesPN",
                "CliPN01ObtenerDatos",
               new
               {
                   PerTParCliDocumentoIdentidadTipoFk = -1,
                   PerDocumentoIdentidadNumero = txtDocumentoBusquedaTomador.Text,
                   PerDocumentoIdentidadExtension = "",
                   PerTParGenDepartamentoFkDocumentoIdentidad = -1
               }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "success",
                    response?.Mensaje
                );
                if (response.oSDatos.Count() == 1)
                {
                    DatosTomador = response.oSDatos[0];
                    DatosTomador.EsNuevo = false;
                    mvFormulario.ActiveViewIndex = 4; // paso 5
                    CargarDatosPaso4();
                    gvClientesTomador.DataSource = null;
                    divGridAsegurados.Visible = false;
                }
                else
                {
                    divGridTomador.Visible = true;
                    gvClientesTomador.DataSource = response.oSDatos;
                    Session["MultiplesTomadores"] = response.oSDatos;
                    gvClientesTomador.DataBind();

                }
            }
            else
            {

                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    response?.Mensaje
                );
                if (response?.Mensaje == "La información del cliente no pudo ser obtenida.")
                {
                    string script = @"
                    Swal.fire({
                        title: 'Atención!',
                        text: 'El cliente no se encuentra registrado. ¿Desea registrarlo ahora?',
                        type: 'info', // en v7.x se usa 'type' en lugar de 'icon'
                        showCancelButton: true,
                        confirmButtonText: 'Sí',
                        cancelButtonText: 'No',
                        allowOutsideClick: false
                    }).then(function(result){
                        if(result.value) { // en v7.x se usa 'value' para saber si confirmó
                            __doPostBack('NuevoTomador');
                        }
                    });
                ";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "SwalBackend", script, true);

                }

            }
        }


        protected void btnAnterior1_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 0; // Volver al paso 1
        }
        protected void btnAnterior2_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 1; // Volver al paso 2 (datos asegurado)
        }
        protected void btnSiguiente2_Click(object sender, EventArgs e)
        {
            bool tomadorDiferente = rbTomadorDiferenteSi.Checked;


            if (tomadorDiferente)
            {
                // Ir a formulario de datos del tomador
                mvFormulario.ActiveViewIndex = 3; // Paso 4: Busqueda de cliente tomador
            }
            else
            {
                //cargamos los datos del asegurado por defecto para evitar errores
                // DatosTomador = DatosAsegurado;
                ucTomador.CargarDatos(DatosAsegurado);
                mvFormulario.ActiveViewIndex = 5; // Paso 5: beneficiarios
                Session["PasoAnteriorBeneficiarios"] = "2";
            }

        }
        protected void btnSiguiente1_Click(object sender, EventArgs e)
        {
            var datosAseguradoResponse = ucAsegurado.ObtenerDatosFormulario();
            Emi01PolizaEmitirPDFRequest datos = new Emi01PolizaEmitirPDFRequest
            {
                PolMaeTParGenDepartamentoFk = datosAseguradoResponse.PolMaeTParGenDepartamentoFk,
                PolMaeTProductoPlanPrimaFk = 25,//SOATC
                lPolBenBeneficiario = ListaBeneficiarios,
                oEDatosAsegurado = datosAseguradoResponse,
                oEDatosTomador = datosAseguradoResponse,
                oETransaccionIdentificador = new Oetransaccionidentificador
                {
                    TraIdeLlaveA = DateTime.Now.ToString("yyyyMMddHHmmss"),
                    TraIdeLlaveB = _random.Next(100000, 999999).ToString()
                }
            };
            var validarVendible = Emi11PolizaEfectivizarValidarVendible(datos);
            if (validarVendible.Exito)
                mvFormulario.ActiveViewIndex = 2;
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    validarVendible.Mensaje
                );

            }
        }
        protected void ddlTipoDocumentoBuscar_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnBuscarAsegurado_Click(object sender, EventArgs e)
        {
            BuscarAsegurado();

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
                int totalPorcentaje = ListaBeneficiarios.Sum(b => b.PolBenBeneficioPorcentaje);
                if (totalPorcentaje != 100)
                {
                    MostrarMensaje($"La suma de porcentajes debe ser 100%. Actual: {totalPorcentaje}%", "warning");
                    return;
                }
            }

            // Guardar beneficiarios y continuar
            Session["Beneficiarios"] = ListaBeneficiarios;
            mvFormulario.ActiveViewIndex = 6;
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

            CargarBeneficiarios();
        }

        //// Editar beneficiario
        //protected void gvBeneficiarios_RowEditing(object sender, GridViewEditEventArgs e)
        //{
        //    int id = Convert.ToInt32(gvBeneficiarios.DataKeys[e.NewEditIndex].Value);
        //    var beneficiario = ListaBeneficiarios.FirstOrDefault(b => b.Id == id);

        //    if (beneficiario != null)
        //    {
        //        // Llenar modal con datos del beneficiario
        //        //ddlTipoDocumentoBeneficiario.SelectedValue = beneficiario.TipoDocumento;
        //        //txtNumeroDocumentoBeneficiario.Text = beneficiario.NumeroDocumento;
        //        //txtComplementoBeneficiario.Text = beneficiario.Complemento;
        //        txtNombreCompletoBeneficiario.Text = beneficiario.PolBenNombreCompleto;
        //        ddlParentesco.SelectedValue = beneficiario.PolBenTParEmiBeneficiarioParentescoFk.ToString();
        //        txtPorcentaje.Text = beneficiario.PolBenBeneficioPorcentaje.ToString();

        //        // Mostrar complemento si es NIT
        //        //if (beneficiario.TipoDocumento == "NIT")
        //        //    divComplementoBeneficiario.Visible = true;

        //        // Configurar modal para edición
        //        lblModalTitulo.Text = "Editar Beneficiario";
        //        hfEsEdicion.Value = "true";
        //        hfBeneficiarioId.Value = beneficiario.Id.ToString();

        //        ScriptManager.RegisterStartupScript(this, GetType(), "AbrirModal",
        //            "$('#modalAgregarBeneficiario').modal('show');", true);
        //    }
        //}
        protected void btnGuardarBeneficiario_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    var beneficiario = new Lpolbenbeneficiario
                    {
                        //TipoDocumento = ddlTipoDocumentoBeneficiario.SelectedValue,
                        //NumeroDocumento = txtNumeroDocumentoBeneficiario.Text.Trim(),
                        //Complemento = txtComplementoBeneficiario.Text.Trim(),
                        PolBenNombreCompleto = txtNombreCompletoBeneficiario.Text.Trim(),
                        PolBenTParEmiBeneficiarioParentescoFk = int.Parse(ddlParentesco.SelectedValue),
                        PolBenBeneficioPorcentaje = Convert.ToInt32(txtPorcentaje.Text)

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

                    CargarBeneficiarios();
                    LimpiarModal();
                }
                catch (Exception ex)
                {
                    MostrarMensaje($"Error al guardar beneficiario: {ex.Message}", "danger");
                }
            }
        }
        private void CargarBeneficiarios()
        {
            gvBeneficiarios.DataSource = ListaBeneficiarios;
            gvBeneficiarios.DataBind();

            gvBeneficiarios.Visible = ListaBeneficiarios.Any();
            pnlListaVacia.Visible = !ListaBeneficiarios.Any();
        }
        private void LimpiarModal()
        {
            //ddlTipoDocumentoBeneficiario.SelectedIndex = 0;
            //txtNumeroDocumentoBeneficiario.Text = "";
            //txtComplementoBeneficiario.Text = "";
            txtNombreCompletoBeneficiario.Text = "";
            ddlParentesco.SelectedIndex = 0;
            txtPorcentaje.Text = "";
            // txtObservaciones.Text = "";
            //    divComplementoBeneficiario.Visible = false;
        }


        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        //protected void mvFormulario_ActiveViewChanged(object sender, EventArgs e)
        //{
        //    if (mvFormulario.ActiveViewIndex == 1)
        //    {
        //        CargarDatosPaso2();
        //    }
        //    if (mvFormulario.ActiveViewIndex == 4)
        //    {
        //        CargarDatosPaso4();
        //    }
        //}

        private void CargarDatosPaso2()
        {
            ucAsegurado.CargarDatos(DatosAsegurado);
        }
        private void CargarDatosPaso4()
        {
            ucTomador.CargarDatos(DatosTomador);
        }


        protected void btnAnterior3_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 2;
        }

        protected void btnSiguiente3_Click(object sender, EventArgs e)
        {
            BuscarTomador();
        }
        protected void btnAnterior4_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 3;
        }

        protected void btnSiguiente4_Click(object sender, EventArgs e)
        {
            var datosTomadorResponse = ucTomador.ObtenerDatosFormulario();
            Emi01PolizaEmitirPDFRequest datos = new Emi01PolizaEmitirPDFRequest
            {
                PolMaeTParGenDepartamentoFk = datosTomadorResponse.PolMaeTParGenDepartamentoFk,
                PolMaeTProductoPlanPrimaFk = 25,//SOATC
                lPolBenBeneficiario = ListaBeneficiarios,
                oEDatosAsegurado = datosTomadorResponse,
                oEDatosTomador = datosTomadorResponse,
                oETransaccionIdentificador = new Oetransaccionidentificador
                {
                    TraIdeLlaveA = DateTime.Now.ToString("yyyyMMddHHmmss"),
                    TraIdeLlaveB = _random.Next(100000, 999999).ToString()
                }
            };
            var validarVendible = Emi11PolizaEfectivizarValidarVendible(datos);
            if (validarVendible.Exito)
            {
                mvFormulario.ActiveViewIndex = 5;
                Session["PasoAnteriorBeneficiarios"] = "4";
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    validarVendible.Mensaje
                );

            }
        }

        protected void btnAnteriorFacturacion_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 5;
        }

        protected void btnSiguienteFacturacion_Click(object sender, EventArgs e)
        {
            bool tomadorDiferente = rbTomadorDiferenteSi.Checked;
            var datosAseguradoResponse = ucAsegurado.ObtenerDatosFormulario();
            var datosTomadorResponse = datosAseguradoResponse;
            if (tomadorDiferente)
            {
                datosTomadorResponse = ucTomador.ObtenerDatosFormulario();
            }
            Emi01PolizaEmitirPDFRequest datos = new Emi01PolizaEmitirPDFRequest
            {
                PolMaeTParGenDepartamentoFk = datosAseguradoResponse.PolMaeTParGenDepartamentoFk,
                PolMaeTProductoPlanPrimaFk = 25,//SOATC
                lPolBenBeneficiario = ListaBeneficiarios,
                oEDatosAsegurado = datosAseguradoResponse,
                oEDatosTomador = datosTomadorResponse,
                oETransaccionIdentificador = new Oetransaccionidentificador
                {
                    TraIdeLlaveA = DateTime.Now.ToString("yyyyMMddHHmmss"),
                    TraIdeLlaveB = _random.Next(100000, 999999).ToString()
                }
            };
            var respuesta = Emi01PolizaEmitirPDF(datos);
            if (respuesta.Exito)
            {
                mvFormulario.ActiveViewIndex = 7;
                var archivoAdjunto = respuesta.oSDatos.oArchivosAdjuntos;
                if (archivoAdjunto == null)
                    return;
                string base64 = archivoAdjunto.ArchivoAdjunto;
                pdfViewer.Attributes["src"] = "data:application/pdf;base64," + base64;

                WebFormHelpers.EjecutarNotificacion(
                                    this,
                                    "success",
                                   respuesta.Mensaje
                                );
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    respuesta.Mensaje
                );
            }
        }

        private ServiceApiResponse<Object> Emi11PolizaEfectivizarValidarVendible(Emi01PolizaEmitirPDFRequest emi01PolizaEmitirPDFRequest)
        {
            var response = WebFormHelpers.ConsumirMetodoApi<Object>(
                "CoreTecnico",
                "Emision",
                "Emi01PolizaEmitirPDF",
                emi01PolizaEmitirPDFRequest
            );
            return response;
        }

        private ServiceApiResponse<Emi01PolizaEmitirPDFResponse> Emi01PolizaEmitirPDF(Emi01PolizaEmitirPDFRequest emi01PolizaEmitirPDFRequest)
        {
            var response = WebFormHelpers.ConsumirMetodoApi<Emi01PolizaEmitirPDFResponse>(
                "CoreTecnico",
                "Emision",
                "Emi11PolizaEfectivizarValidarVendible",
                emi01PolizaEmitirPDFRequest
            );
            return response;
        }

        protected void btnCerrarFormularioVenta_Click(object sender, EventArgs e)
        {

            ViewState.Clear();

            Session.Remove("Beneficiarios");
            Session.Remove("MultiplesAsegurados");
            Session.Remove("MultiplesTomadores");
            Session.Remove("PasoAnteriorBeneficiarios");

            TiposDocumentos = new List<ParObtenerTipoDocIdentidadResponse>();
            DatosAsegurado = new CliPN01ObtenerDatosResponse();
            DatosTomador = new CliPN01ObtenerDatosResponse();
            ListaBeneficiarios = new List<Lpolbenbeneficiario>();

            mvFormulario.ActiveViewIndex = 0;
        }
    }

}