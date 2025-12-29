<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Venta1.aspx.cs" Inherits="UNIVidaIntermediario.Venta1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        #MainContent_spanIdentificador {
            color: #c20538
        }
    </style>
    <asp:HiddenField ID="hfCodigoUnico" runat="server" />
    <asp:HiddenField ID="hfVentaVendedor" runat="server" Value="prueba" />
    <asp:HiddenField ID="hfSucursal" runat="server" Value="prueba" />
    <asp:HiddenField ID="hfSecuencialPago" runat="server" />
    <asp:HiddenField ID="hfTVehiSoatPropFk" runat="server" />

    <asp:MultiView ID="mvFormulario" runat="server" ActiveViewIndex="0">
        <!-- Paso 1 -->
        <asp:View ID="vwPaso1" runat="server">

            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong>Venta nueva o renovación</strong>
                        </h5>
                    </div>
                    <div class="card-body">



                        <div class="mb-4" style="position: relative;">
                            <asp:DropDownList ID="ddlTipoIdentificacion" runat="server" CssClass="form-control form-control-lg" ClientIDMode="Static">
                            </asp:DropDownList>
                            <label class="form-label" for="ddlTipoIdentificacion" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                Tipo de Identificación
                            </label>
                        </div>
                        <div class="mb-4" style="position: relative;" id="divGestion" runat="server">
                            <asp:DropDownList ID="ddlGestion" runat="server" CssClass="form-control form-control-lg" ClientIDMode="Static">
                            </asp:DropDownList>
                            <label class="form-label" for="ddlGestion" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                Gestión soat
                            </label>
                        </div>
                        <div class="row mb-4">
                            <div class="col">

                                <div class="input-group input-group-lg">
                                    <span class="input-group-text fs-4"><i class="fas fa-car"></i></span>
                                    <asp:TextBox ID="txtItentificador" MaxLength="20" runat="server" CssClass="form-control text-uppercase text-center fs-4" ClientIDMode="Static" ValidationGroup="Paso1" CausesValidation="true" />
                                    <ajaxToolkit:FilteredTextBoxExtender
                                        ID="ftbeCleanText"
                                        runat="server"
                                        TargetControlID="txtItentificador"
                                        FilterType="Custom, Numbers, LowercaseLetters, UppercaseLetters"
                                        ValidChars=" -._@<>+=() "
                                        FilterMode="ValidChars" />
                                </div>
                                <asp:RequiredFieldValidator ID="rfvFulArchivoReversion" runat="server" ErrorMessage="Campo obligatorio" ControlToValidate="txtItentificador" class="small text-danger" Display="Dynamic" ValidationGroup="Paso1"></asp:RequiredFieldValidator>

                            </div>
                        </div>
                        <%-- <div class="alert alert-danger text-center animate__animated animate__headShake" role="alert" id="divMensaje" runat="server" visible="false">
                        </div>--%>
                        <div class="text-center py-5" id="divMensaje" runat="server" visible="false">
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


                        <div class="text-center mt-4">
                            <asp:LinkButton ID="btnSiguiente1" runat="server" CssClass="btn btn-primary d-flex align-items-center justify-content-center gap-2"
                                OnClick="btnSiguiente1_Click"
                                ValidationGroup="Paso1"
                                CausesValidation="true">
    <lord-icon src="https://cdn.lordicon.com/hoetzosy.json" trigger="hover" colors="primary:#ffffff" style="width:20px; height:20px;">
    </lord-icon>
    Buscar
                            </asp:LinkButton>

                        </div>

                    </div>
                </div>
            </section>


        </asp:View>

        <!-- Paso 2 -->
        <asp:View ID="vwPaso2" runat="server">

            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong id="tituloVentaNuevaRenovacion" runat="server"></strong>
                        </h5>
                    </div>
                    <div class="card-body">

                        <!-- Tipo de vehículo -->
                        <div class="mb-4" style="position: relative;">
                            <asp:DropDownList ID="ddlTipoVehiculo" runat="server" CssClass="form-control form-control-lg" ClientIDMode="Static">
                            </asp:DropDownList>
                            <label class="form-label" for="ddlTipoVehiculo" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                Tipo de Vehículo
                            </label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" InitialValue="0" ErrorMessage="Seleccione el tipo de vehículo" ControlToValidate="ddlTipoVehiculo" class="small text-danger" Display="Dynamic" ValidationGroup="Paso2"></asp:RequiredFieldValidator>

                        </div>

                        <!-- Plaza de circulación -->
                        <div class="mb-4" style="position: relative;">
                            <asp:DropDownList ID="ddlPlazaCirculacion" runat="server" CssClass="form-control form-control-lg" ClientIDMode="Static">
                            </asp:DropDownList>
                            <label class="form-label" for="ddlPlazaCirculacion" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                Plaza de Circulación
                            </label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" InitialValue="0" ErrorMessage="Seleccione la plaza de circulación" ControlToValidate="ddlPlazaCirculacion" class="small text-danger" Display="Dynamic" ValidationGroup="Paso2"></asp:RequiredFieldValidator>

                        </div>

                        <!-- Tipo de uso -->
                        <div class="mb-4" style="position: relative;">
                            <asp:DropDownList ID="ddlTipoUso" runat="server" CssClass="form-control form-control-lg" ClientIDMode="Static">
                            </asp:DropDownList>
                            <label class="form-label" for="ddlTipoUso" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                                Tipo de Uso
                            </label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" InitialValue="0" ErrorMessage="Seleccione el tipo de uso" ControlToValidate="ddlTipoUso" class="small text-danger" Display="Dynamic" ValidationGroup="Paso2"></asp:RequiredFieldValidator>

                        </div>
                        <div class="row mt-4">
                            <div class="col-6">
                                <asp:Button ID="btnAnterior1" runat="server" Text="Anterior" CssClass="btn btn-secondary w-100" OnClick="btnAnterior1_Click" CausesValidation="false" />
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnSiguiente2" runat="server" Text="Siguiente" CssClass="btn btn-primary w-100" OnClick="btnSiguiente2_Click" ValidationGroup="Paso2" />
                            </div>
                        </div>


                    </div>
                </div>
            </section>


        </asp:View>

        <!-- Paso 3 -->
        <asp:View ID="vwPaso3" runat="server">
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

                                <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="form-control form-control-lg" ClientIDMode="Static" OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged" AutoPostBack="true">
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
                                    <asp:Button ID="btnAnterior2" runat="server" Text="Anterior" CssClass="btn btn-secondary w-100" OnClick="btnAnterior2_Click" CausesValidation="false" />
                                </div>
                                <div class="col-6">
                                    <asp:Button ID="btnObtenerQr" runat="server" Text="Generar QR" CssClass="btn btn-success w-100 btn-loading" OnClick="btnObtenerQr_Click" ValidationGroup="Paso3" />
                                </div>
                            </div>
                        </div>






                    </div>
                </section>
            </asp:Panel>

        </asp:View>
        <!-- Paso 4 -->
        <asp:View ID="vwPaso4" runat="server">
            <section class="mb-4">
                <div class="card">
                    <div class="card-header text-center py-3">
                        <h5 class="mb-0 text-center">
                            <strong>QR Para el pago de SOAT</strong>
                        </h5>
                    </div>
                    <div class="card-body">

                        <div class="row align-items-center">
                            <!-- Columna izquierda: Datos del vehículo -->
                            <div class="col-12 col-md-6 mb-4 mb-md-0">
                                <div class="d-flex flex-column align-items-center align-items-md-start text-center text-md-start fs-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <h1><span class="ms-2 text-dark fw-semibold text-uppercase" id="spanPlaca" runat="server"></span></h1>
                                    </div>
                                    <div class="d-flex align-items-center mb-1">
                                        <i class="fas fa-user-shield fa-sm text-primary me-2"></i>
                                        <span class="fw-semibold">Tipo de Uso:</span>
                                        <span class="ms-2 text-dark" id="spanTipoUsoVenta" runat="server"></span>
                                    </div>
                                    <div class="d-flex align-items-center mb-1">
                                        <i class="fas fa-motorcycle fa-sm text-success me-2"></i>
                                        <span class="fw-semibold">Tipo de Vehículo:</span>
                                        <span class="ms-2 text-dark" id="spanTipoVehiculoVenta" runat="server"></span>
                                    </div>
                                    <div class="d-flex align-items-center mb-1">
                                        <i class="fas fa-map-marker-alt fa-sm text-warning me-2"></i>
                                        <span class="fw-semibold">Departamento:</span>
                                        <span class="ms-2 text-dark" id="spanDepartamentoVenta" runat="server"></span>
                                    </div>
                                    <div class="d-flex align-items-center mb-1">
                                        <i class="fas fa-calendar-alt fa-sm text-info me-2"></i>
                                        <span class="fw-semibold">Gestión:</span>
                                        <span class="ms-2 text-dark" id="spanGestionVenta" runat="server"></span>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-money-bill-wave fa-sm text-danger me-2"></i>
                                        <span class="fw-semibold">Prima:</span>
                                        &nbsp;Bs.<span class="ms-2 text-dark" id="spanPrimaVenta" runat="server"></span>
                                    </div>
                                </div>
                            </div>

                            <!-- Columna derecha: QR -->
                            <div class="col-12 col-md-6 text-center">
                                <img src="" style="max-width: 320px" class="img-fluid mb-3" runat="server" id="imagenQr" />
                            </div>
                        </div>

                        <hr />

                        <!-- Botones -->
                        <div class="row mt-4">
                            <div class="col-6">
                                <button type="button" class="btn btn-primary w-100" id="btnConsultarPago">Consultar Pago</button>
                            </div>
                            <div class="col-6">
                                <asp:Button ID="btnAnularQr" runat="server" Text="Anular QR" CssClass="btn btn-danger w-100" OnClick="btnAnularQr_Click" />
                            </div>
                        </div>

                    </div>
                </div>
            </section>
        </asp:View>

        <!-- Paso 5 -->
        <asp:View ID="vwPaso5" runat="server">
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
                                <asp:Button ID="btnInicio" runat="server" Text="Iniciar nueva venta" CssClass="btn btn-success w-100" OnClick="btnInicio_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </asp:View>
    </asp:MultiView>
    <!-- Modal QR Pagado -->

    <div class="modal fade" id="modalQrPagado" tabindex="-1" aria-labelledby="modalQrPagadoLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg rounded-4">
                <div class="modal-header text-white  py-3 px-4" style="background: linear-gradient(135deg, #0d6efd, #6610f2);">
                    <h5 class="modal-title fw-bold" id="modalQrPagadoLabel">Pagar con QR</h5>
                </div>

                <!-- Cuerpo -->
                <div class="modal-body text-center py-5 px-4">

                    <!-- Mensaje -->
                    <h5 id="mensajePago" class="text-primary fw-semibold mb-4">Escanee el código QR para completar el pago
                    </h5>

                    <!-- Spinner -->
                    <div id="loadingContainer" class="d-flex flex-column align-items-center mb-4">
                        <div class="spinner-border text-primary mb-3" role="status" style="width: 3rem; height: 3rem;">
                            <span class="visually-hidden">Cargando...</span>
                        </div>
                        <div id="loadingText" class="text-muted small">Procesando datos, por favor espere...</div>
                    </div>

                    <!-- Respuesta -->
                    <div id="respuestaMensaje" class="text-success fw-bold" style="min-height: 24px;"></div>
                </div>

            </div>
        </div>
    </div>



    <script>
        function limitLength(input) {
            if (input.value.length > 10) {
                input.value = input.value.slice(0, 10);
            }
        }
        $("#btnConsultarPago").on("click", function (e) {
            e.preventDefault();

            var objeto = {
                codigoUnico: $("#MainContent_hfCodigoUnico").val(),
                ventaVendedor: $("#MainContent_hfVentaVendedor").val(),
                sucursal: $("#MainContent_hfSucursal").val()
            };

            const OnSuccessConsultarPago = (response) => {
                var jsonResponse = JSON.parse(response.d);
                if (jsonResponse !== "") {
                    if (jsonResponse.Exito) {
                        console.log(jsonResponse)
                        if (jsonResponse.oSDatos.EstadoSecuencial == 3) {

                            $("#mensajePago").html(jsonResponse.Mensaje);
                            $('#modalQrPagado').modal('show');
                            $("#MainContent_hfSecuencialPago").val(jsonResponse.oSDatos.Secuencial);
                            consultarEfectivizacion();


                        } else {
                            showNotification("info", jsonResponse.Mensaje.toUpperCase())
                        }
                    } else {
                        showNotification("info", jsonResponse.Mensaje.toUpperCase())
                    }
                } else {
                    showNotification("error", "Ocurrió un problema con la verificación, intente nuevamente.")
                }
            };
            ajaxRequest("Venta.aspx/JSConsultarPago", objeto, OnSuccessConsultarPago);
        });
        function consultarEfectivizacion() {
            const intervalId = setInterval(() => {

                const objetoVerificacion = {
                    secuencial: $("#MainContent_hfSecuencialPago").val(),
                    ventaVendedor: $("#MainContent_hfVentaVendedor").val(),
                    sucursal: $("#MainContent_hfSucursal").val()
                };
                const OnSuccessEfectivizado = (response) => {
                    var jsonResponse = JSON.parse(response.d);
                    if (jsonResponse.Exito) {

                        $("#respuestaMensaje").html(jsonResponse.oSDatos.Mensaje)
                        if (jsonResponse.oSDatos.TParSimpleEestadoSolicitudEjecucionFk == 2) {
                            clearInterval(intervalId);
                            $("#MainContent_hfTVehiSoatPropFk").val(jsonResponse.oSDatos.TVehiSoatPropFk)
                            $('#modalQrPagado').modal('hide');

                            setInterval(function () {
                                __doPostBack('AperturarPasoDocumento');
                            }, 1000);

                        }
                    } else {
                        swalError("Error", jsonResponse.Mensaje);
                    }
                }
                ajaxRequest("Venta.aspx/JSConsultarEfectivizacion", objetoVerificacion, OnSuccessEfectivizado, false);
            }, 5000);
        }
        function notificarExito(mensaje) {
            swal({
                title: 'Finalizado',
                text: mensaje,
                type: 'success',
                confirmButtonText: 'Aceptar',
                allowOutsideClick: false,
                allowEscapeKey: false,
            }).then(function () {
                window.location.href = 'Venta.aspx';
            });
        }

        document.addEventListener("DOMContentLoaded", function () {
            var input = document.getElementById("txtNumeroDocumento");
            input.addEventListener("input", function () {
                // corta si se pasa de 10 caracteres
                if (this.value.length > 10) {
                    this.value = this.value.slice(0, 10);
                }
            });
        });
        document.getElementById("txtItentificador").addEventListener("keydown", function (e) {
            if (e.key === "Enter") {
                e.preventDefault();
                document.getElementById("btnSiguiente1").click();
            }
        });

        function validateCelular(sender, args) {
            var celular = args.Value;  // Obtener el valor ingresado en el campo txtCelular

            // Validar que el número comience con un 6 o un 7
            if (celular.startsWith("6") || celular.startsWith("7")) {
                // Validar que el número tenga exactamente 8 dígitos
                if (celular.length === 8) {
                    args.IsValid = true;  // Si pasa la validación, es válido
                } else {
                    args.IsValid = false;  // Si no tiene 8 dígitos, es inválido
                    args.ErrorMessage = "El número de celular debe tener exactamente 8 dígitos.";
                }
            } else {
                args.IsValid = false;  // Si no comienza con 6 o 7, es inválido
                args.ErrorMessage = "El número de celular debe comenzar con un 6 o un 7.";
            }
        }
    </script>

</asp:Content>
