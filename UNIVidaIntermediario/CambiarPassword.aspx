<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambiarPassword.aspx.cs" Inherits="UNIVidaIntermediario.CambiarPassword" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Cambiar Contraseña</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Íconos -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="Template/iziToast/css/iziToast.css" rel="stylesheet" />
    <script src="Template/iziToast/js/iziToast.js"></script>
    <script>
        function showNotification(type, message) {

            const titles = {
                success: 'Correcto',
                error: 'Error',
                info: 'Atención',
                warning: 'Atención'
            };

            iziToast[type]({
                title: titles[type] || 'Mensaje',
                message: message,
                timeout: 25000,
                position: "topCenter"
            });
        }
    </script>
    <style>
        /* mismo estilo que Login */
        :root {
            --bg1: #0f172a;
            --bg2: #1e293b;
            --card-bg: rgba(255,255,255,0.06);
            --card-brd: rgba(255,255,255,0.15);
            --blur: 14px;
        }

        html, body {
            height: 100%;
            background: radial-gradient(1200px 800px at 10% 10%, #312e81 0%, transparent 50%), radial-gradient(1000px 700px at 90% 20%, #16a34a 0%, transparent 50%), linear-gradient(135deg, var(--bg1), var(--bg2));
            color: #e5e7eb;
        }

        .page-wrap {
            min-height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 1rem;
        }

        .glass-card {
            width: 100%;
            max-width: 420px;
            background: var(--card-bg);
            border: 1px solid var(--card-brd);
            backdrop-filter: blur(var(--blur));
            border-radius: 1.25rem;
            box-shadow: 0 10px 30px rgba(0,0,0,.35);
        }

        .brand-badge {
            width: 56px;
            height: 56px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg,#22c55e, #06b6d4);
            color: #0b1020;
            font-weight: 700;
            font-size: 1.1rem;
            box-shadow: 0 8px 24px rgba(6,182,212,.35);
        }

        .form-floating > label {
            color: #94a3b8;
        }

        .form-control {
            background: rgba(255,255,255,0.08) !important;
            color: #e2e8f0 !important;
            border-color: rgba(255,255,255,0.2) !important;
        }

        .btn-gradient {
            background: linear-gradient(135deg,#22c55e, #06b6d4);
            border: 0;
            color: #0b1020;
            font-weight: 700;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="w-100">
        <div class="page-wrap">
            <div class="glass-card p-4 p-md-5">
                <div class="d-flex align-items-center gap-3 mb-4">
                    <div class="brand-badge">
                        <i class="bi bi-shield-lock"></i>
                    </div>
                    <div>
                        <h1 class="h4 mb-0">Cambiar Contraseña</h1>
                        <div class="tiny">Actualiza tu clave de acceso</div>
                    </div>
                </div>

                <asp:ValidationSummary runat="server" CssClass="alert alert-danger py-2 small"
                    DisplayMode="BulletList" ValidationGroup="cambiar" />

                <!-- Contraseña actual -->
                <div class="form-floating mb-3">
                    <asp:TextBox runat="server" ID="txtActual" TextMode="Password" CssClass="form-control" placeholder="Contraseña actual" />
                    <label for="txtActual"><i class="bi bi-key me-2"></i>Contraseña actual</label>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtActual"
                        CssClass="text-warning small" ErrorMessage="La contraseña actual es obligatoria"
                        ValidationGroup="cambiar" Display="Dynamic"/>
                </div>

                <!-- Nueva contraseña -->
                <div class="form-floating mb-3">
                    <asp:TextBox runat="server" ID="txtNueva" TextMode="Password" CssClass="form-control" placeholder="Nueva contraseña" />
                    <label for="txtNueva"><i class="bi bi-lock-fill me-2"></i>Nueva contraseña</label>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNueva"
                        CssClass="text-warning small" ErrorMessage="La nueva contraseña es obligatoria"
                        ValidationGroup="cambiar" Display="Dynamic"/>
                </div>

                <!-- Confirmar nueva contraseña -->
                <div class="form-floating mb-3">
                    <asp:TextBox runat="server" ID="txtConfirmar" TextMode="Password" CssClass="form-control" placeholder="Confirmar contraseña" />
                    <label for="txtConfirmar"><i class="bi bi-lock me-2"></i>Confirmar contraseña</label>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmar"
                        CssClass="text-warning small" ErrorMessage="Debe confirmar la contraseña"
                        ValidationGroup="cambiar" Display="Dynamic" />
                    <asp:CompareValidator runat="server" ControlToValidate="txtConfirmar" ControlToCompare="txtNueva"
                        CssClass="text-warning small" ErrorMessage="Las contraseñas no coinciden"
                        ValidationGroup="cambiar" Display="Dynamic" />
                </div>
                <div id="mensajeExito" class="alert alert-success small text-center" style="display: none;">
                    <label runat="server" id="mensaje"></label><br />
                    Será redireccionado al módulo de ventas en <span id="contador">3</span> segundos.
                </div>
                <!-- Botón -->
                <asp:Button runat="server" ID="btnCambiar" CssClass="btn btn-gradient w-100 py-2 loading"
                    Text="Cambiar Contraseña" ValidationGroup="cambiar" OnClick="btnCambiar_Click" />
               <asp:Button runat="server"  id="btnCancelar" CssClass="btn btn-gradient w-100 py-2 mt-1 loading"
                    Text="Cancelar" CausesValidation="false" OnClick="btnCancelar_Click"/>
               
            </div>
        </div>
    </form>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
