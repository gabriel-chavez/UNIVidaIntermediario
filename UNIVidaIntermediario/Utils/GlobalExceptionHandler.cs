using System.Web;
using System;
using WebGrease;
using log4net;

namespace UNIVidaVentaRural.Utils
{
    public static class GlobalExceptionHandler
    {
        private static readonly ILog log = log4net.LogManager.GetLogger(typeof(GlobalExceptionHandler));

        public static void Handle(Exception ex, HttpContext context = null)
        {
            HttpContext currentContext = context ?? HttpContext.Current;

            if (ex is HttpException httpEx)
            {
                int statusCode = httpEx.GetHttpCode();

                switch (statusCode)
                {
                    case 404:
                        log.Warn($"Recurso no encontrado: {currentContext.Request.Url}");
                        RedirectToNotFound(currentContext, ex);
                        break;
                    case 500:
                        log.Error("Error interno del servidor:", ex);
                        RedirectToServerError(currentContext, ex);
                        break;
                    default:
                        log.Error($"Error HTTP {statusCode}:", ex);
                        RedirectToError(currentContext, ex);
                        break;
                }
            }
            else
            {
                // Error general
                log.Error("Error no manejado:", ex);
                RedirectToError(currentContext, ex);
            }
        }
        private static void RedirectToNotFound(HttpContext context, Exception ex)
        {
            ClearError(context);
            context.Response.Redirect("~/NotFound.aspx", false);
        }
        private static void RedirectToServerError(HttpContext context, Exception ex)
        {
            ClearError(context);

            // Guardar el error en sesión para mostrar detalles
            if (context.Session != null)
            {
                context.Session["LastError"] = ex.Message;
                context.Session["ErrorDetails"] = ex.StackTrace;
            }

            context.Response.Redirect("~/ServerError.aspx", false);
        }

        private static void RedirectToError(HttpContext context, Exception ex)
        {
            ClearError(context);
            context.Response.Redirect("~/Error.aspx", false);
        }

        private static void ClearError(HttpContext context)
        {
            context.Server.ClearError();
            context.Response.Clear();
            context.Response.StatusCode = 200; // Resetear código de estado
        }
        public static void Log(string message)
        {
            log.Info(message);
        }
    }
}