<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NotFound.aspx.cs" Inherits="UNIVidaIntermediario.NotFound" %>

<!DOCTYPE html>
<html>
<head>
    <title>Página no encontrada</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
            max-width: 500px;
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
            font-size: 18px;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        .btn-home {
            background: white;
            color: #667eea;
            border: none;
            padding: 12px 30px;
            font-size: 16px;
            border-radius: 50px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            transition: transform 0.3s;
        }
        .btn-home:hover {
            transform: translateY(-2px);
            background: #f8f9fa;
        }
        .search-box {
            margin-top: 20px;
        }
        .search-input {
            padding: 10px;
            border-radius: 25px;
            border: none;
            width: 250px;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-code">404</h1>
        <h2 class="error-title">¡Ups! Página no encontrada</h2>
        <p class="error-message">
            Lo sentimos, la página que estás buscando no existe o ha sido movida.
        </p>
        <a href="/Default.aspx" class="btn-home">Volver al Inicio</a>
        
        
        <p style="margin-top: 30px; font-size: 14px; opacity: 0.7;">
            URL solicitada: <asp:Literal ID="ltlRequestedUrl" runat="server" />
        </p>
    </div>
</body>
</html>