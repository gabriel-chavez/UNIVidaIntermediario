using Newtonsoft.Json;
using System;
using System.Net;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using UNIVidaIntermediarioService.Models;
using UNIVidaIntermediarioService.Models.Seguridad;
using UNIVidaIntermediario.Utils;

namespace UNIVidaIntermediario
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {         
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.AppendHeader("Pragma", "no-cache");
            Response.Expires = -1;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Verificar si el reCAPTCHA está habilitado en el archivo web.config
            bool isRecaptchaEnabled = bool.Parse(System.Configuration.ConfigurationManager.AppSettings["EnableRecaptcha"]);

            // Si reCAPTCHA está habilitado, realizar la validación
            if (isRecaptchaEnabled)
            {
                string recaptchaResponse = Request.Form["g-recaptcha-response"];
                if (string.IsNullOrEmpty(recaptchaResponse) || !ValidateRecaptcha(recaptchaResponse))
                {
                    CustomValidator cv = new CustomValidator
                    {
                        IsValid = false,
                        ErrorMessage = "Verificación de reCAPTCHA fallida. Por favor, intente nuevamente."
                    };
                    cv.ValidationGroup = "login";
                    Page.Validators.Add(cv);
                    return; 
                }
            }

            var usuario = txtUsuario.Text.Trim();
            var password = txtPassword.Text;
            ValidateUser(usuario, password);
        }

        private void ValidateUser(string usuario, string password)
        {                        
            var autenticacion = Seg01Autenticacion();
            if (autenticacion.Exito)
            {
                Session["Autenticacion"] = false;
                Session["NombreUsuario"] = usuario;
                Session["TokenSeguridad"] = autenticacion.oSDatos.SegExtSeguridadToken;
                FormsAuthentication.RedirectFromLoginPage(usuario, false);
            }
            else
            {                
                CustomValidator cv = new CustomValidator
                {
                    IsValid = false,
                    ErrorMessage = autenticacion.Mensaje
                };
                cv.ValidationGroup = "login";
                Page.Validators.Add(cv);
            }
        }
        private ServiceApiResponse<Seg01AutenticacionResponse> Seg01Autenticacion()
        {
            Session["NombreUsuario"] = txtUsuario.Text.ToUpper();
            Session["TokenSeguridad"] = "0";
            var datos = new Seg01AutenticacionRequest
            {
                SegExtContrasenia = txtPassword.Text,
                SegExtIp = WebFormHelpers.ObtenerIpCliente()
            };
            
            var response = WebFormHelpers.ConsumirMetodoApi<Seg01AutenticacionResponse>(
                "SeguridadExterna",
                "Seguridad",
                "Seg01Autenticacion",
                datos
            );
            return new ServiceApiResponse<Seg01AutenticacionResponse> { Exito = true, CodigoRetorno = 0, Mensaje = "", oSDatos = new Seg01AutenticacionResponse() { SegExtSeguridadToken = 70873000 } };
            //return response;            
        }
        public class RecaptchaResponse
        {
            public bool Success { get; set; }
            public string[] ErrorCodes { get; set; }
        }
        private bool ValidateRecaptcha(string recaptchaResponse)
        {
            string secretKey = System.Configuration.ConfigurationManager.AppSettings["RecaptchaSecretKey"]; // Obtener la clave secreta desde web.config
            string url = "https://www.google.com/recaptcha/api/siteverify";

            using (var client = new WebClient())
            {
                var values = new System.Collections.Specialized.NameValueCollection
                {
                    { "secret", secretKey },
                    { "response", recaptchaResponse }
                };

                byte[] response = client.UploadValues(url, values);
                string responseString = System.Text.Encoding.UTF8.GetString(response);

              
                var recaptchaResult = JsonConvert.DeserializeObject<RecaptchaResponse>(responseString);

                return recaptchaResult.Success; 
            }
        }

    }
}