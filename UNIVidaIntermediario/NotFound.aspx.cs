using System;
using System.Web;

namespace UNIVidaIntermediario
{
    public partial class NotFound : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.StatusCode = 404;
            Response.StatusDescription = "Not Found";

            if (!IsPostBack)
            {
                // Mostrar URL solicitada
                string url = Request.QueryString["aspxerrorpath"] ?? Request.RawUrl;
                //ltlRequestedUrl.Text = HttpUtility.HtmlEncode(url);
            }
        }
    }
}