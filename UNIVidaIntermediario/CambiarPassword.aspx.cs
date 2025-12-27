using System;
using System.Web.UI;
using UNIVidaIntermediarioService.Models.Seguridad;
using UNIVidaIntermediarioService.Models;
using UNIVidaIntermediario.Utils;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace UNIVidaIntermediario
{
    public partial class CambiarPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["NombreUsuario"] == null)
            {
                Response.Redirect(FormsAuthentication.LoginUrl, true);
            }
        }
        protected void btnCambiar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string actual = txtActual.Text.Trim();
                string nueva = txtNueva.Text.Trim();
                string confirmar = txtConfirmar.Text.Trim();
                if (nueva != confirmar)
                {
                    CustomValidator cv = new CustomValidator
                    {
                        IsValid = false,
                        ErrorMessage = "Las contraseñas no coinciden"
                    };
                    cv.ValidationGroup = "login";
                    Page.Validators.Add(cv);
                    return;
                }
                if (!EsContraseniaRobusta(nueva))
                {
                    MostrarError("La nueva contraseña debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas, números y caracteres especiales.");
                    return;
                }
                var response = Seg02CambiarContrasenia(actual, nueva);

                if (response.Exito)
                {
                    mensaje.InnerText = response.Mensaje;
                    string script = @"
                        <script>
                            document.getElementById('mensajeExito').style.display = 'block';
                            let segundos = 3;
                            const lbl = document.getElementById('contador');
                            lbl.innerText = segundos;
                            const intervalo = setInterval(() => {
                                segundos--;
                                lbl.innerText = segundos;
                                if (segundos <= 0) {
                                    clearInterval(intervalo);
                                    window.location.href = 'venta.aspx';
                                }
                            }, 1000);
                        </script>";
                    ClientScript.RegisterStartupScript(this.GetType(), "redirect", script);                
                }
                else
                {
                    WebFormHelpers.EjecutarNotificacion(
                    this,
                    "error",
                    response.Mensaje
                );
                }
            }
        }
        private void MostrarError(string mensajeError)
        {
            CustomValidator cv = new CustomValidator
            {
                IsValid = false,
                ErrorMessage = mensajeError,
                ValidationGroup = "cambiar"
            };
            Page.Validators.Add(cv);
        }
        private bool EsContraseniaRobusta(string contrasenia)
        {
            if (string.IsNullOrEmpty(contrasenia)) return false;

            // 8 caracteres al menos una mayuscula una minúscula un número y un carácter especial
            var regex = new System.Text.RegularExpressions.Regex(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.,;#])[A-Za-z\d@$!%*?&.,;#]{8,}$");
            return regex.IsMatch(contrasenia);
        }
        private ServiceApiResponse<object> Seg02CambiarContrasenia(string actual, string nueva)
        {
            var datos = new Seg02CambiarContraseniaRequest
            {
                SegExtContrasenia = actual,
                SegExtIp = WebFormHelpers.ObtenerIpCliente(),
                SegExtContraseniaNueva = nueva

            };
            var response = WebFormHelpers.ConsumirMetodoApi<object>(
                "SeguridadExterna",
                "Seguridad",
                "Seg02CambiarContrasenia",
                datos
            );
            return response;
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Venta.aspx");
        }
    }
}