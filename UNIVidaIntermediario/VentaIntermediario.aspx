<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VentaIntermediario.aspx.cs" Inherits="UNIVidaIntermediario.VentaIntermediario" %>
<%@ Register Src="~/UCDatosPersonales.ascx" TagPrefix="uc" TagName="DatosPersonales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:MultiView ID="mvFormulario" runat="server" ActiveViewIndex="1">

        <!-- Paso 1 - Buscar Asegurado -->
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
                                    <h6 class="mb-1 fw-bold">Ingrese los datos del asegurado</h6>
                                    <p class="mb-0 small text-muted">Complete los siguientes campos para buscar o registrar al asegurado</p>
                                </div>
                            </div>
                        </div>

                        <!-- Tipo de documento -->
                        <div class="mb-4" style="position: relative;">
                            <asp:DropDownList ID="ddlTipoDocumentoBuscar" runat="server"
                                CssClass="form-control form-control-lg"
                                ClientIDMode="Static"
                                OnSelectedIndexChanged="ddlTipoDocumentoBuscar_SelectedIndexChanged"
                                AutoPostBack="true">
                                <asp:ListItem Value="0" Text="Seleccione tipo de documento"></asp:ListItem>
                                <asp:ListItem Value="CI" Text="Cédula de Identidad"></asp:ListItem>
                                <asp:ListItem Value="PASAPORTE" Text="Pasaporte"></asp:ListItem>
                                <asp:ListItem Value="NIT" Text="NIT"></asp:ListItem>
                                <asp:ListItem Value="CE" Text="Cédula de Extranjería"></asp:ListItem>
                            </asp:DropDownList>
                            <label class="form-label" for="ddlTipoDocumentoBuscar"
                                style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                Tipo de documento
                            </label>
                            <asp:RequiredFieldValidator ID="rfvTipoDocumentoBuscar" runat="server"
                                ControlToValidate="ddlTipoDocumentoBuscar"
                                InitialValue="0"
                                ErrorMessage="Seleccione el tipo de documento"
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="BuscarAsegurado" />
                        </div>

                        <!-- Número de documento -->
                        <div class="mb-4" style="position: relative;">
                            <div class="input-group input-group-lg">
                                <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                                <asp:TextBox ID="txtNumeroDocumentoBuscar" runat="server"
                                    CssClass="form-control form-control-lg text-center"
                                    ClientIDMode="Static"
                                    placeholder="Ingrese número de documento"
                                    MaxLength="15">
                                </asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="rfvNumeroDocumentoBuscar" runat="server"
                                ControlToValidate="txtNumeroDocumentoBuscar"
                                ErrorMessage="Ingrese el número de documento"
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="BuscarAsegurado" />

                            <!-- Validadores según tipo de documento -->
                            <asp:RegularExpressionValidator ID="revCedula" runat="server"
                                ControlToValidate="txtNumeroDocumentoBuscar"
                                ValidationExpression="^[0-9]{7,8}$"
                                ErrorMessage="La cédula debe tener 7 u 8 dígitos"
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="BuscarAsegurado"
                                Enabled="false" />

                            <asp:RegularExpressionValidator ID="revPasaporte" runat="server"
                                ControlToValidate="txtNumeroDocumentoBuscar"
                                ValidationExpression="^[A-Z0-9]{5,15}$"
                                ErrorMessage="Formato de pasaporte inválido"
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="BuscarAsegurado"
                                Enabled="false" />

                            <ajaxToolkit:FilteredTextBoxExtender
                                ID="ftbeNumeroDocumentoBuscar"
                                runat="server"
                                TargetControlID="txtNumeroDocumentoBuscar"
                                FilterType="Custom, Numbers, UppercaseLetters"
                                ValidChars=""
                                FilterMode="ValidChars" />
                        </div>

                        <!-- Complemento (solo para NIT) -->
                        <div class="mb-4" style="position: relative;" id="divComplementoBuscar" runat="server" visible="false">
                            <div class="input-group input-group-lg">
                                <span class="input-group-text"><i class="fas fa-plus-circle"></i></span>
                                <asp:TextBox ID="txtComplementoBuscar" runat="server"
                                    CssClass="form-control form-control-lg text-center"
                                    ClientIDMode="Static"
                                    placeholder="Opcional"
                                    MaxLength="3">
                                </asp:TextBox>
                                <span class="input-group-text bg-light text-muted small">Opcional</span>
                            </div>
                            <asp:RegularExpressionValidator ID="revComplemento" runat="server"
                                ControlToValidate="txtComplementoBuscar"
                                ValidationExpression="^[0-9A-Z]{0,3}$"
                                ErrorMessage="Máximo 3 caracteres alfanuméricos"
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="BuscarAsegurado" />

                            <ajaxToolkit:FilteredTextBoxExtender
                                ID="ftbeComplementoBuscar"
                                runat="server"
                                TargetControlID="txtComplementoBuscar"
                                FilterType="Custom, Numbers, UppercaseLetters"
                                ValidChars=""
                                FilterMode="ValidChars" />
                        </div>

                        <!-- Departamento de expedición -->
                        <div class="mb-4" style="position: relative;">
                            <asp:DropDownList ID="ddlDepartamentoExpedicion" runat="server"
                                CssClass="form-control form-control-lg"
                                ClientIDMode="Static">
                                <asp:ListItem Value="0" Text="Seleccione departamento"></asp:ListItem>
                                <asp:ListItem Value="LP" Text="La Paz"></asp:ListItem>
                                <asp:ListItem Value="CB" Text="Cochabamba"></asp:ListItem>
                                <asp:ListItem Value="SC" Text="Santa Cruz"></asp:ListItem>
                                <asp:ListItem Value="OR" Text="Oruro"></asp:ListItem>
                                <asp:ListItem Value="PT" Text="Potosí"></asp:ListItem>
                                <asp:ListItem Value="TJ" Text="Tarija"></asp:ListItem>
                                <asp:ListItem Value="CH" Text="Chuquisaca"></asp:ListItem>
                                <asp:ListItem Value="BE" Text="Beni"></asp:ListItem>
                                <asp:ListItem Value="PD" Text="Pando"></asp:ListItem>
                            </asp:DropDownList>
                            <label class="form-label" for="ddlDepartamentoExpedicion"
                                style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                Departamento de expedición
                            </label>
                            <asp:RequiredFieldValidator ID="rfvDepartamentoExpedicion" runat="server"
                                ControlToValidate="ddlDepartamentoExpedicion"
                                InitialValue="0"
                                ErrorMessage="Seleccione el departamento de expedición"
                                CssClass="small text-danger"
                                Display="Dynamic"
                                ValidationGroup="BuscarAsegurado" />
                        </div>

                        <!-- Mensajes de error/success -->
                        <asp:Panel ID="pnlMensajeAsegurado" runat="server" Visible="false" CssClass="mt-3">
                            <div class="alert alert-dismissible fade show" role="alert">
                                <asp:Label ID="lblMensajeAsegurado" runat="server"></asp:Label>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </asp:Panel>

                        <!-- Botones de acción -->
                        <div class="row mt-5">
                            <div class="col-12">
                                <asp:Button ID="btnBuscarAsegurado" runat="server"
                                    Text="Buscar Asegurado"
                                    CssClass="btn btn-primary w-100 btn-lg"
                                    OnClick="btnBuscarAsegurado_Click"
                                    ValidationGroup="BuscarAsegurado" />
                            </div>
                        </div>

                        <!-- Resultados de búsqueda (si se encuentra) -->
                        <asp:Panel ID="pnlResultadoBusqueda" runat="server" Visible="false" CssClass="mt-4">
                            <div class="card border-success">
                                <div class="card-header bg-success text-white">
                                    <h6 class="mb-0"><i class="fas fa-user-check me-2"></i>Asegurado Encontrado</h6>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label small text-muted">Nombre completo</label>
                                                <p class="fs-5 fw-bold" id="lblNombreAsegurado" runat="server"></p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label small text-muted">Correo electrónico</label>
                                                <p class="fs-5" id="lblCorreoAsegurado" runat="server"></p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label small text-muted">Celular</label>
                                                <p class="fs-5" id="lblCelularAsegurado" runat="server"></p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label class="form-label small text-muted">Dirección</label>
                                                <p class="fs-5" id="lblDireccionAsegurado" runat="server"></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center mt-3">
                                        <asp:Button ID="btnContinuarConAsegurado" runat="server"
                                            Text="Continuar con este asegurado"
                                            CssClass="btn btn-success"
                                            OnClick="btnContinuarConAsegurado_Click" />
                                        <asp:Button ID="btnBuscarOtro" runat="server"
                                            Text="Buscar otro"
                                            CssClass="btn btn-outline-secondary ms-2"
                                            OnClick="btnBuscarOtro_Click"
                                            CausesValidation="false" />
                                    </div>
                                </div>
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
                        <uc:DatosPersonales id="ucAsegurado" runat="server"
                            tipopersona="ASEGURADO"
                            validationgroup="Paso2"
                            validacionhabilitada="true" />

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
    </asp:MultiView>


</asp:Content>
