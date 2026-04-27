<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Certificado.aspx.cs" Inherits="UNIVidaIntermediario.Certificado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="mb-4">
        <div class="card">
            <div class="card-header text-center py-3">
                <h5 class="mb-0 text-center">
                    <strong>Certificado</strong>
                </h5>
            </div>
            <div class="card-body">
                <div id="divDocumento" class="mt-4">

                    <div class="text-center">
                        <iframe id="pdfViewer" src="" style="width: 100%; height: 500px;" frameborder="0" runat="server"></iframe>
                    </div>
                </div>
                <div class="text-center py-5" id="divMensaje" runat="server">
                    <div>
                        <lord-icon
                            src="https://cdn.lordicon.com/lltgvngb.json"
                            trigger="loop"
                            delay="3000"
                            colors="primary:#c4c4c4"
                            style="width: 80px; height: 80px; display: block; margin: 0 auto;">
                        </lord-icon>
                    </div>

                    <asp:Label ID="lblMensaje" runat="server" CssClass="h5 mt-3 text-muted"></asp:Label>

                    <%--      <h5 class="mt-3 text-muted" id="gvSoatVendidosMensaje" runat="server">No se encontraron ventas</h5>--%>
                </div>
                <!-- Botones de navegación -->
                <div class="row mt-4">

                    <div class="col-12">
                        <asp:Button ID="btnInicio" runat="server" Text="Regresar al listado de ventas" CssClass="btn btn-success w-100" OnClick="btnInicio_Click" />
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
