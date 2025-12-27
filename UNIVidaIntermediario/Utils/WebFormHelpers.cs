using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UNIVidaIntermediarioService.Models;
using UNIVidaIntermediarioService.Services;

namespace UNIVidaIntermediario.Utils
{
    public static class WebFormHelpers
    {
        public static void CargarDropDownList<T>(
            DropDownList ddl,
        List<T> data,
        Func<T, string> textSelector,
        Func<T, string> valueSelector)
        {
            ddl.Items.Clear();
            foreach (var item in data)
            {
                var text = textSelector(item);
                var value = valueSelector(item);
                ddl.Items.Add(new ListItem(text, value));
            }
        }
        public static void EjecutarNotificacion(Page page, string tipo, string mensaje)
        {
            // Usamos ScriptManager para ejecutar el script de notificación
            string script = $"showNotification('{tipo}', '{mensaje}');";
            ScriptManager.RegisterStartupScript(page, page.GetType(), "showNotificationScript", script, true);
        }
        public static string CapitalizarPrimeraLetraDeCadaPalabra(string texto)
        {
            return string.Join(" ", texto.Split(' ').Select(palabra => palabra.Length > 0 ? palabra[0].ToString().ToUpper() + palabra.Substring(1).ToLower() : ""));
        }
        public static ServiceApiResponse<T> ConsumirMetodoApi<T>(string sistema, string modulo, string metodo, object oEDatos )
        {
            if (HttpContext.Current.Session["TokenSeguridad"]==null || HttpContext.Current.Session["TokenSeguridad"]==null)
            {
                return null;

            }
            string nombreUsuario = HttpContext.Current.Session["NombreUsuario"]?.ToString();
            var tokenSeguridad = long.Parse(HttpContext.Current.Session["TokenSeguridad"]?.ToString());

           

            SoatApiClient soatApiClient = new SoatApiClient();
            var parametros = new ParametrosConfiguracion();

            var request = new ServiceApiRequest
            {
                Sistema = sistema,
                Modulo = modulo,
                Metodo = metodo,
                Parametros = new ParametrosRequest
                {
                    oEDatos = oEDatos,
                    oESeguridadExterna = new SeguridadExternaRequest
                    {
                        SegExtToken = tokenSeguridad,
                        SegExtUsuario = nombreUsuario
                    },
                    oETransaccionOrigen = new TransaccionOrigenRequest
                    {
                        TraOriCajero = nombreUsuario,
                        TraOriCanal = parametros.TraOriCanal,
                        TraOriEntidad = "UNIVida",
                        TraOriIntermediario = 0,
                        TraOriSucursal = "10100",
                        TraOriAgencia = ""
                    }
                }
            };



            string json = soatApiClient.ConsumirMetodo(request);

            return JsonConvert.DeserializeObject<ServiceApiResponse<T>>(json);
        }
        public static string ObtenerIpCliente()
        {
            string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ip))
            {
                string[] direcciones = ip.Split(',');
                if (direcciones.Length > 0)
                {
                    return direcciones[0].Trim();
                }
            }
            return HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }
    }

}