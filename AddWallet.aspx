<%@ Page Async="true" EnableEventValidation="false" Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddWallet.aspx.cs" Inherits="ipt101_gallery_project.AddWallet" %>

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

        <div class="row">
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
                              <asp:RadioButtonList runat="server" ID="PaymentMethods" CssClass="d-flex">
                                  <asp:ListItem Value="gcash" Text="GCash" Selected="True"/>
                                  <asp:ListItem Value="grab_pay" Text="Grab Pay"/>
                                  <asp:ListItem Value="paymaya" Text="Paymaya" Enabled="false"/>
                              </asp:RadioButtonList>

                          </div>
                          <div class="d-md-flex text-center">
                            <asp:Button runat="server" ID="OneHundredCashInBtn" CssClass="btn btn-primary m-2" Text="₱100.00" OnClick="OneHundredCashInBtn_Click"/>
                            <asp:Button runat="server" ID="TwoHundredCashInBtn" CssClass="btn btn-primary m-2" Text="₱200.00" OnClick="TwoHundredCashInBtn_Click"/>
                            <asp:Button runat="server" ID="ThreeHundredCashInBtn" CssClass="btn btn-primary m-2" Text="₱300.00" OnClick="ThreeHundredCashInBtn_Click"/>
                            <asp:Button runat="server" ID="FiveHundredCashInBtn" CssClass="btn btn-primary m-2" Text="₱500.00" OnClick="FiveHundredCashInBtn_Click"/>
                            <asp:Button runat="server" ID="OneThousandCashInBtn" CssClass="btn btn-primary m-2" Text="₱1000.00" OnClick="OneThousandCashInBtn_Click"/>
                          </div>
                          <div class="d-flex flex-column align-items-center justify-content-center">
                              <label>Custom Cash-In</label>
                              <div class="input-group mb-3">
                                  <div class="input-group-prepend">
                                  <span class="input-group-text" id="basic-addon1">₱</span>
                                  </div>
                                  <asp:TextBox type="number" step=".01" runat="server" min="100" max="5000" ID="CustomCashInTbx" CssClass="form-control" aria-label="Amount" aria-describedby="basic-addon1" />
                                  <asp:Button runat="server" ID="CustomCashInBtn" CssClass=" input-group-append btn btn-info d-flex flex-grow-1 text-center justify-content-center align-items-center" Text="Cash In" OnClick="CustomCashInBtn_Click" />
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
                        Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                      </div>
                    </div>
                  </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
