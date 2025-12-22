using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UNIVidaIntermediario
{
    public partial class MasterMenu : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MarcarMenuActivo();
            }
        }

        private void MarcarMenuActivo()
        {
            string paginaActual = System.IO.Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            // Remueve la clase "active" de todos (por si acaso)
            //linkInicio.Attributes["class"] = linkInicio.Attributes["class"].Replace(" active", "");
            linkVenta.Attributes["class"] = linkVenta.Attributes["class"].Replace(" active", "");
            linkMisVentas.Attributes["class"] = linkMisVentas.Attributes["class"].Replace(" active", "");
            linkHistorialQr.Attributes["class"] = linkHistorialQr.Attributes["class"].Replace(" active", "");

            switch (paginaActual)
            {
                case "default.aspx":
                case "":
                case "/":
                 //   linkInicio.Attributes["class"] += " active";
                    break;
                case "venta.aspx":
                    linkVenta.Attributes["class"] += " active";
                    break;
                case "ventasrealizadas.aspx":
                    linkMisVentas.Attributes["class"] += " active";
                    break;
                case "historialqrgenerado.aspx":
                    linkHistorialQr.Attributes["class"] += " active";
                    break;
                default:
                 
                    break;
            }
        }

    }
}