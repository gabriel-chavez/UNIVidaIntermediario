<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServerError.aspx.cs" Inherits="UNIVidaIntermediario.ServerError" %>

<!DOCTYPE html>
<html>
<head>
    <title>Error del Servidor</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #93b7fb 0%, #6357f5 100%);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            text-align: center;
        }

        .error-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 15px;
            max-width: 600px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }

        .error-code {
            font-size: 120px;
            font-weight: bold;
            margin: 0;
            line-height: 1;
        }

        .error-title {
            font-size: 32px;
            margin: 20px 0;
        }

        .error-message {
            background: rgba(255, 255, 255, 0.2);
            padding: 15px;
            border-radius: 10px;
            margin: 20px 0;
            font-size: 16px;
            text-align: left;
            max-height: 150px;
            overflow-y: auto;
        }

        .btn-group {
            margin-top: 20px;
        }

        .btn {
            background: white;
            color: #737373;
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            border-radius: 50px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin: 0 10px;
            transition: all 0.3s;
        }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            }

        .btn-secondary {
            background: transparent;
            border: 2px solid white;
            color: white;
        }

        .error-details {
            margin-top: 20px;
            font-size: 14px;
            opacity: 0.8;
            text-align: left;
            display: none; /* Ocultar por defecto */
        }

        .toggle-details {
            background: none;
            border: none;
            color: white;
            text-decoration: underline;
            cursor: pointer;
            margin-top: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-code">500</h1>
        <h2 class="error-title">Error del Servidor</h2>
        <p>Ha ocurrido un error interno en el servidor.</p>

        <%-- <div class="error-message">
            <asp:Literal ID="ltlErrorMessage" runat="server" />
        </div>
        
        <button class="toggle-details" onclick="toggleDetails()">Mostrar/Ocultar detalles técnicos</button>
        --%>
        <div class="error-details" id="errorDetails">
            <asp:Literal ID="ltlErrorDetails" runat="server" />
        </div>

        <div class="btn-group">
            <a href="/Default.aspx" class="btn">Volver al Inicio</a>
            <a href="javascript:history.back()" class="btn btn-secondary">Regresar</a>
        </div>


    </div>

    <%-- <script>
        function toggleDetails() {
            var details = document.getElementById('errorDetails');
            details.style.display = details.style.display === 'none' ? 'block' : 'none';
        }
    </script>--%>
</body>
</html>
