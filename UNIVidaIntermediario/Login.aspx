<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UNIVidaIntermediario.Login" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Iniciar sesión</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

    <style>
        :root {
            --bg1: #0f172a; /* slate-900 */
            --bg2: #1e293b; /* slate-800 */
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
            -webkit-backdrop-filter: blur(var(--blur));
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

        .form-control, .form-check-input {
            background: rgba(255,255,255,0.08) !important;
            color: #e2e8f0 !important;
            border-color: rgba(255,255,255,0.2) !important;
        }

            .form-control:focus {
                box-shadow: 0 0 0 .25rem rgba(59,130,246,.35);
            }

        .btn-gradient {
            background: linear-gradient(135deg,#22c55e, #06b6d4);
            border: 0;
            color: #0b1020;
            font-weight: 700;
        }

            .btn-gradient:focus {
                box-shadow: 0 0 0 .25rem rgba(34,197,94,.35);
            }

        a, a:visited {
            color: #a5b4fc;
        }

        .tiny {
            font-size: .9rem;
            color: #94a3b8;
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg,transparent,rgba(255,255,255,.25),transparent);
            margin: .75rem 0 1.25rem;
        }

        .password-toggle {
            cursor: pointer;
        }



        .brand-badge img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
        }

        #loadingOverlay {
            position: fixed;
            display: none;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.7);
            z-index: 9999;
            text-align: center;
        }

        #loadingSpinner {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="w-100">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <div class="page-wrap">
            <div class="glass-card p-4 p-md-5">
                <div class="d-flex align-items-center gap-3 mb-4">
                    <div class="brand-badge">
                        <img src="Template/img/IconoLogin.png" height="40" alt="" loading="lazy" />
                    </div>
                    <div>
                        <h1 class="h4 mb-0">UNIVida Venta Rural</h1>
                        <div class="tiny">Ingresa a tu cuenta para continuar</div>
                    </div>
                </div>

                <asp:ValidationSummary runat="server" CssClass="alert alert-danger py-2 small" HeaderText=""
                    DisplayMode="BulletList" ValidationGroup="login" />

                <div class="form-floating mb-3">
                    <asp:TextBox runat="server" ID="txtUsuario" CssClass="form-control" placeholder="Usuario" MaxLength="20" />
                    <label for="txtUsuario"><i class="bi bi-person me-2"></i>Usuario</label>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsuario" Display="Dynamic"
                        CssClass="text-warning small" ErrorMessage="El usuario es obligatorio" ValidationGroup="login" />
                    <ajaxToolkit:FilteredTextBoxExtender
                        ID="ftbeCleanText"
                        runat="server"
                        TargetControlID="txtUsuario"
                        FilterType="Custom, Numbers, LowercaseLetters, UppercaseLetters" />
                </div>

                <div class="form-floating mb-3 position-relative">
                    <asp:TextBox runat="server" ID="txtPassword" TextMode="Password" CssClass="form-control" placeholder="••••••••" />
                    <label for="txtPassword"><i class="bi bi-shield-lock me-2"></i>Contraseña</label>
                    <span class="position-absolute top-50 end-0 translate-middle-y me-3 text-secondary password-toggle"
                        onclick="togglePassword()" title="Mostrar/Ocultar">
                        <i id="pwIcon" class="bi bi-eye"></i>
                    </span>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" Display="Dynamic"
                        CssClass="text-warning small" ErrorMessage="La contraseña es obligatoria" ValidationGroup="login" />
                </div>
                <div class="d-flex justify-content-center my-3">
                    <div class="g-recaptcha" data-sitekey="<%= System.Configuration.ConfigurationManager.AppSettings["RecaptchaSiteKey"] %>"></div>
                </div>
                <asp:Button runat="server" ID="btnLogin" CssClass="btn btn-gradient w-100 py-2 loading"
                    Text="Ingresar" ValidationGroup="login" OnClick="btnLogin_Click" />

                <%--<div class="divider"></div>
                <div class="tiny text-center">
                    ¿Aún no tienes cuenta?
                    <a href="#">Crear cuenta</a>
                </div>--%>
            </div>
        </div>
        <div id="loadingOverlay">
            <div id="loadingSpinner">
                <lord-icon
                    src="https://cdn.lordicon.com/euaablbm.json"
                    trigger="loop"
                    colors="primary:#121331,secondary:#08a88a"
                    style="width: 80px; height: 80px">
                </lord-icon>
                <div>Cargando...</div>
            </div>
        </div>
    </form>
    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.lordicon.com/lordicon.js"></script>
    <script>
        function togglePassword() {
            const input = document.getElementById("<%= txtPassword.ClientID %>");
            const icon = document.getElementById("pwIcon");
            const type = input.getAttribute("type") === "password" ? "text" : "password";
            input.setAttribute("type", type);
            icon.classList.toggle("bi-eye");
            icon.classList.toggle("bi-eye-slash");
        }
        // Validación Bootstrap (ayuda visual)
        (function () {
            'use strict';
            const form = document.getElementById('form1');
            form.addEventListener('submit', function (event) {
                // WebForms hace validación de validadores; esto solo agrega feedback visual si faltan campos
                const inputs = form.querySelectorAll('.form-control');
                inputs.forEach(i => {
                    if (!i.value) i.classList.add('is-invalid'); else i.classList.remove('is-invalid');
                });
            }, false);
        })();
    </script>
    <script type="text/javascript">
        function mostrarLoading() {
            document.getElementById('loadingOverlay').style.display = 'block';
        }

        function ocultarLoading() {
            document.getElementById('loadingOverlay').style.display = 'none';
        }

        if (typeof (Sys) !== "undefined") {
            Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(function () {
                mostrarLoading();
            });
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                ocultarLoading();
            });
        }
        var originalDoPostBack = __doPostBack;
        __doPostBack = function (eventTarget, eventArgument) {
            mostrarLoading();
            originalDoPostBack(eventTarget, eventArgument);
        };
        //loading
        document.addEventListener("click", function (event) {
            var clickedElement = event.target;

            if (clickedElement.classList.contains("loading")) {
                if (typeof Page_ClientValidate === 'function' && Page_ClientValidate()) {
                    mostrarLoading();
                }
            }
        });
        window.onload = function () {
            var enlacesMenu = document.querySelectorAll("#sidebarMenu a");
            for (var i = 0; i < enlacesMenu.length; i++) {
                enlacesMenu[i].addEventListener('click', function (e) {
                    if (this.target !== "_blank" && this.href && this.href !== "#") {
                        mostrarLoading();
                    }
                });
            }
        };
    </script>
</body>
</html>
