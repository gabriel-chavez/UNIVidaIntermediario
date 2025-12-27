<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VentaIntermediario.aspx.cs" Inherits="UNIVidaIntermediario.VentaIntermediario" %>

<%@ Register Src="~/UCDatosPersonales.ascx" TagPrefix="uc" TagName="DatosPersonales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:MultiView ID="mvFormulario" runat="server" ActiveViewIndex="1">

        <!-- Paso 1 - Buscar Asegurado por Documento -->
        <asp:View ID="vwPaso1" runat="server">
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
                                        ValidationGroup="BuscarAsegurado" />
                                    <asp:RegularExpressionValidator ID="revDocumentoBusqueda" runat="server"
                                        ControlToValidate="txtDocumentoBusqueda"
                                        ValidationExpression="^\d+$"
                                        ErrorMessage="Solo se permiten números"
                                        CssClass="small text-danger d-block mt-1"
                                        Display="Dynamic"
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

                    </div>
                </div>
            </section>
        </asp:View>
        <!-- Paso 2: Datos del Asegurado -->
        <asp:View ID="vwPaso2" runat="server">
            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong>Paso 2: Datos Personales</strong>
                        </h5>
                    </div>
                    <div class="card-body">

                        <!-- User Control para Asegurado -->
                        <uc:DatosPersonales ID="ucAsegurado" runat="server"
                            TipoPersona="ASEGURADO"
                            ValidationGroup="Paso2"
                            ValidacionHabilitada="true" />

                        <!-- Botones -->
                        <div class="row mt-4">
                            <div class="col-6">
                                <asp:Button ID="btnAnterior2" runat="server" Text="Atrás"
                                    CssClass="btn btn-outline-primary w-100"
                                    OnClick="btnAnteriorAsegurado_Click" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnSiguiente2" runat="server" Text="Siguiente"
                                    CssClass="btn btn-primary w-100"
                                    OnClick="btnSiguienteAsegurado_Click"
                                    ValidationGroup="Paso2" />
                            </div>
                        </div>

                    </div>
                </div>
            </section>
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
                                <asp:Button ID="btnAnteriorTomador" runat="server"
                                    Text="Atrás"
                                    CssClass="btn btn-outline-primary w-100"
                                    OnClick="btnAnteriorTomador_Click"
                                    CausesValidation="false" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnSiguienteTomador" runat="server"
                                    Text="Siguiente"
                                    CssClass="btn btn-primary w-100"
                                    OnClick="btnSiguienteTomador_Click"
                                    Enabled="false"
                                    ClientIDMode="Static" />
                            </div>
                        </div>

                    </div>
                </div>
            </section>
        </asp:View>
        <!-- Paso X - Beneficiarios -->
        <asp:View ID="vwBeneficiarios" runat="server">
            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong>BENEFICIARIOS</strong>
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
                            <button type="button" class="btn btn-primary btn-lg"
                                data-bs-toggle="modal" data-bs-target="#modalAgregarBeneficiario">
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
                                    OnRowEditing="gvBeneficiarios_RowEditing"
                                    Visible="false">
                                    <Columns>

                                        <asp:TemplateField HeaderText="#" HeaderStyle-Width="50px" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNumero" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="Nombre Completo">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNombreCompleto" runat="server"
                                                    Text='<%# Eval("NombreCompleto") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="Parentesco">
                                            <ItemTemplate>
                                                <asp:Label ID="lblParentesco" runat="server"
                                                    Text='<%# Eval("ParentescoNombre") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="Porcentaje" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <span class="badge bg-primary">
                                                    <asp:Label ID="lblPorcentaje" runat="server"
                                                        Text='<%# Eval("Porcentaje") + "%" %>'></asp:Label>
                                                </span>
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="Acciones" HeaderStyle-Width="120px" ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnEditarBeneficiario" runat="server"
                                                    CommandName="Edit"
                                                    CssClass="btn btn-sm btn-outline-primary me-1"
                                                    ToolTip="Editar">
                                            <i class="fas fa-edit"></i>
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnEliminarBeneficiario" runat="server"
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
                <div class="modal-dialog modal-lg">
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
                                    <!-- Tipo de Documento -->
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold">Tipo de Documento: <span class="text-danger">*</span></label>
                                        <asp:DropDownList ID="ddlTipoDocumentoBeneficiario" runat="server"
                                            CssClass="form-select"
                                            ClientIDMode="Static">
                                            <asp:ListItem Value="0" Text="Seleccione"></asp:ListItem>
                                            <asp:ListItem Value="CI" Text="Cédula de Identidad"></asp:ListItem>
                                            <asp:ListItem Value="PASAPORTE" Text="Pasaporte"></asp:ListItem>
                                            <asp:ListItem Value="NIT" Text="NIT"></asp:ListItem>
                                            <asp:ListItem Value="CE" Text="Cédula de Extranjería"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvTipoDocumentoBeneficiario" runat="server"
                                            ControlToValidate="ddlTipoDocumentoBeneficiario"
                                            InitialValue="0"
                                            ErrorMessage="Seleccione el tipo de documento"
                                            CssClass="small text-danger"
                                            Display="Dynamic"
                                            ValidationGroup="ModalBeneficiario" />
                                    </div>

                                    <!-- Número de Documento -->
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold">Número de Documento: <span class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtNumeroDocumentoBeneficiario" runat="server"
                                            CssClass="form-control"
                                            MaxLength="15"
                                            ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator ID="rfvNumeroDocumentoBeneficiario" runat="server"
                                            ControlToValidate="txtNumeroDocumentoBeneficiario"
                                            ErrorMessage="Ingrese el número de documento"
                                            CssClass="small text-danger"
                                            Display="Dynamic"
                                            ValidationGroup="ModalBeneficiario" />
                                    </div>

                                    <!-- Complemento (solo para NIT) -->
                                    <div class="col-md-6 mb-3" id="divComplementoBeneficiario" runat="server" visible="false">
                                        <label class="form-label fw-bold">Complemento:</label>
                                        <asp:TextBox ID="txtComplementoBeneficiario" runat="server"
                                            CssClass="form-control"
                                            MaxLength="3"
                                            ClientIDMode="Static" />
                                    </div>

                                    <!-- Nombre Completo -->
                                    <div class="col-md-12 mb-3">
                                        <label class="form-label fw-bold">Nombre Completo: <span class="text-danger">*</span></label>
                                        <asp:TextBox ID="txtNombreCompletoBeneficiario" runat="server"
                                            CssClass="form-control"
                                            placeholder="Ingrese nombre completo"
                                            MaxLength="100"
                                            ClientIDMode="Static" />
                                        <asp:RequiredFieldValidator ID="rfvNombreCompletoBeneficiario" runat="server"
                                            ControlToValidate="txtNombreCompletoBeneficiario"
                                            ErrorMessage="Ingrese el nombre completo"
                                            CssClass="small text-danger"
                                            Display="Dynamic"
                                            ValidationGroup="ModalBeneficiario" />
                                    </div>

                                    <!-- Parentesco -->
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold">Parentesco: <span class="text-danger">*</span></label>
                                        <asp:DropDownList ID="ddlParentesco" runat="server"
                                            CssClass="form-select"
                                            ClientIDMode="Static">
                                            <asp:ListItem Value="0" Text="Seleccione"></asp:ListItem>
                                            <asp:ListItem Value="C" Text="Cónyuge"></asp:ListItem>
                                            <asp:ListItem Value="H" Text="Hijo(a)"></asp:ListItem>
                                            <asp:ListItem Value="P" Text="Padre/Madre"></asp:ListItem>
                                            <asp:ListItem Value="H" Text="Hermano(a)"></asp:ListItem>
                                            <asp:ListItem Value="O" Text="Otro"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvParentesco" runat="server"
                                            ControlToValidate="ddlParentesco"
                                            InitialValue="0"
                                            ErrorMessage="Seleccione el parentesco"
                                            CssClass="small text-danger"
                                            Display="Dynamic"
                                            ValidationGroup="ModalBeneficiario" />
                                    </div>

                                    <!-- Porcentaje -->
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label fw-bold">Porcentaje (%): <span class="text-danger">*</span></label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtPorcentaje" runat="server"
                                                CssClass="form-control"
                                                TextMode="Number"
                                                min="1"
                                                max="100"
                                                ClientIDMode="Static" />
                                            <span class="input-group-text">%</span>
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
                                    </div>

                                    <!-- Observaciones -->
                                    <div class="col-md-12 mb-3">
                                        <label class="form-label fw-bold">Observaciones:</label>
                                        <asp:TextBox ID="txtObservaciones" runat="server"
                                            CssClass="form-control"
                                            TextMode="MultiLine"
                                            Rows="3"
                                            placeholder="Observaciones adicionales (opcional)"
                                            MaxLength="500"
                                            ClientIDMode="Static" />
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
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
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
        <asp:View ID="View1" runat="server">
            <asp:Panel ID="panelPaso3" runat="server" DefaultButton="btnObtenerQr">
                <section class="mb-4">
                    <div class="card">
                        <div class="card-header text-center py-3">
                            <h5 class="mb-0 text-center">
                                <strong>Datos de facturación <span id="spanIdentificador" runat="server"></span></strong>
                            </h5>
                        </div>
                        <div class="card-body">
                            <!-- Precio del SOAT -->
                            <div class="card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between p-md-1">
                                        <div class="d-flex flex-row">
                                            <div class="align-self-center">
                                                <span id="spanVehiculo" runat="server"></span>
                                            </div>
                                            <div>
                                                <h4>SOAT <span id="spanGestion" runat="server"></span></h4>
                                                <p class="mb-0"><span id="spanDepartamento" runat="server"></span>- Bolivia</p>
                                            </div>
                                        </div>
                                        <div class="align-self-center">
                                            <h2 class="h1 mb-0">Bs.<span id="spanPrima" runat="server"></span></h2>
                                        </div>
                                    </div>
                                </div>
                            </div>

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
                                    ValidationGroup="Paso3" />
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
                                ValidationGroup="Paso3" />
                            <asp:RegularExpressionValidator ID="revNumeroDocumento" runat="server"
                                ControlToValidate="txtNumeroDocumento"
                                ValidationExpression="^\d+$"
                                ErrorMessage="Solo se permiten números."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="Paso3" />
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
                                ValidationGroup="Paso3" />

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
                                ValidationGroup="Paso3" />
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
                                ValidationGroup="Paso3" />

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
                                ValidationGroup="Paso3" />

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
                                ControlToValidate="txtCelular"
                                InitialValue=""
                                ErrorMessage="Número de celular requerido."
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="Paso3" />
                            <ajaxToolkit:FilteredTextBoxExtender ID="ftbCelular" runat="server" TargetControlID="txtCelular" FilterType="Numbers" />


                            <!-- Botones -->
                            <div class="row mt-4">
                                <div class="col-6">
                                    <asp:Button ID="Button1" runat="server" Text="Anterior" CssClass="btn btn-secondary w-100" CausesValidation="false" />
                                </div>
                                <div class="col-6">
                                    <asp:Button ID="btnObtenerQr" runat="server" Text="Generar QR" CssClass="btn btn-success w-100 btn-loading" ValidationGroup="Paso3" />
                                </div>
                            </div>
                        </div>






                    </div>
                </section>
            </asp:Panel>

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

            // Atajos de teclado
            $(document).keydown(function (e) {
                // 1 = Sí, 2 = No
                if (e.which === 49) { // Tecla 1
                    $('#rbTomadorDiferenteSi').click();
                    e.preventDefault();
                } else if (e.which === 50) { // Tecla 2
                    $('#rbTomadorDiferenteNo').click();
                    e.preventDefault();
                } else if (e.which === 13 && !$('#btnSiguienteTomador').prop('disabled')) { // Enter
                    $('#btnSiguienteTomador').click();
                    e.preventDefault();
                }
            });
        });

        // Función para mostrar notificaciones
        function showNotification(type, message) {
            // Usar Toastr o similar
            if (typeof toastr !== 'undefined') {
                switch (type) {
                    case 'success':
                        toastr.success(message);
                        break;
                    case 'warning':
                        toastr.warning(message);
                        break;
                    case 'error':
                    case 'danger':
                        toastr.error(message);
                        break;
                    default:
                        toastr.info(message);
                }
            } else {
                alert(message);
            }
        }
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
    </style>
</asp:Content>
