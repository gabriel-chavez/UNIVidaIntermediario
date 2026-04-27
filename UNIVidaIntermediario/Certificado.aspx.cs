using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using UNIVidaIntermediarioService.Models.Soat;
using UNIVidaIntermediarioService.Models;
using UNIVidaIntermediario.Utils;
using UNIVidaSoatService.Models.Soatc;

namespace UNIVidaIntermediario
{
    public partial class Certificado : System.Web.UI.Page
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
                if (Session["TPolizaDetalleFk"] == null)
                {
                    Response.Redirect("VentasRealizadas", true);
                }

                MostrarComprobanteSoat();
            }
        }

        private void MostrarComprobanteSoat()
        {
            var response = Emi03PolizaObtenerPDF();
            if (response.Exito)
            {
              
                var archivoAdjunto = response.oSDatos.oArchivosAdjuntos;
                if (archivoAdjunto == null)
                    return;
                string base64 = Convert.ToBase64String(archivoAdjunto.ArchivoAdjunto);
                pdfViewer.Attributes["src"] = "data:application/pdf;base64," + base64;
            }
            pdfViewer.Visible= response.Exito;
            divMensaje.Visible = !response.Exito;
            lblMensaje.Text = response.Mensaje;


        }
        private ServiceApiResponse<Emi03PolizaObtenerPDFResponse> Emi03PolizaObtenerPDF()
        {
            int tPolizaDetalleFk = int.Parse(Session["TPolizaDetalleFk"].ToString());
            Session["TPolizaDetalleFk"] = null;
            var datos = new 
            {
                TPolizaDetalleFk = tPolizaDetalleFk,
     
            };

            var response = WebFormHelpers.ConsumirMetodoApi<Emi03PolizaObtenerPDFResponse>(
                "CoreTecnico",
                "Emision",
                "Emi03PolizaObtenerPDF",
                datos
            );
            return response;
        }

        protected void btnInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("VentasRealizadas", true);
        }
    }
}