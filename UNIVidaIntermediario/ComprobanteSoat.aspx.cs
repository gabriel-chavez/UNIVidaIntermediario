using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using UNIVidaSoatService.Models.Soat;
using UNIVidaSoatService.Models;
using UNIVidaIntermediario.Utils;

namespace UNIVidaIntermediario
{
    public partial class ComprobanteSoat : System.Web.UI.Page
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
                if (Session["TVehiSoatPropFk"] == null)
                {
                    Response.Redirect("VentasRealizadas", true);
                }

                MostrarComprobanteSoat();
            }
        }

        private void MostrarComprobanteSoat()
        {
            var response = Ven05ObtenerPDF();
            if (response.Exito)
            {
              
                var archivoAdjunto = response.oSDatos.oArchivosAdjuntos;
                if (archivoAdjunto == null)
                    return;
                string base64 = Convert.ToBase64String(archivoAdjunto.ArchivoAdjunto);
                pdfViewer.Attributes["src"] = "data:application/pdf;base64," + base64;
            }
        }
        private ServiceApiResponse<Ven05ObtenerPDFResponse> Ven05ObtenerPDF()
        {
            int soatNroComprobante = int.Parse(Session["TVehiSoatPropFk"].ToString());
            Session["TVehiSoatPropFk"] = null;
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

        protected void btnInicio_Click(object sender, EventArgs e)
        {
            Response.Redirect("VentasRealizadas", true);
        }
    }
}