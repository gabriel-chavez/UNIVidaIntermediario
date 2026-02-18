using System;
using System.Globalization;
using System.Web;
using System.Web.Security;
using System.Web.UI.WebControls;
using UNIVidaIntermediarioService.Models.Soat;
using UNIVidaIntermediario.Utils;
using UNIVidaSoatService.Models.Soatc;
using System.Collections.Generic;

namespace UNIVidaIntermediario
{
    public partial class VentasRealizadas : System.Web.UI.Page
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
        protected void cvFechaVenta_ServerValidate(object source, ServerValidateEventArgs args)
        {
            DateTime fecha;
            // Intenta convertir la fecha; args.Value viene en formato AAAA-MM-DD
            if (!DateTime.TryParse(args.Value, out fecha))
            {
                args.IsValid = false;
                return;
            }

            // Opcional: validar rango de fechas (por ejemplo, no futura)
            if (fecha > DateTime.Today)
            {
                args.IsValid = false;
                return;
            }

            args.IsValid = true;
        }
        protected void CargarGrilla()
        {
            DateTime fechaVenta = DateTime.ParseExact(
                txtFechaVenta.Text,
                "yyyy-MM-dd",
                CultureInfo.InvariantCulture
            );
            var datos = new 
            {
                Fecha = fechaVenta,
             
            };

            var response = WebFormHelpers.ConsumirMetodoApi<List<Emi09PolizaListarResponse>>(
                "CoreTecnico",
                "Emision",
                "Emi09PolizaListar",
                datos
            );
            if (response != null && response.Exito && response.oSDatos != null)
            {
                gvSoatcVendidos.DataSource = response.oSDatos;
                gvSoatcVendidos.DataBind();                
            }
            else
            {
                gvSoatcVendidos.DataSource = null;
                            
                WebFormHelpers.EjecutarNotificacion(
                    this,
                    "warning",
                    response?.Mensaje
                );
            }
            ViewState["MensajeGvSoatcVendidos"] = response.Mensaje;
            gvSoatcVendidos.DataBind();
        }

        protected void gvSoatcVendidos_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            if (e.CommandName == "VerComprobante")
            {
                //int soatNroComprobante = Convert.ToInt32(e.CommandArgument);
                //Session["TVehiSoatPropFk"] = soatNroComprobante;
                //Response.Redirect("ComprobanteSoat");

                // Aquí llamas a tu método para obtener el archivo (por ejemplo, desde API)
                //  var response = ObtenerComprobantePorNumero(soatNroComprobante);


            }


        }
        protected void gvSoatcVendidos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.EmptyDataRow)
            {
                Label lblMensaje = e.Row.FindControl("lblMensaje") as Label;
                if (lblMensaje != null)
                {
                    string mensaje = ViewState["MensajeGvSoatcVendidos"] as string;
                    lblMensaje.Text = mensaje;
                }
            }
           
        }
        protected void gvSoatcVendidos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSoatcVendidos.PageIndex = e.NewPageIndex;
            this.CargarGrilla();
        }

        protected void btnVerVentas_Click(object sender, EventArgs e)
        {
            this.CargarGrilla();

        }
    }
}
