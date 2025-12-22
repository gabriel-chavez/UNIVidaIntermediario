<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HistorialQrGenerado.aspx.cs" Inherits="UNIVidaIntermediario.HistorialQrGenerado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="mb-4">
        <div class="card">
            <div class="card-header text-center py-3">
                <h5 class="mb-0 text-center">
                    <strong>Historial de QR</strong>
                </h5>
            </div>
            <div class="card-body">


                <!-- Estado -->
                <div class="mb-4" style="position: relative;">
                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control form-control-lg" ClientIDMode="Static">
                        <asp:ListItem Text="TODOS" Value="-1" Selected="True" />
                        <asp:ListItem Text="SOLICITADO" Value="1" />
                        <asp:ListItem Text="HABILITADO" Value="2" />
                        <asp:ListItem Text="PAGADO" Value="3" />
                        <asp:ListItem Text="ANULADO" Value="4" />
                        <asp:ListItem Text="VENCIDO" Value="5" />
                        <asp:ListItem Text="RECHAZADO" Value="6" />
                        <asp:ListItem Text="ERROR DE IMAGEN" Value="7" />
                    </asp:DropDownList>
                    <label class="form-label" for="ddlEstado" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                        Estado
                    </label>
                </div>

                <!-- Filtros de fecha -->
                <div data-mdb-input-init class="form-outline mt-4">
                    <asp:TextBox ID="txtFechaVenta" MaxLength="15" runat="server" CssClass="form-control form-control-lg text-uppercase"
                        ClientIDMode="Static" TextMode="Date" ValidationGroup="buscar" />
                    <label class="form-label" for="txtFechaVenta">Fecha de venta</label>
                </div>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                    ControlToValidate="txtFechaVenta"
                    ValidationGroup="buscar"
                    InitialValue=""
                    ErrorMessage="Fecha requerida."
                    CssClass="small text-danger"
                    Display="Dynamic" />

                <div class="text-center mt-4">
                    <asp:LinkButton ID="btnVerQrGenerado" runat="server" CssClass="btn btn-primary d-flex align-items-center justify-content-center gap-2"
                        OnClick="btnVerQrGenerado_Click"
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
                    <asp:GridView ID="gvHistorialQr"
                        runat="server"
                        AutoGenerateColumns="False"
                        AllowPaging="true"
                        PageSize="10"
                        PagerSettings-Mode="Numeric"
                        CssClass="table table-striped table-hover"
                        PagerStyle-CssClass="pagination-container"
                        PagerStyle-HorizontalAlign="Center"  
                        OnRowCommand="gvHistorialQr_RowCommand"                        
                        OnPageIndexChanging="gvHistorialQr_PageIndexChanging"
                        DataKeyNames="TVehiSoatPropFk,TramiteSecuencial">
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

                            </div>
                        </EmptyDataTemplate>

                        <Columns>
                            <asp:BoundField DataField="FechaHoraSolicitud" HeaderText="Fecha Solicitud" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" />
                            <asp:BoundField DataField="Gestion" HeaderText="Gestión" />
                            <asp:BoundField DataField="IdentificadorVehiculo" HeaderText="Identificador Vehículo" />
                            <asp:BoundField DataField="Importe" HeaderText="Importe" DataFormatString="{0:C}" />
                            <asp:BoundField DataField="TParSimpleEstadoSolicitudDescripcion" HeaderText="Estado Solicitud" />
                            <asp:BoundField DataField="FechaHoraEstado" HeaderText="Fecha de Cambio" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}" />
                            <asp:BoundField DataField="Efectivizado" HeaderText="Efectivizado" />
                            <asp:BoundField DataField="MensajeEfectivizacion" HeaderText="Mensaje Efectivización" />
                            <asp:TemplateField HeaderText="Operaciones" HeaderStyle-Width="220" HeaderStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <div class="btn-group" role="group" style="gap: 5px; flex-wrap: wrap;">
                                        <asp:LinkButton ID="lnkConsultarEstado" runat="server" CommandName="ConsultarEstado" Text="Consultar Estado"
                                            CssClass="btn btn-primary btn-sm"                                            
                                            CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            Visible='<%# Eval("TParSimpleEstadoSolicitudFk").ToString() == "1" %>'>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="lnkConsultarEstado2" runat="server" CommandName="ConsultarEstado" Text="Consultar Estado"
                                            CssClass="btn btn-primary btn-sm"
                                            CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            Visible='<%# Eval("TParSimpleEstadoSolicitudFk").ToString() == "2" %>'>
                                        </asp:LinkButton>

                                        <asp:LinkButton ID="lnkAnular" runat="server" CommandName="Anular" Text="Anular QR"
                                            CssClass="btn btn-warning btn-sm"
                                            CommandArgument="<%# ((GridViewRow)Container).RowIndex %>"
                                            Visible='<%# Eval("TParSimpleEstadoSolicitudFk").ToString() == "2" %>'>
                                        </asp:LinkButton>

                                        <%--<asp:LinkButton ID="lnkVerComprobante" runat="server" CommandName="VerComprobante" Text="Ver Comprobante"
                                            CssClass="btn btn-success btn-sm"
                                            CommandArgument='<%# Container.DataItemIndex %>'
                                            Visible='<%# Eval("TParSimpleEstadoSolicitudFk").ToString() == "3" && Eval("Efectivizado").ToString() == "SI" %>'>
                                        </asp:LinkButton>--%>
                                    </div>
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
