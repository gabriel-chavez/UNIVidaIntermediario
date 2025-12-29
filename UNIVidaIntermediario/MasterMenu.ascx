<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MasterMenu.ascx.cs" Inherits="UNIVidaIntermediario.MasterMenu" %>

<nav id="sidebarMenu" class="collapse d-lg-block sidebar collapse bg-white">
    <div class="position-sticky">
        <div class="list-group list-group-flush mx-3 mt-4">
            <%-- <a id="linkInicio" runat="server" href="/" class="list-group-item list-group-item-action py-2" data-mdb-ripple-init aria-current="true">
                <i class="fas fa-home fa-fw me-3"></i><span>Inicio</span>
            </a>--%>
            <a id="linkVenta" runat="server" href="venta.aspx" class="list-group-item list-group-item-action py-2" data-mdb-ripple-init>
                <i class="fas fa-tag fa-fw me-3"></i><span>Venta</span>

            </a>
            <a id="linkMisVentas" runat="server" href="VentasRealizadas.aspx" class="list-group-item list-group-item-action py-2" data-mdb-ripple-init>
                <i class="fas fa-shopping-cart fa-fw me-3"></i><span>Mis Ventas</span>
            </a>
            <a id="linkHistorialQr" runat="server" href="HistorialQrGenerado.aspx" class="list-group-item list-group-item-action py-2" data-mdb-ripple-init>
                <i class="fas fa-square-poll-vertical fa-fw me-3 text-info"></i><span>Nuevo Rcv</span>
            </a>
            <a id="A1" runat="server" href="HistorialQrGenerado.aspx" class="list-group-item list-group-item-action py-2" data-mdb-ripple-init>
                <i class="fas fa-table-list fa-fw me-3 text-warning"></i><span>Lista de Rcv</span>
            </a>
            <a id="A2" runat="server" href="VentasRealizadas.aspx" class="list-group-item list-group-item-action py-2" data-mdb-ripple-init>
                <i class="fas fa-shopping-cart fa-fw me-3"></i><span>Ventas</span>
            </a>
            <a id="A3" runat="server" href="VentasRealizadas.aspx" class="list-group-item list-group-item-action py-2" data-mdb-ripple-init>
                <i class="fas fa-users fa-fw me-3 text-primary"></i><span>Usuarios</span>
            </a>
        </div>
    </div>

</nav>
