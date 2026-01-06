using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using UNIVidaIntermediarioService.Models;
using UNIVidaIntermediarioService.Models.PasarelaPagos;
using UNIVidaIntermediarioService.Models.Soat;
using UNIVidaIntermediario.Utils;

namespace UNIVidaIntermediario
{
    public partial class Venta1 : System.Web.UI.Page
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
        protected int Prima
        {
            get
            {
                return (int)(ViewState["Prima"] ?? 0);
            }
            set
            {
                ViewState["Prima"] = value;
            }
        }


        protected List<ParObtenerDepartamentosResponse> Departamentos
        {
            get
            {
                return ViewState["Departamentos"] as List<ParObtenerDepartamentosResponse> ??
                       new List<ParObtenerDepartamentosResponse>();
            }
            set
            {
                ViewState["Departamentos"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["NombreUsuario"] == null)
            {
                Response.Redirect(FormsAuthentication.LoginUrl, true);
            }
            else
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetNoStore();
                Response.AppendHeader("Pragma", "no-cache");
                Response.Expires = -1;
            }
            if (!IsPostBack)
            {
                InicializarParametros();
            }
            string controlID = GetPostBackControlId();

            System.Diagnostics.Debug.WriteLine("Postback originado por: " + controlID);
            if (Request.Params["__EVENTTARGET"] == "AperturarPasoDocumento")
            {
                AperturarPasoDocumento();
            }

        }

        private void AperturarPasoDocumento()
        {
            
            var response = Ven05ObtenerPDF();
            if (response.Exito)
            {                
                mvFormulario.ActiveViewIndex = 4;
                var archivoAdjunto = response.oSDatos.oArchivosAdjuntos;
                if (archivoAdjunto == null)
                    return;
                string base64 = Convert.ToBase64String(archivoAdjunto.ArchivoAdjunto);
                pdfViewer.Attributes["src"] = "data:application/pdf;base64," + base64;
            }

        }

