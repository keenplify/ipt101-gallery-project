<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ipt101_gallery_project.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <% if (lblError.Text.Length > 0)
        { %>    
    <div class="alert alert-danger">
        <asp:Label runat="server" ID="lblError"/>
    </div>
    <%} %>
    <asp:Panel runat="server" DefaultButton="LoginBtn">
        <asp:TextBox runat="server" ID="username" CssClass="form-control" placeholder="Username" />
        <asp:TextBox runat="server" ID="password" type="password" CssClass="form-control" placeholder="Password" />
        <asp:Button runat="server" ID="LoginBtn" Text="Login" OnClick="LoginBtn_Click"/>
    </asp:Panel>
</asp:Content>
