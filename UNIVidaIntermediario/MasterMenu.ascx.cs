using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
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
            string ruta = Request.Url.AbsolutePath.ToLower().Trim('/');            
            string pagina = System.IO.Path.GetFileNameWithoutExtension(ruta);

            var mapaMenu = new Dictionary<string, HtmlControl>
            {
                { "venta",                       linkVenta },
                { "ventasrealizadas",            linkMisVentas },
                { "conciliacionlistarventas",    linkConciliacionListarVentas }
            };

            // Quitar "active" de todos
            foreach (var link in mapaMenu.Values)
                link.Attributes["class"] = (link.Attributes["class"] ?? "").Replace(" active", "").Trim();

            // Agregar "active" al que corresponde
            if (mapaMenu.TryGetValue(pagina, out var linkActivo))
                linkActivo.Attributes["class"] += " active";
        }

    }
}