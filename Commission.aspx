<%@ Page Async="true" EnableEventValidation="false" Title="My Commission" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Commission.aspx.cs" Inherits="ipt101_gallery_project.Commission" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
        <div class="container">
             <div class="text-center">
            <h1> My Commission Artwork </h1>
            <a href="./MyCommission" class="btn btn-success text-center">My Commission</a>
                </div>
            <br />
            <div class="col-11 m-auto">
            <table class="table table-striped border table-hover">
              <thead>
                <tr>
                  <th scope="col">Artist</th>
                  <th scope="col">Price Tier</th>
                  <th scope="col">Status</th>
                  <th scope="col">Preview</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <th scope="row">Charle Darwin</th>
                  <td>P1000</td>
                  <td>Done</td>
                  <td><img src="img/images (1).jpg" class="img-fluid" style="width:7em; height:7em; max-height:7em; max-width:7em; object-fit: contain;"/></td>
                </tr>
                <tr>
                  <th scope="row">Kuya Tupe</th>
                  <td>P1000</td>
                  <td>Proccessing</td>
                  <td><img src="img/images.jpg" class="img-fluid" style="width:7em; height:7em; max-height:7em; max-width:7em; object-fit: contain;"/></td>
                </tr>
                <tr>
                  <th scope="row">Alden Ruben</th>
                  <td>P1000</td>
                  <td>Requested</td>
                   <td><img src="img/images (1).jpg" class="img-fluid" style="width:7em; height:7em; max-height:7em; max-width:7em; object-fit: contain;"/></td>
                </tr>
              </tbody>
            </table>
                </div>
        </div>
    
</asp:Content>
