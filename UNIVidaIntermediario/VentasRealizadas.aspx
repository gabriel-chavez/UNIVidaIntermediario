<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VentasRealizadas.aspx.cs" Inherits="UNIVidaIntermediario.VentasRealizadas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="mb-4">
        <div class="card">
            <div class="card-header text-center py-3">
                <h5 class="mb-0 text-center">
                    <strong>Ventas Realizadas</strong>
                </h5>
            </div>
            <div class="card-body">

                <!-- Filtros de fecha -->
                <div data-mdb-input-init class="form-outline mt-4">
                    <asp:TextBox ID="txtFechaVenta" runat="server" CssClass="form-control form-control-lg"
                        ClientIDMode="Static" TextMode="Date" ValidationGroup="buscar" CausesValidation="true" />
                    <label class="form-label" for="txtFechaVenta">Fecha de venta</label>



                </div>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                    ControlToValidate="txtFechaVenta"
                    InitialValue=""
                    ErrorMessage="Fecha requerida"
                    CausesValidation="true"
                    ValidationGroup="buscar"
                    CssClass="small text-danger"
                    Display="Dynamic" />

                <div class="text-center mt-4">
                    <asp:LinkButton ID="btnVerVentas" runat="server" CssClass="btn btn-primary d-flex align-items-center justify-content-center gap-2"
                        OnClick="btnVerVentas_Click"
                        ValidationGroup="buscar"
                        CausesValidation="true">
        <lord-icon src="https://cdn.lordicon.com/hoetzosy.json" trigger="loop"
            delay="2000" colors="primary:#ffffff" style="width:20px; height:20px;">
        </lord-icon>
        Buscar
                    </asp:LinkButton>
                </div>


                <!-- Tabla de resultados -->
                <div class="table-responsive mt-4">
                    <asp:GridView ID="gvSoatcVendidos"
                        runat="server"
                        DataKeyNames="SoatNroComprobante"
                        AutoGenerateColumns="False"
                        CssClass="table table-striped table-hover"
                        OnRowCommand="gvSoatcVendidos_RowCommand"
                        OnRowDataBound="gvSoatcVendidos_RowDataBound"
                        PagerStyle-CssClass="pagination-container"
                        PagerStyle-HorizontalAlign="Center"
                        OnPageIndexChanging="gvSoatcVendidos_PageIndexChanging"
                        AllowPaging="true"
                        PageSize="30">
                        <EmptyDataTemplate>
                            <div class="text-center py-5">
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
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="FacturaMaestroNumeroFactura " HeaderText="Factura Nº" />
                            <asp:BoundField DataField="FacturaMaestroFechaEmisionFormato " HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />                            
                            <asp:BoundField DataField="PolDetPrimaCobrada" HeaderText="Prima" DataFormatString="{0:C}" />
                            <asp:BoundField DataField="PolMaeCodigoPoliza" HeaderText="Código" />
                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <asp:LinkButton
                                        ID="btnVerComprobante"
                                        runat="server"
                                        CommandName="VerComprobante"
                                        CommandArgument='<%# Eval("PolDetTPolizaMaestroFk") %>'
                                        CssClass="btn btn-sm btn-primary">
            <i class="fas fa-file-pdf"></i> Ver comprobante
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

            </div>
        </div>
    </section>
    <style>
        .pagination-container table {
            margin: 10px auto;
        }

        .pagination-container a,
        .pagination-container span {
            display: inline-block;
            padding: 6px 12px;
            margin: 0 2px;
            border: 1px solid #dee2e6;
            border-radius: 4px;
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
        }

            .pagination-container a:hover {
                background-color: #f0f0f0;
            }

        .pagination-container span {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
    <script>
        const fechaInput = document.getElementById('<%= txtFechaVenta.ClientID %>');

        fechaInput.addEventListener('input', function () {
            if (this.value.length > 10) { // yyyy-MM-dd = 10 caracteres
                this.value = this.value.slice(0, 10);
            }
        });
        fechaInput.addEventListener('keydown', function (e) {
            if (e.key === "Enter") {
                e.preventDefault(); // evita que haga postback
                return false;
            }
        });
    </script>
</asp:Content>
