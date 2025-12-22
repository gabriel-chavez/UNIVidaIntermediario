using System;
using System.Web.Security;
using System.Web.UI;

namespace UNIVidaIntermediario
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            // Cerrar sesión
            Session.Clear();              // Limpia todas las variables de sesión
            Session.Abandon();            // Finaliza la sesión
            FormsAuthentication.SignOut(); // Cierra la sesión de autenticación
            Response.Redirect("~/Login.aspx"); // Redirige a la página de login
        }

        protected void btnCambiarPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CambiarPassword.aspx");
        }
    }
}