        private string GetPostBackControlId()
        {
            string ctrlName = Page.Request.Params["__EVENTTARGET"];
            if (!string.IsNullOrEmpty(ctrlName))
            {
                return ctrlName;
            }

            // Si __EVENTTARGET está vacío, probablemente fue un submit desde un botón o Enter en un TextBox
            foreach (string ctl in Request.Form)
            {
                Control c = Page.FindControl(ctl);
                if (c is System.Web.UI.WebControls.Button || c is System.Web.UI.WebControls.ImageButton)
                {
                    return ctl;
                }
            }
            return null;
        }
        private void InicializarParametros()
        {
            ddlTipoIdentificacion.SelectedValue = "1";
            ParObtenerPlacasTipo();
            ParObtenerGestion();
            ParObtenerVehiculoTipos();
            ParObtenerVehiculoUsos();
            ParObtenerDepartamentos();
            ParObtenerTipoDocIdentidad();

        }
        private void Ven02ObtenerPrima()
        {
            var datos = new Ven02ObtenerPrimaRequest
            {
                SoatTParDepartamentoPcFk = ddlPlazaCirculacion.SelectedValue.ToString(),
                SoatTParVehiculoTipoFk = int.Parse(ddlTipoVehiculo.SelectedValue.ToString()),
                SoatTParVehiculoUsoFk = int.Parse(ddlTipoUso.SelectedValue.ToString()),
                VehiPlaca = txtItentificador.Text,
                SoatTParGestionFk = int.Parse(ddlGestion.SelectedValue.ToString()),
            };

            var response = WebFormHelpers.ConsumirMetodoApi<Ven02ObtenerPrimaResponse>(
                "CoreSOAT",
                "Ventas",
                "Ven02ObtenerPrima",
                datos
            );

            if (response != null && response.Exito && response.oSDatos != null)
            {
                Prima = response.oSDatos.Prima;
            }
            else
            {
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    response.Mensaje
                );
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
        private void ParObtenerPlacasTipo()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<ParObtenerPlacasTipoResponse>>(
                "CoreSOAT",
                "Parametricas",
                "ParObtenerPlacasTipo",
                new { }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlTipoIdentificacion,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Secuencial.ToString()
                );
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

        private void ParObtenerVehiculoTipos()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<ParObtenerVehiculoTiposResponse>>(
                "CoreSOAT",
                "Parametricas",
                "ParObtenerVehiculoTipos",
                new { }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlTipoVehiculo,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Secuencial.ToString()
                );
                ddlTipoVehiculo.Items.Insert(0, new ListItem("Seleccione una opción", "0"));
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
        private void ParObtenerVehiculoUsos()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<ParObtenerVehiculoUsosResponse>>(
                "CoreSOAT",
                "Parametricas",
                "ParObtenerVehiculoUsos",
                new { }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlTipoUso,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.Secuencial.ToString()
                );
                ddlTipoUso.Items.Insert(0, new ListItem("Seleccione una opción", "0"));
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

        private void ParObtenerGestion()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<ParObtenerGestionResponse>>(
                "CoreSOAT",
                "Parametricas",
                "ParObtenerGestion",
                new { }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlGestion,
                    response.oSDatos,
                    item => item.Secuencial.ToString(),
                    item => item.Secuencial.ToString()
                );
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

        private void ParObtenerDepartamentos()
        {
            var response = WebFormHelpers.ConsumirMetodoApi<List<ParObtenerDepartamentosResponse>>(
                "CoreSOAT",
                "Parametricas",
                "ParObtenerDepartamentos",
                new { }
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                WebFormHelpers.CargarDropDownList(
                    ddlPlazaCirculacion,
                    response.oSDatos,
                    item => item.Descripcion,
                    item => item.CodigoDepartamento
                );
                Departamentos = response.oSDatos;
                ddlPlazaCirculacion.Items.Insert(0, new ListItem("Seleccione una opción", "0"));
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

        private ServiceApiResponse<Ven01ValidarVendibleYObtenerDatosResponse> Ven01ValidarVendibleYObtenerDatos()
        {
            var datos = new DatosValidarVendibleRequest
            {
                VehiPlaca = txtItentificador.Text.ToUpper(),
                SoatTParGestionFk = int.Parse(ddlGestion.SelectedValue.ToString()),
                VehiTParPlacaTipo = int.Parse(ddlTipoIdentificacion.SelectedValue.ToString())
            };

            var response = WebFormHelpers.ConsumirMetodoApi<Ven01ValidarVendibleYObtenerDatosResponse>(
                "CoreSOAT",
                "Ventas",
                "Ven01ValidarVendibleYObtenerDatos",
                datos
            );
            return response;
        }
        private ServiceApiResponse<Ven05ObtenerPDFResponse> Ven05ObtenerPDF()
        {
            int soatNroComprobante=hfTVehiSoatPropFk.Value != "" ? int.Parse(hfTVehiSoatPropFk.Value) : 0;
            var datos = new Ven05ObtenerPDFRequest
            {
                PdfConDiseño = false,
                SoatNroComprobante = soatNroComprobante,
                lSoatDocumentosSolicitados = new Lsoatdocumentossolicitado[]
    {
        new Lsoatdocumentossolicitado { DocumentoTipo = 1, DocumentoRequerido = false },
        new Lsoatdocumentossolicitado { DocumentoTipo = 2, DocumentoRequerido = false },
        new Lsoatdocumentossolicitado { DocumentoTipo = 3, DocumentoRequerido = true },
        new Lsoatdocumentossolicitado { DocumentoTipo = 4, DocumentoRequerido = false },
        new Lsoatdocumentossolicitado { DocumentoTipo = 5, DocumentoRequerido = false },
        new Lsoatdocumentossolicitado { DocumentoTipo = 6, DocumentoRequerido = false }
    }
            };

            var response = WebFormHelpers.ConsumirMetodoApi<Ven05ObtenerPDFResponse>(
                "CoreSOAT",
                "Ventas",
                "Ven05ObtenerPDF",
                datos
            );
            return response;
        }
        private ServiceApiResponse<Ven01ValidarVendibleYObtenerDatosResponse> Ven01ValidarVendible(CDatosFactura oDatosFactura)
        {
            var datos = new Ven01ValidarVendibleRequest
            {
                VehiPlaca = txtItentificador.Text.ToUpper(),
                SoatTParGestionFk = int.Parse(ddlGestion.SelectedValue.ToString()),
                TParCriterioBusquedaDetalleFk = int.Parse(ddlTipoIdentificacion.SelectedValue.ToString()),
                DatosFacturacion = oDatosFactura
            };

            var response = WebFormHelpers.ConsumirMetodoApi<Ven01ValidarVendibleYObtenerDatosResponse>(
                "CoreSOAT",
                "Ventas",
                "Ven01ValidarVendible",
                datos
            );
            return response;
        }
        private string ArmarParametrosEjecucion()
        {
            var parametrosConfiguracion = new ParametrosConfiguracion();
            var parametros = new ParametrosEjecucionRequest
            {
                PdfConDiseno = true,
                VehiPlaca = txtItentificador.Text.ToUpper(),
                SoatTParDepartamentoPcFk = ddlPlazaCirculacion.SelectedValue.ToUpper(),
                SoatTParVehiculoTipoFk = int.Parse(ddlTipoVehiculo.SelectedValue.ToString()),
                LsoatDocumentosSolicitados = new List<DocumentosSolicitados>
        {
            new DocumentosSolicitados { DocumentoRequerido = false, DocumentoTipo = 1 },
            new DocumentosSolicitados { DocumentoRequerido = false, DocumentoTipo = 2 },
            new DocumentosSolicitados { DocumentoRequerido = false, DocumentoTipo = 3 },
            new DocumentosSolicitados { DocumentoRequerido = false, DocumentoTipo = 4 },
            new DocumentosSolicitados { DocumentoRequerido = false, DocumentoTipo = 5 },
            new DocumentosSolicitados { DocumentoRequerido = false, DocumentoTipo = 6 }
        },
                SoatRosetaNumero = 0,
                SoatTParGestionFk = int.Parse(ddlGestion.SelectedValue),
                SoatTParVehiculoUsoFk = int.Parse(ddlTipoUso.SelectedValue),
                SoatTParDepartamentoVtFk = ddlPlazaCirculacion.SelectedValue.ToString(),
                SoatTParMedioPagoFk = 30,//QR
                TparCriterioBusquedaDetalleFk = int.Parse(ddlTipoIdentificacion.SelectedValue),
                FactPrima = Prima,
                FactRazonSocial = txtRazonSocial.Text.ToUpper(),
                FactNitCi = txtNumeroDocumento.Text.ToUpper(),
                FactTipoDocIdentidadFk = int.Parse(ddlTipoDocumento.SelectedValue),
                FactCorreoCliente = txtCorreo.Text.ToString(),
                FactTelefonoCliente = txtCelular.Text.ToString(),
                FactCiComplemento = txtComplemento.Text.ToUpper(),
            };
            var paraMetrosEjecucion = new ServiceApiRequest
            {
                Sistema = "CoreSOAT",
                Modulo = "Ventas",
                Metodo = "Ven03EfectivizarPDFS",
                Parametros = new ParametrosRequest
                {
                    oEDatos = parametros,
                    oESeguridadExterna = new SeguridadExternaRequest
                    {
                        SegExtToken = long.Parse(Session["TokenSeguridad"].ToString()),
                        SegExtUsuario = Session["NombreUsuario"].ToString()
                    },
                    oETransaccionOrigen = new TransaccionOrigenRequest
                    {
                        TraOriCajero = Session["NombreUsuario"].ToString(),
                        TraOriCanal = parametrosConfiguracion.TraOriCanal,
                        TraOriEntidad = "Univida",
                        TraOriIntermediario = 0,
                        TraOriSucursal = "10100",
                        TraOriAgencia = ""
                    }
                }
            };

            return JsonConvert.SerializeObject(paraMetrosEjecucion);

        }
        private ServiceApiResponse<ObtenerResponse> Obtener()
        {
            var jsonParametrosEjecucion = ArmarParametrosEjecucion();
            var parametros = new ParametrosConfiguracion();
            Random random = new Random();
            var datos = new ObtenerRequest
            {
                CodigoUnico = 0,
                TipoTramite = parametros.TipoTramite,
                ParametrosEjecucion = jsonParametrosEjecucion,
                oDatosQR = new Odatosqr
                {
                    Importe = Prima,
                    Referencia = "Compra de soat " + ddlGestion.SelectedValue.ToString(),
                    CorreoNotificacion = txtCorreo.Text,
                    Variable1 = txtItentificador.Text,
                    Variable2 = ddlGestion.SelectedValue.ToString(),
                }
            };

            var response = WebFormHelpers.ConsumirMetodoApi<ObtenerResponse>(
                "CoreSOAT",
                "Ventas",
                "VenQrObtener",
                datos
            );
            return response;
        }
        private ServiceApiResponse<object> Anular()
        {

            var parametros = new ParametrosConfiguracion();
            Random random = new Random();
            int numeroAleatorio = random.Next(0, int.MaxValue);
            var datos = new VenQrAnularRequest
            {
                CodigoUnico = int.Parse(hfCodigoUnico.Value),
                TipoTramite = parametros.TipoTramite,
            };

            var response = WebFormHelpers.ConsumirMetodoApi<object>(
                "CoreSOAT",
                "Ventas",
                "VenQrAnular",
                datos
            );
            return response;
        }

        protected void btnSiguiente1_Click(object sender, EventArgs e)
        {
            var response = Ven01ValidarVendibleYObtenerDatos();
            if (response.Exito)
            {
                mvFormulario.ActiveViewIndex = 1;
                if (response.oSDatos != null)
                {
                    ddlTipoVehiculo.SelectedValue = response.oSDatos.SoatTParVehiculoTipoFk.ToString();
                    ddlTipoUso.SelectedValue = response.oSDatos.SoatTParVehiculoUsoFk.ToString();
                    ddlPlazaCirculacion.SelectedValue = response.oSDatos.SoatTParDepartamentoPcFk.ToString();
                    ddlTipoVehiculo.Enabled = false;
                    tituloVentaNuevaRenovacion.InnerText = "Renovación Soat " + ddlGestion.SelectedValue.ToString();


                }
                else
                {
                    ddlTipoVehiculo.SelectedValue = "0";
                    ddlTipoUso.SelectedValue = "0";
                    ddlPlazaCirculacion.SelectedValue = "0";
                    ddlTipoVehiculo.Enabled = true;
                    tituloVentaNuevaRenovacion.InnerText = "Venta nueva Soat " + ddlGestion.SelectedValue.ToString();
                }


            }
            else
            {
                lblMensaje.Text = response.Mensaje;
                divMensaje.Visible = true;
            }

        }
        private void CargarIcono()
        {
            string selectedValue = ddlTipoVehiculo.SelectedValue;
            string iconHtml;
            string baseClasses = "fa-3x me-3"; // Clases base para todos los iconos

            switch (selectedValue)
            {
                case "1": // Motocicleta
                    iconHtml = $"<i class='fa-solid fa-motorcycle {baseClasses} text-success'></i>";
                    break;
                case "2": // Automóvil
                    iconHtml = $"<i class='fa-solid fa-car {baseClasses} text-primary'></i>";
                    break;
                case "3": // Jeep
                    iconHtml = $"<i class='fa-solid fa-car-side {baseClasses} text-warning'></i>"; // Reemplazo de Jeep
                    break;
                case "4": // Camioneta
                    iconHtml = $"<i class='fa-solid fa-truck-pickup {baseClasses} text-info'></i>";
                    break;
                case "5": // Vagoneta
                    iconHtml = $"<i class='fa-solid fa-car {baseClasses} text-primary'></i>"; // Vagoneta
                    break;
                case "6": // Microbús
                    iconHtml = $"<i class='fa-solid fa-bus-simple {baseClasses} text-dark'></i>";
                    break;
                case "7": // Colectivo
                    iconHtml = $"<i class='fa-solid fa-bus {baseClasses} text-dark'></i>";
                    break;
                case "8": // Ómnibus
                    iconHtml = $"<i class='fa-solid fa-bus {baseClasses} text-primary'></i>";
                    break;
                case "9": // Tracto camión
                    iconHtml = $"<i class='fa-solid fa-truck-monster {baseClasses} text-danger'></i>"; // Reemplazo de Tracto camión
                    break;
                case "10": // Minibús 8 ocupantes
                case "11": // Minibús 11 ocupantes
                case "12": // Minibús 15 ocupantes
                    iconHtml = $"<i class='fa-solid fa-van-shuttle {baseClasses} text-secondary'></i>"; // Minibús
                    break;
                case "13": // Camión 3 ocupantes
                case "14": // Camión 18 ocupantes
                case "15": // Camión 25 ocupantes
                    iconHtml = $"<i class='fa-solid fa-truck-moving {baseClasses} text-danger'></i>";
                    break;
                default: // Valor no reconocido
                    iconHtml = $"<i class='fa-solid fa-question-circle {baseClasses} text-muted'></i>"; // Icono por defecto
                    break;
            }

            spanVehiculo.InnerHtml = iconHtml;
        }
        protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
        {
            int secuencialSeleccionado = Convert.ToInt32(ddlTipoDocumento.SelectedValue);
            var tipoDocumentoSeleccionado = TiposDocumentos.Find(t => t.Secuencial == secuencialSeleccionado);

            if (tipoDocumentoSeleccionado.Secuencial == 1)
            {
                divComplemento.Visible = true;
            }
            else
            {
                divComplemento.Visible = false;
            }
        }

        protected void btnAnterior1_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 0;
        }

        protected void btnSiguiente2_Click(object sender, EventArgs e)
        {
            Ven02ObtenerPrima();
            string departamentoSeleccionado = ddlPlazaCirculacion.SelectedValue;
            var departamento = Departamentos.Find(t => t.CodigoDepartamento == departamentoSeleccionado).Descripcion;
            spanDepartamento.InnerHtml = WebFormHelpers.CapitalizarPrimeraLetraDeCadaPalabra(departamento);
            spanPrima.InnerHtml = Prima.ToString();
            spanIdentificador.InnerHtml = txtItentificador.Text.ToUpper();
            spanGestion.InnerHtml = ddlGestion.SelectedItem.ToString();
            CargarIcono();
            mvFormulario.ActiveViewIndex = 2;

            txtRazonSocial.Text = "";
            txtNumeroDocumento.Text = "";
            ddlTipoDocumento.SelectedIndex = 0;
            txtCorreo.Text = "";
            txtCelular.Text = "";
            txtComplemento.Text = "";


        }

        protected void btnAnterior2_Click(object sender, EventArgs e)
        {
            mvFormulario.ActiveViewIndex = 1;
        }

        protected void btnFinalizar_Click(object sender, EventArgs e)
        {

            Response.Write("<script>alert('Formulario enviado correctamente');</script>");
        }

        protected void btnObtenerQr_Click(object sender, EventArgs e)
        {
            var datosFactura = new CDatosFactura
            {
                FactPrima = Prima,
                FactRazonSocial = txtRazonSocial.Text.ToUpper(),
                FactNitCi = txtNumeroDocumento.Text.ToUpper(),
                FactTipoDocIdentidadFk = int.Parse(ddlTipoDocumento.SelectedValue),
                FactCorreoCliente = txtCorreo.Text.ToString(),
                FactTelefonoCliente = txtCelular.Text.ToString(),
                FactCiComplemento = txtComplemento.Text.ToUpper(),
            };

            var validarVendinle = Ven01ValidarVendible(datosFactura);
            if (!validarVendinle.Exito)
            {
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    validarVendinle.Mensaje
                );
                return;
            }

            var response = Obtener();
            if (response.Exito)
            {
                spanPlaca.InnerHtml = txtItentificador.Text;
                spanTipoUsoVenta.InnerHtml = ddlTipoUso.SelectedItem.ToString();
                spanTipoVehiculoVenta.InnerHtml = ddlTipoVehiculo.SelectedItem.ToString();
                spanDepartamentoVenta.InnerHtml = WebFormHelpers.CapitalizarPrimeraLetraDeCadaPalabra(ddlPlazaCirculacion.SelectedItem.ToString());
                spanGestionVenta.InnerHtml = ddlGestion.SelectedItem.ToString();
                spanPrimaVenta.InnerHtml = Prima.ToString();
                imagenQr.Src = "data:image/png;base64," + response.oSDatos.CodigoQR;
                hfCodigoUnico.Value = response.oSDatos.Secuencial.ToString();
                mvFormulario.ActiveViewIndex = 3;

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
        [WebMethod]
        public static string JSConsultarPago(int codigoUnico, string ventaVendedor, string sucursal)
        {
            var parametros = new ParametrosConfiguracion();
            Venta ventaInstance = new Venta();
            var datos = new VenQrConsultarRequest
            {
                CodigoUnico = codigoUnico,
                TipoTramite = parametros.TipoTramite,

            };

            var response = WebFormHelpers.ConsumirMetodoApi<VenQrConsultarResponse>(
                "CoreSOAT",
                "Ventas",
                "VenQrConsultar",
                datos
            );

            return JsonConvert.SerializeObject(response);

        }
        [WebMethod]
        public static string JSConsultarEfectivizacion(int secuencial, string ventaVendedor, string sucursal)
        {

            Venta ventaInstance = new Venta();

            var datos = new VenQrConsultarEfectivizacionRequest
            {
                TQrSolicitudFk = secuencial

            };

            var response = WebFormHelpers.ConsumirMetodoApi<VenQrConsultarEfectivizacionResponse>(
                "CoreSOAT",
                "Ventas",
                "VenQrConsultarEfectivizacion",
                datos
            );

            return JsonConvert.SerializeObject(response);
        }

        protected void btnAnularQr_Click(object sender, EventArgs e)
        {
            var response = Anular();
            if (response.Exito)
            {
                WebFormHelpers.EjecutarNotificacion(
                   this,
                   "success",
                   response?.Mensaje
               );
                mvFormulario.ActiveViewIndex = 1;

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

        protected void btnInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("Venta", true);
        }
    }
}