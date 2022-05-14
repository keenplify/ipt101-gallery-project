<%@ Page Async="true" EnableEventValidation="false" Title="Admin Cashouts" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AdminCashouts.aspx.cs" Inherits="ipt101_gallery_project.AdminCashouts" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h1 class="text-center">Cashout Requests</h1>
        <table class="table table-striped table-hover mt-3 rounded shadow">
            <thead class="font-weight-bold">
                <tr>
                    <td>Phone Number</td>
                    <td>Account Name</td>
                    <td>Amount</td>
                    <td>Is Paid</td>
                </tr>
            </thead>
            <tbody  class="text-center">
                <% foreach (var cashout in cashouts)
                    { %>
                <tr>
                    <td><%=cashout["phone_number"] %></td>
                    <td><%=cashout["account_name"] %></td>
                    <td>₱<%=(float)((int)cashout["amount"] / 100) %></td>
                    <td>
                        <div class="input-group mb-3">
                          <div class="input-group-prepend">
                            <div class="input-group-text">
                              <input
                                  type="checkbox"
                                  aria-label="Mark as PAID"
                                  name="is_done"
                                  <%= cashout["is_done"].ToString() == "1" ? "checked" :"" %>
                                  style="pointer-events: none;"
                              />
                            </div>
                          </div>
                          <div class="input-group-append">
                            <a class="btn btn-primary" href="Admin/ToggleDoneStatus?cashout_guid=<%=cashout["cashout_guid"] %>" >Toggle Paid Status</a>
                          </div>
                        </div>
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
    </div>

</asp:Content>
