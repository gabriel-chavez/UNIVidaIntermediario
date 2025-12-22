<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UCDatosPersonales.ascx.cs" Inherits="UNIVidaIntermediario.UCDatosPersonales" %>

<asp:HiddenField ID="hfTipoPersona" runat="server" />
<asp:HiddenField ID="hfModoLectura" runat="server" Value="false" />

<div class="datos-personales-form" id="datosPersonalesContainer" runat="server">
    
    <!-- Título dinámico -->
    <div class="text-center mb-4">
        <h5 class="mb-0">
            <strong>
                <asp:Literal ID="ltlTitulo" runat="server"></asp:Literal>
                <span id="spanIdentificadorPersona" runat="server"></span>
            </strong>
        </h5>
        <p class="text-muted mb-0">
            <asp:Literal ID="ltlSubtitulo" runat="server"></asp:Literal>
        </p>
    </div>

    <!-- Datos del Documento en 2 columnas -->
    <div class="row">
        <!-- Columna izquierda -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;">
                <asp:TextBox ID="txtTipoDocumento" runat="server" 
                    CssClass="form-control form-control-lg" 
                    ReadOnly="true"
                    placeholder="-" />
                <label class="form-label" for="<%= txtTipoDocumento.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Tipo de Documento
                </label>
            </div>
        </div>
        
        <!-- Columna derecha -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;">
                <asp:TextBox ID="txtNumeroDocumento" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    ReadOnly="true"
                    placeholder="-" />
                <label class="form-label" for="<%= txtNumeroDocumento.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Número de Documento
                </label>
            </div>
        </div>
    </div>

    <!-- Segunda fila para complemento y departamento -->
    <div class="row">
        <!-- Complemento -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;" id="divComplementoContainer" runat="server" visible="false">
                <asp:TextBox ID="txtComplemento" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    ReadOnly="true"
                    MaxLength="5"
                    placeholder="-" />
                <label class="form-label" for="<%= txtComplemento.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Complemento
                </label>
            </div>
        </div>
        
        <!-- Departamento -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;">
                <asp:TextBox ID="txtDeptoExpedicion" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    ReadOnly="true"
                    placeholder="-" />
                <label class="form-label" for="<%= txtDeptoExpedicion.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Departamento de Documento
                </label>
            </div>
        </div>
    </div>

    <!-- Separador visual -->
    <hr class="my-4" />

    <!-- Fila 1: Apellidos -->
    <div class="row">
        <!-- Apellido Paterno -->
        <div class="col-md-6">
            <div data-mdb-input-init class="form-outline mb-3">
                <asp:TextBox ID="txtApellidoPaterno" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    placeholder=" "
                    MaxLength="50"
                    ClientIDMode="Static" />
                <label class="form-label" for="<%= txtApellidoPaterno.ClientID %>">Apellido Paterno <span class="text-danger">*</span></label>
            </div>
            <asp:RequiredFieldValidator ID="rfvApellidoPaterno" runat="server"
                ControlToValidate="txtApellidoPaterno"
                ErrorMessage="Apellido paterno requerido."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
            <ajaxToolkit:FilteredTextBoxExtender 
                ID="ftbeApellidoPaterno" 
                runat="server"
                TargetControlID="txtApellidoPaterno"
                FilterType="Custom, UppercaseLetters, LowercaseLetters"
                ValidChars=" -'"
                FilterMode="ValidChars" />
        </div>
        
        <!-- Apellido Materno -->
        <div class="col-md-6">
            <div data-mdb-input-init class="form-outline mb-3">
                <asp:TextBox ID="txtApellidoMaterno" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    placeholder=" "
                    MaxLength="50"
                    ClientIDMode="Static" />
                <label class="form-label" for="<%= txtApellidoMaterno.ClientID %>">Apellido Materno <span class="text-danger">*</span></label>
            </div>
            <asp:RequiredFieldValidator ID="rfvApellidoMaterno" runat="server"
                ControlToValidate="txtApellidoMaterno"
                ErrorMessage="Apellido materno requerido."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
            <ajaxToolkit:FilteredTextBoxExtender 
                ID="ftbeApellidoMaterno" 
                runat="server"
                TargetControlID="txtApellidoMaterno"
                FilterType="Custom, UppercaseLetters, LowercaseLetters"
                ValidChars=" -'"
                FilterMode="ValidChars" />
        </div>
    </div>

    <!-- Fila 2: Apellido Casada y Primer Nombre -->
    <div class="row">
        <!-- Apellido Casada/Viuda -->
        <div class="col-md-6">
            <div data-mdb-input-init class="form-outline mb-3">
                <asp:TextBox ID="txtApellidoCasada" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    placeholder=" "
                    MaxLength="50"
                    ClientIDMode="Static" />
                <label class="form-label" for="<%= txtApellidoCasada.ClientID %>">Apellido Casada/Viuda</label>
            </div>
            <ajaxToolkit:FilteredTextBoxExtender 
                ID="ftbeApellidoCasada" 
                runat="server"
                TargetControlID="txtApellidoCasada"
                FilterType="Custom, UppercaseLetters, LowercaseLetters"
                ValidChars=" -'"
                FilterMode="ValidChars" />
        </div>
        
        <!-- Primer Nombre -->
        <div class="col-md-6">
            <div data-mdb-input-init class="form-outline mb-3">
                <asp:TextBox ID="txtPrimerNombre" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    placeholder=" "
                    MaxLength="50"
                    ClientIDMode="Static" />
                <label class="form-label" for="<%= txtPrimerNombre.ClientID %>">Primer Nombre <span class="text-danger">*</span></label>
            </div>
            <asp:RequiredFieldValidator ID="rfvPrimerNombre" runat="server"
                ControlToValidate="txtPrimerNombre"
                ErrorMessage="Primer nombre requerido."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
            <ajaxToolkit:FilteredTextBoxExtender 
                ID="ftbePrimerNombre" 
                runat="server"
                TargetControlID="txtPrimerNombre"
                FilterType="Custom, UppercaseLetters, LowercaseLetters"
                ValidChars=" -'"
                FilterMode="ValidChars" />
        </div>
    </div>

    <!-- Fila 3: Segundo Nombre y Fecha Nacimiento -->
    <div class="row">
        <!-- Segundo Nombre -->
        <div class="col-md-6">
            <div data-mdb-input-init class="form-outline mb-3">
                <asp:TextBox ID="txtSegundoNombre" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    placeholder=" "
                    MaxLength="50"
                    ClientIDMode="Static" />
                <label class="form-label" for="<%= txtSegundoNombre.ClientID %>">Segundo Nombre</label>
            </div>
            <ajaxToolkit:FilteredTextBoxExtender 
                ID="ftbeSegundoNombre" 
                runat="server"
                TargetControlID="txtSegundoNombre"
                FilterType="Custom, UppercaseLetters, LowercaseLetters"
                ValidChars=" -'"
                FilterMode="ValidChars" />
        </div>
        
        <!-- Fecha de Nacimiento -->
        <div class="col-md-6">
            <div data-mdb-input-init class="form-outline mb-3">
                <asp:TextBox ID="txtFechaNacimiento" runat="server" 
                    CssClass="form-control form-control-lg" 
                    placeholder=" "
                    MaxLength="10"
                    ClientIDMode="Static" />
                <label class="form-label" for="<%= txtFechaNacimiento.ClientID %>">Fecha de Nacimiento (DD/MM/AAAA) <span class="text-danger">*</span></label>
            </div>
            <asp:RequiredFieldValidator ID="rfvFechaNacimiento" runat="server"
                ControlToValidate="txtFechaNacimiento"
                ErrorMessage="Fecha de nacimiento requerida."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
            <asp:RegularExpressionValidator ID="revFechaNacimiento" runat="server"
                ControlToValidate="txtFechaNacimiento"
                ValidationExpression="^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$"
                ErrorMessage="Formato DD/MM/AAAA."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
            <ajaxToolkit:CalendarExtender 
                ID="ceFechaNacimiento" 
                runat="server"
                TargetControlID="txtFechaNacimiento"
                Format="dd/MM/yyyy" />
            <ajaxToolkit:FilteredTextBoxExtender 
                ID="ftbeFechaNacimiento" 
                runat="server"
                TargetControlID="txtFechaNacimiento"
                FilterType="Custom, Numbers"
                ValidChars="/" />
        </div>
    </div>

    <!-- Fila 4: Departamento Residencia y Contratación -->
    <div class="row">
        <!-- Departamento de Residencia -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;">
                <asp:DropDownList ID="ddlDeptoResidencia" runat="server" 
                    CssClass="form-control form-control-lg"
                    ClientIDMode="Static">
                    <asp:ListItem Value="" Text="Seleccione departamento"></asp:ListItem>
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
                <label class="form-label" for="<%= ddlDeptoResidencia.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Departamento de Residencia <span class="text-danger">*</span>
                </label>
                <asp:RequiredFieldValidator ID="rfvDeptoResidencia" runat="server"
                    ControlToValidate="ddlDeptoResidencia"
                    InitialValue=""
                    ErrorMessage="Departamento de residencia requerido."
                    CssClass="small text-danger"
                    Display="Dynamic"
                    ValidationGroup="DatosPersonales" 
                    Enabled="false" />
            </div>
        </div>
        
        <!-- Departamento de Contratación -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;">
                <asp:DropDownList ID="ddlDeptoContratacion" runat="server" 
                    CssClass="form-control form-control-lg"
                    ClientIDMode="Static">
                    <asp:ListItem Value="" Text="Seleccione departamento"></asp:ListItem>
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
                <label class="form-label" for="<%= ddlDeptoContratacion.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Departamento de Contratación <span class="text-danger">*</span>
                </label>
                <asp:RequiredFieldValidator ID="rfvDeptoContratacion" runat="server"
                    ControlToValidate="ddlDeptoContratacion"
                    InitialValue=""
                    ErrorMessage="Departamento de contratación requerido."
                    CssClass="small text-danger"
                    Display="Dynamic"
                    ValidationGroup="DatosPersonales" 
                    Enabled="false" />
            </div>
        </div>
    </div>

    <!-- Fila 5: Sexo y Estado Civil -->
    <div class="row">
        <!-- Sexo -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;">
                <asp:DropDownList ID="ddlSexo" runat="server" 
                    CssClass="form-control form-control-lg"
                    ClientIDMode="Static">
                    <asp:ListItem Value="" Text="Seleccione sexo"></asp:ListItem>
                    <asp:ListItem Value="M" Text="Masculino"></asp:ListItem>
                    <asp:ListItem Value="F" Text="Femenino"></asp:ListItem>
                    <asp:ListItem Value="O" Text="Otro"></asp:ListItem>
                </asp:DropDownList>
                <label class="form-label" for="<%= ddlSexo.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Sexo <span class="text-danger">*</span>
                </label>
                <asp:RequiredFieldValidator ID="rfvSexo" runat="server"
                    ControlToValidate="ddlSexo"
                    InitialValue=""
                    ErrorMessage="Sexo requerido."
                    CssClass="small text-danger"
                    Display="Dynamic"
                    ValidationGroup="DatosPersonales" 
                    Enabled="false" />
            </div>
        </div>
        
        <!-- Estado Civil -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;">
                <asp:DropDownList ID="ddlEstadoCivil" runat="server" 
                    CssClass="form-control form-control-lg"
                    ClientIDMode="Static">
                    <asp:ListItem Value="" Text="Seleccione estado civil"></asp:ListItem>
                    <asp:ListItem Value="S" Text="Soltero(a)"></asp:ListItem>
                    <asp:ListItem Value="C" Text="Casado(a)"></asp:ListItem>
                    <asp:ListItem Value="D" Text="Divorciado(a)"></asp:ListItem>
                    <asp:ListItem Value="V" Text="Viudo(a)"></asp:ListItem>
                    <asp:ListItem Value="U" Text="Unión Libre"></asp:ListItem>
                </asp:DropDownList>
                <label class="form-label" for="<%= ddlEstadoCivil.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Estado Civil <span class="text-danger">*</span>
                </label>
                <asp:RequiredFieldValidator ID="rfvEstadoCivil" runat="server"
                    ControlToValidate="ddlEstadoCivil"
                    InitialValue=""
                    ErrorMessage="Estado civil requerido."
                    CssClass="small text-danger"
                    Display="Dynamic"
                    ValidationGroup="DatosPersonales" 
                    Enabled="false" />
            </div>
        </div>
    </div>

    <!-- Fila 6: Nacionalidad y Celular -->
    <div class="row">
        <!-- Nacionalidad -->
        <div class="col-md-6">
            <div class="mb-3" style="position: relative;">
                <asp:DropDownList ID="ddlNacionalidad" runat="server" 
                    CssClass="form-control form-control-lg"
                    ClientIDMode="Static">
                    <asp:ListItem Value="" Text="Seleccione nacionalidad"></asp:ListItem>
                    <asp:ListItem Value="BOL" Text="Boliviana"></asp:ListItem>
                    <asp:ListItem Value="EXT" Text="Extranjera"></asp:ListItem>
                </asp:DropDownList>
                <label class="form-label" for="<%= ddlNacionalidad.ClientID %>" style="position: absolute; top: -10px; left: 12px; background: white; padding: 0 5px; font-size: 0.80rem; color: #6c757d;">
                    Nacionalidad <span class="text-danger">*</span>
                </label>
                <asp:RequiredFieldValidator ID="rfvNacionalidad" runat="server"
                    ControlToValidate="ddlNacionalidad"
                    InitialValue=""
                    ErrorMessage="Nacionalidad requerida."
                    CssClass="small text-danger"
                    Display="Dynamic"
                    ValidationGroup="DatosPersonales" 
                    Enabled="false" />
            </div>
        </div>
        
        <!-- Número de Celular -->
        <div class="col-md-6">
            <div data-mdb-input-init class="form-outline mb-3">
                <asp:TextBox ID="txtCelular"
                    runat="server"
                    CssClass="form-control form-control-lg"
                    ClientIDMode="Static"
                    type="tel"
                    MaxLength="8"
                    oninput="limitLength(this)" 
                    placeholder=" " />
                <label class="form-label" for="<%= txtCelular.ClientID %>">Número de Celular <span class="text-danger">*</span></label>
            </div>
            <ajaxToolkit:FilteredTextBoxExtender
                ID="ftbeCelular"
                runat="server"
                TargetControlID="txtCelular"
                FilterType="Numbers" />
            <asp:RequiredFieldValidator ID="rfvCelular" runat="server"
                ControlToValidate="txtCelular"
                InitialValue=""
                ErrorMessage="Número de celular requerido."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
            <!-- MANTENIENDO revCelular COMO EN TU FORMULARIO ORIGINAL -->
            <asp:RegularExpressionValidator ID="revCelular" runat="server"
                ControlToValidate="txtCelular"
                ValidationExpression="^[67][0-9]{7}$"
                ErrorMessage="El número de celular debe comenzar con un 6 o un 7 y tener 8 dígitos."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
        </div>
    </div>

    <!-- Fila 7: Email y Dirección (Dirección ocupa toda la fila) -->
    <div class="row">
        <!-- Email -->
        <div class="col-md-6">
            <div data-mdb-input-init class="form-outline mb-3">
                <asp:TextBox ID="txtEmail" runat="server" 
                    CssClass="form-control form-control-lg" 
                    TextMode="Email"
                    MaxLength="100"
                    ClientIDMode="Static"
                    placeholder=" " />
                <label class="form-label" for="<%= txtEmail.ClientID %>">Correo Electrónico <span class="text-danger">*</span></label>
            </div>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                ControlToValidate="txtEmail"
                InitialValue=""
                ErrorMessage="Correo electrónico requerido."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
            <ajaxToolkit:FilteredTextBoxExtender
                ID="ftbeEmail"
                runat="server"
                TargetControlID="txtEmail"
                FilterType="Custom, Numbers, LowercaseLetters, UppercaseLetters"
                ValidChars="@.-_+"
                FilterMode="ValidChars" />
            <asp:RegularExpressionValidator
                ID="revEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                ErrorMessage="Formato de correo electrónico inválido."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
        </div>
        
        <!-- Espacio vacío para mantener el grid -->
        <div class="col-md-6">
            <!-- Espacio reservado -->
        </div>
    </div>

    <!-- Fila 8: Dirección Domicilio (toda la fila) -->
    <div class="row">
        <div class="col-12">
            <div data-mdb-input-init class="form-outline mb-4">
                <asp:TextBox ID="txtDireccion" runat="server" 
                    CssClass="form-control form-control-lg text-uppercase" 
                    placeholder=" "
                    MaxLength="200"
                    ClientIDMode="Static" />
                <label class="form-label" for="<%= txtDireccion.ClientID %>">Dirección Domicilio <span class="text-danger">*</span></label>
            </div>
            <asp:RequiredFieldValidator ID="rfvDireccion" runat="server"
                ControlToValidate="txtDireccion"
                ErrorMessage="Dirección domicilio requerida."
                CssClass="small text-danger"
                Display="Dynamic"
                ValidationGroup="DatosPersonales" 
                Enabled="false" />
            <ajaxToolkit:FilteredTextBoxExtender
                ID="ftbeDireccion"
                runat="server"
                TargetControlID="txtDireccion"
                FilterType="Custom, UppercaseLetters, LowercaseLetters, Numbers"
                ValidChars=" -.,#/°"
                FilterMode="ValidChars" />
        </div>
    </div>

    <!-- Validación resumida -->
    <asp:ValidationSummary ID="vsDatosPersonales" runat="server" 
        CssClass="text-danger mb-3"
        ValidationGroup="DatosPersonales"
        ShowSummary="true"
        ShowMessageBox="false" />

</div>
<style>
   
</style>
