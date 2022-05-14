<%@ Page Async="true" EnableEventValidation="false" Title="Your Wallet" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddWallet.aspx.cs" Inherits="ipt101_gallery_project.AddWallet" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card bg-info text-white shadow my-3">
                    <div class="card-body">
                        <label>Wallet Balance</label>
                        <h1 class="font-weight-bold">₱<%=((double)((int)user["wallet"]) / 100) %></h1>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-md-6 offset-md-3">
                <div class="accordion" id="accordionExample">
                  <div class="card">
                    <div class="card-header" id="headingOne">
                      <h2 class="mb-0">
                        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                          <i data-feather="plus"></i>
                          <span class="ml-2">Add Wallet</span>
                        </button>
                      </h2>
                    </div>

                    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
                      <div class="card-body">
                          <div>
                              <label>Select Payment Method</label>
                              <asp:RadioButtonList runat="server" ID="PaymentMethods" CssClass="btn-group colors w-100" RepeatLayout="Flow" data-toggle="buttons">
                                  <asp:ListItem Value="gcash" Text="GCash" Selected="True" class="btn btn-primary active" autocomplete="off"/>
                                  <asp:ListItem Value="grab_pay" Text="Grab Pay"  class="btn btn-primary" autocomplete="off"/>
                              </asp:RadioButtonList>

                          </div>
                          <div class="d-md-flex text-center">
                            <asp:Button runat="server" ID="OneHundredCashInBtn" CssClass="btn btn-info m-2" Text="₱100.00" OnClick="OneHundredCashInBtn_Click"/>
                            <asp:Button runat="server" ID="TwoHundredCashInBtn" CssClass="btn btn-info m-2" Text="₱200.00" OnClick="TwoHundredCashInBtn_Click"/>
                            <asp:Button runat="server" ID="ThreeHundredCashInBtn" CssClass="btn btn-info m-2" Text="₱300.00" OnClick="ThreeHundredCashInBtn_Click"/>
                            <asp:Button runat="server" ID="FiveHundredCashInBtn" CssClass="btn btn-info m-2" Text="₱500.00" OnClick="FiveHundredCashInBtn_Click"/>
                            <asp:Button runat="server" ID="OneThousandCashInBtn" CssClass="btn btn-info m-2" Text="₱1000.00" OnClick="OneThousandCashInBtn_Click"/>
                          </div>
                          <div class="d-flex flex-column align-items-center justify-content-center">
                              <label>Custom Cash-In</label>
                              <div class="input-group mb-3">
                                  <div class="input-group-prepend">
                                  <span class="input-group-text" id="basic-addon1">₱</span>
                                  </div>
                                  <asp:TextBox type="number" step=".01" runat="server" min="100" max="5000" ID="CustomCashInTbx" CssClass="form-control" aria-label="Amount" aria-describedby="basic-addon1" />
                                  <asp:Button runat="server" ID="CustomCashInBtn" CssClass=" input-group-append btn btn-success d-flex flex-grow-1 text-center justify-content-center align-items-center" Text="Cash In" OnClick="CustomCashInBtn_Click" />
                              </div>
                          </div>
                      </div>
                    </div>
                  </div>
                  <div class="card">
                    <div class="card-header" id="headingTwo">
                      <h2 class="mb-0">
                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                          <i data-feather="external-link"></i>
                          <span class="ml-2">Cashout</span>
                        </button>
                      </h2>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
                      <div class="card-body">
                        <asp:Panel runat="server" ID="Cashout" DefaultButton="CashOutBtn">
                            <div class="container-fluid">
                                <% if (CashOutErr.Text.Length > 0)
                                    { %>
                                <div class="alert alert-danger" role="alert">
                                    <asp:Label runat="server" ID="CashOutErr" />
                                </div>
                                <%} %>
                                <div>
                                    <label>Select Cash-out Method</label>
                                    <asp:RadioButtonList runat="server" ID="CashOutTypeRbl" CssClass="btn-group colors w-100" RepeatLayout="Flow" data-toggle="buttons">
                                        <asp:ListItem Value="gcash" Text="GCash" Selected="True" class="btn btn-primary active" autocomplete="off"/>
                                        <asp:ListItem Value="grab_pay" Text="Grab Pay"  class="btn btn-primary" autocomplete="off"/>
                                        <asp:ListItem Value="paymaya" Text="Paymaya"  class="btn btn-primary" autocomplete="off"/>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="form-group row my-2">
                                    <label for="inputPassword" class="col-sm-4 col-form-label">Account Name</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" class="form-control" id="CashOutAccountNameTbx"  placeholder="John Doe"/>
                                    </div>
                                </div>
                                <div class="form-group row my-2">
                                    <label for="inputPassword" class="col-sm-4 col-form-label">Account Number</label>
                                    <div class="col-sm-8">
                                        <asp:TextBox runat="server" class="form-control" id="CashOutAccountNumberTbx" pattern="[0-9]{11}" placeholder="09XX XXX XXXX" />
                                    </div>
                                </div>
                                <div class="form-group row my-2">
                                    <label for="inputPassword" class="col-sm-4 col-form-label">Amount</label>
                                    <div class="col-sm-8  mb-3">
                                        <div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="php">₱</span>
                                            </div>
                                            <asp:TextBox aria-describedby="php amountHelp" runat="server" step=".01" class="form-control" id="CashOutAmountTbx" min="0" type="number" onChange="cashOutAmountTbxChangedHandler()"/>
                                        </div>
                                        <small id="amountHelp" class="form-text text-muted">You'll get <span class="badge badge-info" id="TotalAmount">₱0</span> as we reduce 2% of your total cash-out as cashout fee.</small>
                                    </div>
                                    <script defer>
                                        const CashOutAmountTbx = document.querySelector("#MainContent_CashOutAmountTbx")
                                        const TotalAmount = document.querySelector("#TotalAmount")

                                        const inputHandler = function (e) {
                                            if (e.target.value.length == 0) return;
                                            const value = Number.parseFloat(e.target.value)
                                            const fee = value - (value * .02);
                                            TotalAmount.innerHTML = "₱"+fee;
                                        }

                                        CashOutAmountTbx.addEventListener('input', inputHandler);
                                        CashOutAmountTbx.addEventListener('propertychange', inputHandler); // for IE8
                                    </script>
                                </div>
                                <div>
                                    <asp:Button runat="server" CssClass="btn btn-success w-100" Text="Cash Out" ID="CashOutBtn" OnClick="CashOutBtn_Click"/>
                                </div>
                            </div>
                        </asp:Panel>
                        <div class="container">
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-info w-100 my-2" data-toggle="modal" data-target="#cashoutRequestsModal">
                              Cash Out Requests
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="cashoutRequestsModal" tabindex="-1" role="dialog" aria-labelledby="cashoutRequestsModalLabel" aria-hidden="true">
                              <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                  <div class="modal-header">
                                    <h5 class="modal-title" id="cashoutRequestsModalLabel">Cash-out Requests</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                      <span aria-hidden="true">&times;</span>
                                    </button>
                                  </div>
                                  <div class="modal-body">
                                    <table class="table table-striped table-hover">
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
                                                    <input class="form-check-input" type="checkbox" style="pointer-events: none;" <%= cashout["is_done"].ToString() == "1" ? "checked" :"" %>>
                                                </td>
                                            </tr>
                                            <%} %>
                                        </tbody>
                                    </table>
                                  </div>
                                  <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                  </div>
                                </div>
                              </div>
                            </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
