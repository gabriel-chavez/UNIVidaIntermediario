<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ComprobanteSoat.aspx.cs" Inherits="UNIVidaIntermediario.ComprobanteSoat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <section class="mb-4">
     <div class="card">
         <div class="card-header text-center py-3">
             <h5 class="mb-0 text-center">
                 <strong>Comprobante Soat</strong>
             </h5>
         </div>
         <div class="card-body">
             <div id="divDocumento" class="mt-4">

                 <div class="text-center">
                     <iframe id="pdfViewer" src="" style="width: 100%; height: 500px;" frameborder="0" runat="server"></iframe>
                 </div>
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
