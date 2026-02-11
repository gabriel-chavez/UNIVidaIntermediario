using System;
using System.Web;

namespace UNIVidaIntermediario
{
    public partial class ServerError : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Mantener código 500
            Response.StatusCode = 500;
            Response.StatusDescription = "Internal Server Error";

            if (!IsPostBack)
            {
                // Obtener error de sesión o mostrar mensaje genérico
                string errorMessage = Session["LastError"] as string;
                string errorDetails = Session["ErrorDetails"] as string;

                //ltlErrorMessage.Text = !string.IsNullOrEmpty(errorMessage)
                //    ? HttpUtility.HtmlEncode(errorMessage)
                //    : "Ha ocurrido un error interno en el servidor. Nuestro equipo ha sido notificado.";

                //ltlErrorDetails.Text = !string.IsNullOrEmpty(errorDetails)
                //    ? HttpUtility.HtmlEncode(errorDetails)
                //    : "No hay detalles adicionales disponibles.";

                

                // Limpiar sesión
                Session.Remove("LastError");
                Session.Remove("ErrorDetails");
            }
        }
    }
}