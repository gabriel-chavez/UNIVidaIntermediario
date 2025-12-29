<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Venta.aspx.cs" Inherits="UNIVidaIntermediario.Venta" %>

<%@ Register Src="~/UCDatosPersonales.ascx" TagPrefix="uc" TagName="DatosPersonales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:MultiView ID="mvFormulario" runat="server" ActiveViewIndex="0">

        <!-- Paso 1 - Buscar Asegurado por Documento -->
        <asp:View ID="vwPaso1" runat="server">
            <asp:Panel ID="panel4" runat="server" DefaultButton="btnBuscarDocumento">
                <section class="mb-4">
                    <div class="card">
                        <div class="card-header text-center py-3">
                            <h5 class="mb-0 text-center">
                                <strong>Buscar Asegurado</strong>
                            </h5>
                        </div>
                        <div class="card-body">

                            <!-- Instrucción -->
                            <div class="alert alert-light border mb-4">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-info-circle text-primary me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-1 fw-bold">Ingrese el documento del asegurado</h6>
                                        <p class="mb-0 small text-muted">Complete el documento de identidad para buscar o registrar al asegurado</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Solo Número de Documento -->
                            <div class="row justify-content-center">
                                <div class="col-12 col-md-8 col-lg-6">
                                    <div class="mb-4 text-center">
                                        <label class="form-label fw-bold mb-3">Documento de Identidad</label>
                                        <div class="input-group input-group-lg">
                                            <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                            <asp:TextBox ID="txtDocumentoBusqueda" runat="server"
                                                CssClass="form-control text-center"
                                                ClientIDMode="Static"
                                                placeholder="Ingrese número de documento"
                                                MaxLength="15">
                                            </asp:TextBox>
                                        </div>

                                        <asp:RequiredFieldValidator ID="rfvDocumentoBusqueda" runat="server"
                                            ControlToValidate="txtDocumentoBusqueda"
                                            ErrorMessage="Ingrese el número de documento"
                                            CssClass="small text-danger d-block mt-2"
                                            Display="Dynamic"
                                            InitialValue=""
                                            ValidationGroup="BuscarAsegurado" />
                                        <asp:RegularExpressionValidator ID="revDocumentoBusqueda" runat="server"
                                            ControlToValidate="txtDocumentoBusqueda"
                                            ValidationExpression="^\d+$"
                                            ErrorMessage="Solo se permiten números"
                                            CssClass="small text-danger d-block mt-1"
                                            Display="Dynamic"
                                            InitialValue=""
                                            ValidationGroup="BuscarAsegurado" />

                                        <ajaxToolkit:FilteredTextBoxExtender
                                            ID="ftbeDocumentoBusqueda"
                                            runat="server"
                                            TargetControlID="txtDocumentoBusqueda"
                                            FilterType="Numbers" />
                                    </div>
                                </div>
                            </div>

                            <!-- Botón de búsqueda -->
                            <div class="text-center mt-4">
                                <asp:Button ID="btnBuscarDocumento" runat="server"
                                    Text="Buscar Asegurado"
                                    CssClass="btn btn-primary btn-lg px-5"
                                    OnClick="btnBuscarAsegurado_Click"
                                    ValidationGroup="BuscarAsegurado" />
                            </div>

                            <!-- Mensajes -->
                            <asp:Panel ID="pnlMensajeBusqueda" runat="server" Visible="false" CssClass="mt-4">
                                <div class="alert alert-dismissible fade show" role="alert">
                                    <asp:Label ID="lblMensajeBusqueda" runat="server"></asp:Label>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                </div>
                            </asp:Panel>

                            <div id="divGridAsegurados" runat="server" visible="false">
                                <div class="alert alert-warning mb-3 mt-3">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-exclamation-triangle me-3 fa-lg"></i>
                                        <div>
                                            <h6 class="mb-1 fw-bold">Se encontraron múltiples clientes con el mismo documento</h6>
                                            <p class="mb-0 small">
                                                Por favor, seleccione el cliente correcto revisando los detalles adicionales.
                                            </p>
                                        </div>
                                    </div>
                                </div>


                                <asp:GridView ID="gvClientes"
                                    runat="server"
                                    AutoGenerateColumns="False"
                                    AllowPaging="true"
                                    PageSize="10"
                                    CssClass="table table-striped table-hover"
                                    OnRowCommand="gvClientes_RowCommand">

                                    <EmptyDataTemplate>
                                        <div class="text-center py-5 text-muted">
                                            No se encontraron clientes
                                        </div>
                                    </EmptyDataTemplate>

                                    <Columns>

                                        <asp:TemplateField HeaderText="Nombre Completo">
                                            <ItemTemplate>
                                                <%# Eval("PerApellidoPaterno") + " " + 
            Eval("PerApellidoMaterno") + " " + 
            Eval("PerApellidoCasada") + " " + 
            Eval("PerNombrePrimero") + " " + 
            Eval("PerNombreSegundo") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:BoundField DataField="PerTParCliDocumentoIdentidadTipoDescripcion"
                                            HeaderText="Tipo Documento" />


                                        <asp:BoundField DataField="PerDocumentoIdentidadNumero"
                                            HeaderText="Número Documento"
                                            ItemStyle-HorizontalAlign="Center" />


                                        <asp:BoundField DataField="PerDocumentoIdentidadExtension"
                                            HeaderText="Extensión"
                                            ItemStyle-HorizontalAlign="Center" />


                                        <asp:BoundField DataField="PerTParGenDepartamentoDescripcionDocumentoIdentidad"
                                            HeaderText="Departamento" />


                                        <asp:BoundField DataField="PerFechaAdicionFormato" HeaderText="Fecha de Registro" />


                                        <asp:TemplateField HeaderText="Acción" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                            <ItemTemplate>
                                                <asp:Button ID="btnSeleccionar" runat="server"
                                                    Text="Seleccionar"
                                                    CssClass="btn btn-primary btn-sm"
                                                    CommandName="SeleccionarCliente"
                                                    CommandArgument='<%#Eval("PerSecuencial")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </section>
            </asp:Panel>

        </asp:View>
        <!-- Paso 2: Datos del Asegurado -->
        <asp:View ID="vwPaso2" runat="server">
            <asp:Panel ID="panel2" runat="server" DefaultButton="btnSiguiente1">
                <section class="mb-4">
                    <div class="card">
                        <div class="card-header text-center py-3">
                            <h5 class="mb-0 text-center">
                                <strong>Datos Asegurado</strong>
                            </h5>
                        </div>
                        <div class="card-body">

                            <!-- User Control para Asegurado -->
                            <uc:DatosPersonales ID="ucAsegurado" runat="server"
                                TipoPersona="ASEGURADO"
                                ValidationGroup="Paso2" />

                            <!-- Botones -->
                            <div class="row mt-4">
                                <div class="col-6">
                                    <asp:Button ID="btnAnterior1" runat="server" Text="Atrás"
                                        CssClass="btn btn-outline-primary w-100"
                                        OnClick="btnAnterior1_Click" />
                                </div>
                                <div class="col-6">
                                    <asp:Button ID="btnSiguiente1" runat="server" Text="Siguiente"
                                        CssClass="btn btn-primary w-100"
                                        OnClick="btnSiguiente1_Click"
                                        ValidationGroup="Paso2" />
                                </div>
                            </div>

                        </div>
                    </div>
                </section>
            </asp:Panel>

        </asp:View>
        <!-- Paso 3 - ¿Tomador diferente del asegurado? -->
        <asp:View ID="vwPaso3" runat="server">
            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong>Consulta</strong>
                        </h5>
                    </div>
                    <div class="card-body text-center">

                        <!-- Pregunta -->
                        <div class="mb-5">
                            <h4 class="text-dark mb-3">
                                <i class="fas fa-question-circle text-primary me-2"></i>
                                ¿El tomador es diferente del asegurado?
                            </h4>
                            <p class="text-muted">Seleccione una opción para continuar</p>
                        </div>

                        <!-- Opciones de selección -->
                        <div class="row justify-content-center mb-5">
                            <div class="col-12 col-md-10 col-lg-8">

                                <!-- Opción Sí -->
                                <div class="form-check card-option mb-4">
                                    <asp:RadioButton ID="rbTomadorDiferenteSi" runat="server"
                                        GroupName="TomadorDiferente"
                                        CssClass="form-check-input d-none"
                                        ClientIDMode="Static" />
                                    <label class="form-check-label card h-100 border-3" for="rbTomadorDiferenteSi">
                                        <div class="card-body p-4 text-center">
                                            <div class="mb-3">
                                                <div class="option-icon mx-auto mb-3">
                                                    <i class="fas fa-user-friends fa-3x text-warning"></i>
                                                </div>
                                                <h5 class="card-title fw-bold text-dark">Sí</h5>
                                                <p class="card-text text-muted">
                                                    El tomador es una persona diferente al asegurado
                                                </p>
                                            </div>

                                        </div>
                                    </label>
                                </div>

                                <!-- Opción No -->
                                <div class="form-check card-option">
                                    <asp:RadioButton ID="rbTomadorDiferenteNo" runat="server"
                                        GroupName="TomadorDiferente"
                                        CssClass="form-check-input d-none"
                                        ClientIDMode="Static" />
                                    <label class="form-check-label card h-100 border-3" for="rbTomadorDiferenteNo">
                                        <div class="card-body p-4 text-center">
                                            <div class="mb-3">
                                                <div class="option-icon mx-auto mb-3">
                                                    <i class="fas fa-user fa-3x text-success"></i>
                                                </div>
                                                <h5 class="card-title fw-bold text-dark">No</h5>
                                                <p class="card-text text-muted">
                                                    El tomador es la misma persona que el asegurado
                                                </p>
                                            </div>

                                        </div>
                                    </label>
                                </div>

                            </div>
                        </div>

                        <!-- Botones de navegación -->
                        <div class="row mt-5">
                            <div class="col-6">
                                <asp:Button ID="btnAnterior2" runat="server"
                                    Text="Atrás"
                                    CssClass="btn btn-outline-primary w-100"
                                    OnClick="btnAnterior2_Click"
                                    CausesValidation="false" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnSiguienteTomador" runat="server"
                                    Text="Siguiente"
                                    CssClass="btn btn-primary w-100"
                                    OnClick="btnSiguiente2_Click"
                                    Enabled="false"
                                    ClientIDMode="Static" />
                            </div>
                        </div>

                    </div>
                </div>
            </section>
        </asp:View>
        <!-- Paso 4 - Buscar Tomador por Documento -->
        <asp:View ID="vwPaso4" runat="server">
            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong>Buscar Tomador</strong>
                        </h5>
                    </div>
                    <div class="card-body">

                        <!-- Instrucción -->
                        <div class="alert alert-light border mb-4">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-info-circle text-primary me-3 fa-lg"></i>
                                <div>
                                    <h6 class="mb-1 fw-bold">Ingrese el documento del tomador</h6>
                                    <p class="mb-0 small text-muted">Complete el documento de identidad para buscar o registrar al tomador</p>
                                </div>
                            </div>
                        </div>

                        <!-- Solo Número de Documento -->
                        <div class="row justify-content-center">
                            <div class="col-12 col-md-8 col-lg-6">
                                <div class="mb-4 text-center">
                                    <label class="form-label fw-bold mb-3">Documento de Identidad</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                        <asp:TextBox ID="txtDocumentoBusquedaTomador" runat="server"
                                            CssClass="form-control text-center"
                                            ClientIDMode="Static"
                                            placeholder="Ingrese número de documento"
                                            MaxLength="15">
                                        </asp:TextBox>
                                    </div>

                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                        ControlToValidate="txtDocumentoBusquedaTomador"
                                        ErrorMessage="Ingrese el número de documento"
                                        CssClass="small text-danger d-block mt-2"
                                        Display="Dynamic"
                                        InitialValue=""
                                        ValidationGroup="BuscarTomador" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                        ControlToValidate="txtDocumentoBusquedaTomador"
                                        ValidationExpression="^\d+$"
                                        ErrorMessage="Solo se permiten números"
                                        CssClass="small text-danger d-block mt-1"
                                        Display="Dynamic"
                                        InitialValue=""
                                        ValidationGroup="BuscarTomador" />

                                    <ajaxToolkit:FilteredTextBoxExtender
                                        ID="FilteredTextBoxExtender5"
                                        runat="server"
                                        TargetControlID="txtDocumentoBusquedaTomador"
                                        FilterType="Numbers" />
                                </div>
                            </div>
                        </div>

                        <!-- Botón de búsqueda -->
                        <div class="row mt-5">
                            <!-- Botones de navegación -->


                            <div class="col-6">
                                <asp:Button ID="btnAnterior3" runat="server"
                                    Text="Anterior"
                                    CssClass="btn btn-outline-primary w-100"
                                    OnClick="btnAnterior3_Click" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnSiguiente3" runat="server"
                                    Text="Siguiente"
                                    CssClass="btn btn-primary w-100"
                                    OnClick="btnSiguiente3_Click"
                                    CausesValidation="false" />
                            </div>
                        </div>




                        <!-- Mensajes -->
                        <asp:Panel ID="Panel1" runat="server" Visible="false" CssClass="mt-4">
                            <div class="alert alert-dismissible fade show" role="alert">
                                <asp:Label ID="Label1" runat="server"></asp:Label>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </asp:Panel>

                        <div id="divGridTomador" runat="server" visible="false">
                            <div class="alert alert-warning mb-3 mt-3">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-exclamation-triangle me-3 fa-lg"></i>
                                    <div>
                                        <h6 class="mb-1 fw-bold">Se encontraron múltiples clientes con el mismo documento</h6>
                                        <p class="mb-0 small">
                                            Por favor, seleccione el cliente correcto revisando los detalles adicionales.
                                        </p>
                                    </div>
                                </div>
                            </div>


                            <asp:GridView ID="gvClientesTomador"
                                runat="server"
                                AutoGenerateColumns="False"
                                AllowPaging="true"
                                PageSize="10"
                                CssClass="table table-striped table-hover"
                                OnRowCommand="gvClientesTomador_RowCommand">

                                <EmptyDataTemplate>
                                    <div class="text-center py-5 text-muted">
                                        No se encontraron clientes
                                    </div>
                                </EmptyDataTemplate>

                                <Columns>

                                    <asp:TemplateField HeaderText="Nombre Completo">
                                        <ItemTemplate>
                                            <%# Eval("PerApellidoPaterno") + " " + 
             Eval("PerApellidoMaterno") + " " + 
             Eval("PerApellidoCasada") + " " + 
             Eval("PerNombrePrimero") + " " + 
             Eval("PerNombreSegundo") %>
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                    <asp:BoundField DataField="PerTParCliDocumentoIdentidadTipoDescripcion"
                                        HeaderText="Tipo Documento" />


                                    <asp:BoundField DataField="PerDocumentoIdentidadNumero"
                                        HeaderText="Número Documento"
                                        ItemStyle-HorizontalAlign="Center" />


                                    <asp:BoundField DataField="PerDocumentoIdentidadExtension"
                                        HeaderText="Extensión"
                                        ItemStyle-HorizontalAlign="Center" />


                                    <asp:BoundField DataField="PerTParGenDepartamentoDescripcionDocumentoIdentidad"
                                        HeaderText="Departamento" />


                                    <asp:BoundField DataField="PerFechaAdicionFormato" HeaderText="Fecha de Registro" />


                                    <asp:TemplateField HeaderText="Acción" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="120px">
                                        <ItemTemplate>
                                            <asp:Button ID="btnSeleccionar" runat="server"
                                                Text="Seleccionar"
                                                CssClass="btn btn-primary btn-sm"
                                                CommandName="SeleccionarCliente"
                                                CommandArgument='<%#Eval("PerSecuencial")%>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </section>
        </asp:View>
        <!-- Paso 5: Datos del Tomador -->
        <asp:View ID="vwPaso5" runat="server">
            <asp:Panel ID="panel3" runat="server" DefaultButton="btnSiguiente4">
                <section class="mb-4">
                    <div class="card">
                        <div class="card-header text-center py-3">
                            <h5 class="mb-0 text-center">
                                <strong>Datos Tomador</strong>
                            </h5>
                        </div>
                        <div class="card-body">

                            <!-- User Control para tomador -->
                            <uc:DatosPersonales ID="ucTomador" runat="server"
                                TipoPersona="TOMADOR"
                                ValidationGroup="Paso5" />

                            <!-- Botones -->
                            <div class="row mt-4">
                                <div class="col-6">
                                    <asp:Button ID="btnAnterior4" runat="server" Text="Atrás"
                                        CssClass="btn btn-outline-primary w-100"
                                        OnClick="btnAnterior4_Click" />
                                </div>
                                <div class="col-6">
                                    <asp:Button ID="btnSiguiente4" runat="server" Text="Siguiente"
                                        CssClass="btn btn-primary w-100"
                                        OnClick="btnSiguiente4_Click"
                                        ValidationGroup="Paso5" />
                                </div>
                            </div>

                        </div>
                    </div>
                </section>
            </asp:Panel>

        </asp:View>


        <!-- Paso 6 - Beneficiarios -->
        <asp:View ID="vwBeneficiarios" runat="server">
            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong>Beneficiarios</strong>
                        </h5>
                    </div>
                    <div class="card-body">

                        <!-- Información -->
                        <div class="alert alert-info mb-3 text-center">
                            <i class="fas fa-info-circle me-2"></i>
                            <strong>Para la cobertura por muerte, será(n) los herederos legales del asegurado</strong>
                        </div>

                        <!-- Nota -->
                        <div class="alert alert-light border text-center mb-4">
                            <i class="fas fa-sticky-note me-2"></i>
                            <span class="fst-italic">Nota: No es obligatorio registrar beneficiario(s).</span>
                        </div>

                        <!-- Línea divisoria -->
                        <hr class="my-4" />

                        <!-- Botón Agregar Beneficiario -->
                        <div class="text-center mb-4">
                            <button type="button" class="btn btn-primary btn-lg" data-mdb-ripple-init data-mdb-modal-init data-mdb-target="#modalAgregarBeneficiario">
                                <i class="fas fa-user-plus me-2"></i>AGREGAR BENEFICIARIO
                            </button>
                        </div>

                        <!-- Lista de beneficiarios -->
                        <div class="card border">
                            <div class="card-header bg-light">
                                <h6 class="mb-0"><i class="fas fa-users me-2"></i>Beneficiarios Agregados</h6>
                            </div>
                            <div class="card-body p-0">

                                <!-- Mensaje cuando no hay beneficiarios -->
                                <asp:Panel ID="pnlListaVacia" runat="server" CssClass="text-center py-5">
                                    <div class="mb-3">
                                        <i class="fas fa-user-friends fa-3x text-muted"></i>
                                    </div>
                                    <h5 class="text-muted">No se han agregado beneficiarios</h5>
                                    <p class="text-muted small">Haga clic en "AGREGAR BENEFICIARIO" para registrar uno</p>
                                </asp:Panel>

                                <!-- GridView de beneficiarios -->
                                <asp:GridView ID="gvBeneficiarios" runat="server"
                                    AutoGenerateColumns="false"
                                    CssClass="table table-hover mb-0"
                                    ShowHeaderWhenEmpty="true"
                                    DataKeyNames="Id"
                                    OnRowDeleting="gvBeneficiarios_RowDeleting"
                                    Visible="false">

                                    <Columns>

                                        <asp:TemplateField HeaderText="#" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Nombre Completo">
                                            <ItemTemplate>
                                                <%# Eval("PolBenNombreCompleto") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Parentesco">
                                            <ItemTemplate>
                                                <%# Eval("PolBenTParEmiBeneficiarioParentescoFk") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Porcentaje" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <span class="badge bg-primary">
                                                    <%# Eval("PolBenBeneficioPorcentaje") %>%
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Acciones" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>

                                                <asp:LinkButton runat="server"
                                                    CommandName="Delete"
                                                    CssClass="btn btn-sm btn-outline-danger"
                                                    ToolTip="Eliminar"
                                                    OnClientClick="return confirm('¿Está seguro de eliminar este beneficiario?');">
                    <i class="fas fa-trash"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>

                                    <EmptyDataTemplate>
                                        <div class="text-center py-4 text-muted">
                                            <i class="fas fa-user-friends fa-2x mb-2"></i>
                                            <p>No hay beneficiarios registrados</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>


                                <!-- Resumen de porcentajes -->
                                <asp:Panel ID="pnlResumenPorcentajes" runat="server" Visible="false" CssClass="card-footer">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <strong>Total asignado:</strong>
                                            <span class="badge bg-success ms-2" id="spanTotalPorcentaje" runat="server">0%</span>
                                        </div>
                                        <div class="col-md-6 text-end">
                                            <asp:Label ID="lblEstadoPorcentaje" runat="server" CssClass="small"></asp:Label>
                                        </div>
                                    </div>
                                    <!-- Barra de progreso -->
                                    <div class="progress mt-2" style="height: 10px;">
                                        <div id="progressBarPorcentaje" runat="server"
                                            class="progress-bar"
                                            role="progressbar"
                                            style="width: 0%;">
                                        </div>
                                    </div>
                                </asp:Panel>

                            </div>
                        </div>

                        <!-- Botones de navegación -->
                        <div class="row mt-4">
                            <div class="col-6">
                                <asp:Button ID="btnAnteriorBeneficiarios" runat="server"
                                    Text="Atrás"
                                    CssClass="btn btn-outline-primary w-100"
                                    OnClick="btnAnteriorBeneficiarios_Click"
                                    CausesValidation="false" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnSiguienteBeneficiarios" runat="server"
                                    Text="Siguiente"
                                    CssClass="btn btn-primary w-100"
                                    OnClick="btnSiguienteBeneficiarios_Click" />
                            </div>
                        </div>

                    </div>
                </div>
            </section>


            <!-- Modal para Agregar/Editar Beneficiario -->
            <div class="modal fade" id="modalAgregarBeneficiario" tabindex="-1" aria-labelledby="modalAgregarBeneficiarioLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="modalAgregarBeneficiarioLabel">
                                <i class="fas fa-user-plus me-2"></i>
                                <asp:Label ID="lblModalTitulo" runat="server" Text="Agregar Beneficiario"></asp:Label>
                            </h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <asp:Panel ID="pnlModalBeneficiario" runat="server" DefaultButton="btnGuardarBeneficiario">
                            <div class="modal-body">
                                <asp:HiddenField ID="hfBeneficiarioId" runat="server" Value="0" />
                                <asp:HiddenField ID="hfEsEdicion" runat="server" Value="false" />

                                <div class="row">
                                    <!-- Nombre Completo -->
                                    <div class="col-md-12 mb-4">
                                        <div data-mdb-input-init class="form-outline">
                                            <asp:TextBox ID="txtNombreCompletoBeneficiario" runat="server"
                                                CssClass="form-control form-control-lg"
                                                placeholder=" "
                                                MaxLength="100"
                                                ClientIDMode="Static" />
                                            <label class="form-label" for="<%= txtNombreCompletoBeneficiario.ClientID %>">
                                                Nombre Completo <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="rfvNombreCompletoBeneficiario" runat="server"
                                            ControlToValidate="txtNombreCompletoBeneficiario"
                                            ErrorMessage="Ingrese el nombre completo"
                                            CssClass="small text-danger"
                                            Display="Dynamic"
                                            ValidationGroup="ModalBeneficiario" />
                                        <ajaxToolkit:FilteredTextBoxExtender
                                            ID="ftbeNombreCompletoBeneficiario"
                                            runat="server"
                                            TargetControlID="txtNombreCompletoBeneficiario"
                                            FilterType="Custom, UppercaseLetters, LowercaseLetters"
                                            ValidChars=" -'"
                                            FilterMode="ValidChars" />
                                    </div>

                                    <!-- Parentesco -->
                                    <div class="col-md-6 mb-4">
                                        <div style="position: relative;">
                                            <asp:DropDownList ID="ddlParentesco" runat="server"
                                                CssClass="form-control form-control-lg"
                                                ClientIDMode="Static">
                                                <asp:ListItem Value="0" Text="Seleccione"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="Cónyuge"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="Hijo(a)"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="Padre/Madre"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="Hermano(a)"></asp:ListItem>
                                                <asp:ListItem Value="5" Text="Otro"></asp:ListItem>
                                            </asp:DropDownList>
                                            <label class="form-label" for="<%= ddlParentesco.ClientID %>"
                                                style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                                Parentesco <span class="text-danger">*</span>
                                            </label>
                                        </div>
                                        <asp:RequiredFieldValidator ID="rfvParentesco" runat="server"
                                            ControlToValidate="ddlParentesco"
                                            InitialValue="0"
                                            ErrorMessage="Seleccione el parentesco"
                                            CssClass="small text-danger"
                                            Display="Dynamic"
                                            ValidationGroup="ModalBeneficiario" />
                                    </div>

                                    <!-- Porcentaje -->
                                    <div class="col-md-6 mb-4">
                                        <div data-mdb-input-init class="form-outline">
                                            <asp:TextBox ID="txtPorcentaje" runat="server"
                                                CssClass="form-control form-control-lg"
                                                TextMode="Number"
                                                min="1"
                                                max="100"
                                                placeholder=" "
                                                ClientIDMode="Static" />
                                            <label class="form-label" for="<%= txtPorcentaje.ClientID %>">
                                                Porcentaje <span class="text-danger">*</span>
                                            </label>
                                            <span class="position-absolute" style="right: 28px; top: 11px; color: #6c757d;">%</span>
                                        </div>
                                        <asp:RequiredFieldValidator ID="rfvPorcentaje" runat="server"
                                            ControlToValidate="txtPorcentaje"
                                            ErrorMessage="Ingrese el porcentaje"
                                            CssClass="small text-danger"
                                            Display="Dynamic"
                                            ValidationGroup="ModalBeneficiario" />
                                        <asp:RangeValidator ID="rvPorcentaje" runat="server"
                                            ControlToValidate="txtPorcentaje"
                                            Type="Integer"
                                            MinimumValue="1"
                                            MaximumValue="100"
                                            ErrorMessage="El porcentaje debe estar entre 1 y 100"
                                            CssClass="small text-danger"
                                            Display="Dynamic"
                                            ValidationGroup="ModalBeneficiario" />
                                        <ajaxToolkit:FilteredTextBoxExtender
                                            ID="ftbePorcentaje"
                                            runat="server"
                                            TargetControlID="txtPorcentaje"
                                            FilterType="Numbers" />
                                    </div>

                                </div>

                                <!-- Resumen de validación -->
                                <asp:ValidationSummary ID="vsModalBeneficiario" runat="server"
                                    CssClass="alert alert-danger"
                                    ValidationGroup="ModalBeneficiario"
                                    ShowSummary="true"
                                    ShowMessageBox="false" />

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-mdb-ripple-init data-mdb-dismiss="modal">Cancelar</button>

                                <asp:Button ID="btnGuardarBeneficiario" runat="server"
                                    Text="Guardar Beneficiario"
                                    CssClass="btn btn-primary"
                                    OnClick="btnGuardarBeneficiario_Click"
                                    ValidationGroup="ModalBeneficiario" />
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </div>

        </asp:View>
        <!-- Paso 7 - Facturación -->
        <asp:View ID="vmFacturacion" runat="server">
            <asp:Panel ID="panelPaso6" runat="server" DefaultButton="btnSiguienteFacturacion">
                <section class="mb-4">
                    <div class="card">
                        <div class="card-header text-center py-3">
                            <h5 class="mb-0 text-center">
                                <strong>Datos de facturación <span id="spanIdentificador" runat="server"></span></strong>
                            </h5>
                        </div>
                        <div class="card-body">

                            <asp:ValidationSummary ID="vsErrores" runat="server" CssClass="text-danger mb-3" />

                            <!-- Tipo de documento -->
                            <div class="mb-3 mt-5" style="position: relative;">

                                <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="form-control form-control-lg" ClientIDMode="Static">
                                </asp:DropDownList>
                                <label class="form-label" for="ddlTipoDocumento" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                    Tipo de documento
                                </label>

                                <asp:RequiredFieldValidator ID="rfvTipoDocumento" runat="server"
                                    ControlToValidate="ddlTipoDocumento"
                                    InitialValue="0"
                                    ErrorMessage="El tipo de documento es requerido."
                                    CssClass="small text-danger"
                                    Display="Dynamic"
                                    ValidationGroup="panelPaso6" />
                            </div>


                            <!-- Número de documento -->

                            <div data-mdb-input-init class="form-outline mt-4">
                                <asp:TextBox ID="txtNumeroDocumento" TextMode="Number" MaxLength="10" runat="server" CssClass="form-control form-control-lg text-uppercase" ClientIDMode="Static" />
                                <label class="form-label" for="txtNumeroDocumento">Número de documento</label>
                            </div>
                            <ajaxToolkit:FilteredTextBoxExtender
                                ID="FilteredTextBoxExtender1"
                                runat="server"
                                TargetControlID="txtNumeroDocumento"
                                FilterType="Numbers" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
                                ControlToValidate="txtNumeroDocumento"
                                InitialValue=""
                                ErrorMessage="Número de documento requerido."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="panelPaso6" />
                            <asp:RegularExpressionValidator ID="revNumeroDocumento" runat="server"
                                ControlToValidate="txtNumeroDocumento"
                                ValidationExpression="^\d+$"
                                ErrorMessage="Solo se permiten números."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="panelPaso6" />
                            <!-- Complemento -->
                            <div data-mdb-input-init class="form-outline mt-4" runat="server" id="divComplemento" visible="false">
                                <asp:TextBox ID="txtComplemento" MaxLength="5" runat="server" CssClass="form-control form-control-lg text-uppercase" ClientIDMode="Static" />
                                <label class="form-label" for="txtComplemento">Complemento</label>
                            </div>
                            <ajaxToolkit:FilteredTextBoxExtender
                                ID="FilteredTextBoxExtender4"
                                runat="server"
                                TargetControlID="txtComplemento"
                                FilterType="Custom, Numbers, LowercaseLetters, UppercaseLetters"
                                ValidChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -_"
                                FilterMode="ValidChars" />


                            <!-- Nombres o razón social -->
                            <div data-mdb-input-init class="form-outline mt-4">
                                <asp:TextBox ID="txtRazonSocial" MaxLength="50" runat="server" CssClass="form-control form-control-lg text-uppercase" ClientIDMode="Static" />
                                <label class="form-label" for="txtRazonSocial">Nombres o razón social</label>
                            </div>
                            <ajaxToolkit:FilteredTextBoxExtender
                                ID="FilteredTextBoxExtender2"
                                runat="server"
                                TargetControlID="txtRazonSocial"
                                FilterType="Custom, Numbers, LowercaseLetters, UppercaseLetters"
                                ValidChars=" -._@()/+,"
                                FilterMode="ValidChars" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
                                ControlToValidate="txtRazonSocial"
                                InitialValue=""
                                ErrorMessage="Nombres o razón social requerido."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="panelPaso6" />

                            <!-- Correo electrónico -->
                            <div data-mdb-input-init class="form-outline mt-4">
                                <asp:TextBox ID="txtCorreo" MaxLength="50" runat="server" CssClass="form-control form-control-lg " TextMode="Email" ClientIDMode="Static" />
                                <label class="form-label" for="txtCorreo">Correo electrónico</label>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
                                ControlToValidate="txtCorreo"
                                InitialValue=""
                                ErrorMessage="Correo electrónico requerido."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="panelPaso6" />
                            <ajaxToolkit:FilteredTextBoxExtender
                                ID="FilteredTextBoxExtenderCorreo"
                                runat="server"
                                TargetControlID="txtCorreo"
                                FilterType="Custom, Numbers, LowercaseLetters, UppercaseLetters"
                                ValidChars="@.-_+"
                                FilterMode="ValidChars" />
                            <asp:RegularExpressionValidator
                                ID="RegexCorreo"
                                runat="server"
                                ControlToValidate="txtCorreo"
                                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                ErrorMessage="Formato de correo electrónico inválido."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="panelPaso6" />

                            <!-- Número de celular -->
                            <div data-mdb-input-init class="form-outline mt-4">
                                <asp:TextBox ID="txtCelular"
                                    runat="server"
                                    CssClass="form-control form-control-lg"
                                    ClientIDMode="Static"
                                    type="tel"
                                    MaxLength="8"
                                    oninput="limitLength(this)" />
                                <label class="form-label" for="txtCelular">Número de celular</label>
                            </div>
                            <ajaxToolkit:FilteredTextBoxExtender
                                ID="FilteredTextBoxExtender3"
                                runat="server"
                                TargetControlID="txtCelular"
                                FilterType="Numbers" />
                            <asp:CustomValidator
                                ID="CustomValidatorCelular"
                                runat="server"
                                ControlToValidate="txtCelular"
                                ClientValidationFunction="validateCelular"
                                ErrorMessage="El número de celular debe comenzar con un 6 o un 7 y tener 8 dígitos."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="panelPaso6" />

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                ControlToValidate="txtCelular"
                                InitialValue=""
                                ErrorMessage="Número de celular requerido."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="panelPaso6" />
                            <ajaxToolkit:FilteredTextBoxExtender ID="ftbCelular" runat="server" TargetControlID="txtCelular" FilterType="Numbers" />


                            <!-- Botones -->
                            <div class="row mt-4">
                                <div class="col-6">
                                    <asp:Button ID="btnAnteriorFacturacion" runat="server" Text="Anterior" CssClass="btn btn-secondary w-100" CausesValidation="false" OnClick="btnAnteriorFacturacion_Click" />
                                </div>
                                <div class="col-6">
                                    <asp:Button ID="btnSiguienteFacturacion" runat="server" Text="Finalizar" CssClass="btn btn-success w-100 btn-loading" ValidationGroup="panelPaso6" OnClick="btnSiguienteFacturacion_Click" />
                                </div>
                            </div>
                        </div>






                    </div>
                </section>
            </asp:Panel>

        </asp:View>
        <!-- Paso 8 - Mostrar PDF -->
        <asp:View ID="vmReporte" runat="server">
            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong>Certificado de cobertura</strong>
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="divDocumento" class="mt-4">

                            <div class="text-center">
                                <iframe id="pdfViewer" src="" style="width: 100%; height: 500px;" frameborder="0" runat="server"></iframe>
                            </div>
                        </div>



                        <!-- Botón de búsqueda -->
                        <div class="text-center mt-4">
                            <asp:Button ID="btnCerrarFormularioVenta" runat="server"
                                Text="Cerrar"
                                CssClass="btn btn-primary btn-lg px-5"
                                OnClick="btnCerrarFormularioVenta_Click" />
                        </div>
                    </div>
                </div>
            </section>
        </asp:View>
    </asp:MultiView>

    <script>
        $(document).ready(function () {
            // Habilitar/deshabilitar botón siguiente
            function actualizarBotonSiguiente() {
                var seleccionado = $('input[name="ctl00$MainContent$TomadorDiferente"]:checked').length > 0;
                $('#btnSiguienteTomador').prop('disabled', !seleccionado);
            }

            // Efecto de selección en las tarjetas
            $('.card-option').click(function () {
                // Remover selección de todas las tarjetas
                $('.card-option .card').removeClass('selected border-primary').addClass('border-light');

                // Seleccionar la tarjeta clickeada
                $(this).find('.card').removeClass('border-light').addClass('selected border-primary');

                // Marcar el radio button correspondiente
                var radioId = $(this).find('input[type="radio"]').attr('id');
                $('#' + radioId).prop('checked', true);

                // Actualizar botón
                actualizarBotonSiguiente();

                // Animación
                $(this).find('.card').addClass('animate__animated animate__pulse');
                setTimeout(function () {
                    $('.card').removeClass('animate__animated animate__pulse');
                }, 500);
            });

            // Efecto hover
            $('.card-option').hover(
                function () {
                    if (!$(this).find('.card').hasClass('selected')) {
                        $(this).find('.card').removeClass('border-light').addClass('border-secondary shadow-sm');
                    }
                },
                function () {
                    if (!$(this).find('.card').hasClass('selected')) {
                        $(this).find('.card').removeClass('border-secondary shadow-sm').addClass('border-light');
                    }
                }
            );

            // Verificar si ya hay una selección previa
            function verificarSeleccionPrevia() {
                var seleccionado = $('input[name="ctl00$MainContent$TomadorDiferente"]:checked');
                if (seleccionado.length > 0) {
                    var cardOption = seleccionado.closest('.form-check');
                    cardOption.find('.card').addClass('selected border-primary').removeClass('border-light');
                    $('#btnSiguienteTomador').prop('disabled', false);
                }
            }

            // Inicializar
            verificarSeleccionPrevia();

            // Validar al hacer clic en siguiente
            $('#btnSiguienteTomador').click(function (e) {
                if ($(this).prop('disabled')) {
                    e.preventDefault();
                    showNotification('warning', 'Por favor, seleccione una opción');
                    // Animar las opciones para llamar la atención
                    $('.card-option').addClass('animate__animated animate__shakeX');
                    setTimeout(function () {
                        $('.card-option').removeClass('animate__animated animate__shakeX');
                    }, 1000);
                }
            });

        });
        $(document).ready(function () {
            $('#modalAgregarBeneficiario').on('hidden.bs.modal', function () {
                limpiarModalBeneficiario();
            });

            function limpiarModalBeneficiario() {

                $('#<%= txtNombreCompletoBeneficiario.ClientID %>').val('');
                $('#<%= ddlParentesco.ClientID %>').val('0');
                $('#<%= txtPorcentaje.ClientID %>').val('');


                $('#<%= hfBeneficiarioId.ClientID %>').val('0');
                $('#<%= hfEsEdicion.ClientID %>').val('false');


                $('#<%= lblModalTitulo.ClientID %>').text('Agregar Beneficiario');


                $('.text-danger').hide();
                $('.alert-danger').hide();


                $('.form-control').removeClass('is-invalid');
                $('.form-select').removeClass('is-invalid');
            }

            $('#modalAgregarBeneficiario').on('show.bs.modal', function () {
                limpiarModalBeneficiario();
            });
        });
        document.addEventListener("DOMContentLoaded", function () {
            var input = document.getElementById("txtNumeroDocumento");
            input.addEventListener("input", function () {
                // corta si se pasa de 10 caracteres
                if (this.value.length > 10) {
                    this.value = this.value.slice(0, 10);
                }
            });
        });

    </script>
    <style>
        /* Estilos para las opciones de selección */
        .card-option {
            cursor: pointer;
            transition: all 0.3s ease;
        }

            .card-option .card {
                border: 3px solid #f8f9fa;
                border-radius: 15px;
                transition: all 0.3s ease;
            }

                .card-option .card:hover {
                    transform: translateY(-3px);
                    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                }

                .card-option .card.selected {
                    border-color: #0d6efd !important;
                    background-color: rgba(13, 110, 253, 0.05);
                    box-shadow: 0 5px 15px rgba(13, 110, 253, 0.2);
                }

        .option-icon {
            width: 80px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }

        #rbTomadorDiferenteSi:checked ~ label .option-icon {
            background-color: rgba(255, 193, 7, 0.1);
        }

        #rbTomadorDiferenteNo:checked ~ label .option-icon {
            background-color: rgba(25, 135, 84, 0.1);
        }

        .option-details {
            min-height: 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* Animaciones */
        .animate__shakeX {
            animation-duration: 0.5s;
        }

        .animate__pulse {
            animation-duration: 0.5s;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .card-option .card-body {
                padding: 1.5rem !important;
            }

            .option-icon {
                width: 60px;
                height: 60px;
            }

                .option-icon i {
                    font-size: 2rem !important;
                }
        }

        /* Estado del botón */
        #btnSiguienteTomador:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .form-outline.position-relative {
            position: relative;
        }
    </style>
</asp:Content>
