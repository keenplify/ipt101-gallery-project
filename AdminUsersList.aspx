<%@ Page Async="true" EnableEventValidation="false" Title="Admin Cashouts" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminUsersList.aspx.cs" Inherits="ipt101_gallery_project.AdminUsersList" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h1 class="text-center">Users</h1>
        <table class="table table-striped table-hover mt-3 rounded shadow">
            <thead class="font-weight-bold">
                <tr>
                    <td>Full Name</td>
                    <td>Email</td>
                    <td>Username</td>
                    <td>Wallet</td>
                    <td>Active / Verify</td>
                </tr>
            </thead>
            <tbody  class="text-center">
                <% foreach (var _user in users)
                    { %>
                <tr>
                    <td>
                        <a href="Profile?user_guid=<%=_user["user_guid"] %>"<%=_user["firstName"]%> <%=user["middleName"]%> <%=_user["lastName"]%>">
                            <%=_user["firstName"]%> <%=user["middleName"]%> <%=_user["lastName"]%>
                        </a>
                    </td>
                    <td><%=_user["email"]%></td>
                    <td>@<%=_user["username"]%></td>
                    <td>₱<%=(float)((int)_user["wallet"]) / 100 %></td>
                    <td>
                        <div class="input-group mb-3">
                          <div class="input-group-prepend">
                            <div class="input-group-text">
                              <input
                                  type="checkbox"
                                  aria-label="Mark as Active"
                                  name="is_done"
                                  <%= (bool)_user["is_active"]? "checked" :"" %>
                                  style="pointer-events: none;"
                              />
                            </div>
                          </div>
                          <div class="input-group-append">
                            <a class="btn btn-primary" href="Admin/ToggleActiveStatus?user_guid=<%=_user["user_guid"] %>" >Toggle Active Status</a>
                          </div>
                        </div>
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
    </div>
</asp:Content>
