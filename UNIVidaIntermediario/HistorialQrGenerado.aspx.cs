using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using UNIVidaIntermediarioService.Models.PasarelaPagos;
using UNIVidaIntermediarioService.Models.Soat;
using UNIVidaIntermediario.Utils;

namespace UNIVidaIntermediario
{
    public partial class HistorialQrGenerado : System.Web.UI.Page
    {
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
                txtFechaVenta.Text = DateTime.Today.ToString("yyyy-MM-dd");

                this.CargarGrilla();
            }
        }

        protected void btnVerQrGenerado_Click(object sender, EventArgs e)
        {
            this.CargarGrilla();
        }
        protected void CargarGrilla()
        {
            DateTime fechaVenta = DateTime.ParseExact(
                txtFechaVenta.Text,
                "yyyy-MM-dd",
                CultureInfo.InvariantCulture
            );
            var datos = new VenQrListarGeneradosRequest
            {
                Fecha = fechaVenta,
                VentaVendedor = Session["NombreUsuario"].ToString(),
                TParVentaCanalFk = new ParametrosConfiguracion().TraOriCanal,
                TParSimpleEstadoSolicitudFk = int.Parse(ddlEstado.SelectedValue),
                IdentificadorVehiculo = ""
            };

            var response = WebFormHelpers.ConsumirMetodoApi<List<VenQrListarGeneradosResponse>>(
                "CoreSOAT",
                "Ventas",
                "VenQrListarGenerados",
                datos
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                gvHistorialQr.DataSource = response.oSDatos;
                gvHistorialQr.DataBind();
            }
            else
            {
                gvHistorialQr.DataSource = null;

                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "warning",
                    response?.Mensaje
                );
            }
            ViewState["MensajeGvHistorialQr"] = response.Mensaje;
            gvHistorialQr.DataBind();
        }
        protected void gvHistorialQr_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.EmptyDataRow)
            {
                Label lblMensaje = e.Row.FindControl("lblMensaje") as Label;
                if (lblMensaje != null)
                {
                    string mensaje = ViewState["MensajeGvHistorialQr"] as string;
                    lblMensaje.Text = mensaje;
                }
            }
        }
        protected void gvHistorialQr_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ConsultarEstado" || e.CommandName == "Anular")
            {
                
                //int rowIndex = Convert.ToInt32(e.CommandArgument);
                int actualIndex = String.IsNullOrEmpty(e.CommandArgument.ToString()) ? 0 : Convert.ToInt32(e.CommandArgument) ;


                //int actualIndex = rowIndex + gvHistorialQr.PageIndex * gvHistorialQr.PageSize;

                int TVehiSoatPropFk = string.IsNullOrEmpty(gvHistorialQr.DataKeys[actualIndex]["TVehiSoatPropFk"]?.ToString())
                                    ? 0
                                    : int.Parse(gvHistorialQr.DataKeys[actualIndex]["TVehiSoatPropFk"].ToString());

                int TramiteSecuencial = string.IsNullOrEmpty(gvHistorialQr.DataKeys[actualIndex]["TramiteSecuencial"]?.ToString())
                                    ? 0
                                    : int.Parse(gvHistorialQr.DataKeys[actualIndex]["TramiteSecuencial"].ToString());



                var parametros = new ParametrosConfiguracion();
                switch (e.CommandName)
                {
                    case "ConsultarEstado":

                        Venta ventaInstance = new Venta();
                        var datos = new VenQrConsultarRequest
                        {
                            CodigoUnico = TramiteSecuencial,
                            TipoTramite = parametros.TipoTramite,

                        };

                        var response = WebFormHelpers.ConsumirMetodoApi<VenQrConsultarResponse>(
                            "CoreSOAT",
                            "Ventas",
                            "VenQrConsultar",
                            datos
                        );

                        CargarGrilla();
                        if (response.Exito)
                        {
                            if (response?.Mensaje != null && response.Mensaje.Contains("HABILITADO"))
                            {
                                WebFormHelpers.EjecutarNotificacion(
                               this,
                               "info",
                               response?.Mensaje
                            );
                            }
                            else
                            {
                                WebFormHelpers.EjecutarNotificacion(
                               this,
                               "success",
                               response?.Mensaje
                           );

                            }


                        }
                        else
                        {
                            WebFormHelpers.EjecutarNotificacion(
                                this,
                                "error",
                                response?.Mensaje
                            );
                        }

                        break;

                    case "Anular":


                        Random random = new Random();
                        int numeroAleatorio = random.Next(0, int.MaxValue);
                        var datosAnulacion = new VenQrAnularRequest
                        {
                            CodigoUnico = TramiteSecuencial,
                            TipoTramite = parametros.TipoTramite,
                        };

                        var responseAnulacion = WebFormHelpers.ConsumirMetodoApi<object>(
                            "CoreSOAT",
                            "Ventas",
                            "VenQrAnular",
                            datosAnulacion
                        );

                        CargarGrilla();
                        if (responseAnulacion.Exito)
                        {
                            WebFormHelpers.EjecutarNotificacion(
                               this,
                               "success",
                               responseAnulacion?.Mensaje
                           );
                        }
                        else
                        {
                            WebFormHelpers.EjecutarNotificacion(
                                this,
                                "error",
                                responseAnulacion?.Mensaje
                            );
                        }
                        break;
                    case "VerComprobante":

                        //Session[CVariableSesion.SoatSecuencial] = TVehiSoatPropFk;
                        //Session[CVariableSesion.SoatSumaImpresion] = 1;
                        //Session[CVariableSesion.SoatComprobanteTipo] = 1;
                        //Response.Redirect(CVariableURL.JSOferente_Ventas_wfFormularioSOAT);
                        break;

                    default:
                        break;
                }
            }
           
        }

        protected void gvHistorialQr_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvHistorialQr.PageIndex = e.NewPageIndex;
            CargarGrilla();
        }
    }
}