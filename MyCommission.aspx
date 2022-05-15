<%@ Page Async="true" EnableEventValidation="false" Title="Commission" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyCommission.aspx.cs" Inherits="ipt101_gallery_project.MyCommission" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container">
            <h1 class="text-center py-4"> My Commission </h1>
            



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
                  <td>
                      <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Done
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item" href="#">Requesting</a>
                        <a class="dropdown-item" href="#">Processing</a>
                        <a class="dropdown-item" href="#">Done</a>
                        </div>
                    </div>

                  </td>
                <td><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                  Upload
                                </td>                </tr>
                <tr>
                  <th scope="row">Kuya Tupe</th>
                  <td>P1000</td>
                  <td>

                      <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Done
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                     <a class="dropdown-item" href="#">Requesting</a>
                        <a class="dropdown-item" href="#">Processing</a>
                        <a class="dropdown-item" href="#">Done</a>
                    </div>
                </div>

                  </td>
                  <td><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                  Upload
                </td>
                </tr>
                <tr>
                  <th scope="row">Alden Ruben</th>
                  <td>P1000</td>
                  <td>

                          <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Done
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                     <a class="dropdown-item" href="#">Requesting</a>
                        <a class="dropdown-item" href="#">Processing</a>
                        <a class="dropdown-item" href="#">Done</a>
                    </div>
                </div>

                  </td>
                <td><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                  Upload
                </td>         </tr>
              </tbody>
            </table>
                </div>
        




    


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Upload Artwork</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <h3 class="text-center">Publish Artwork</h3>
          <div class="input-group mb-3">
  <input type="file" class="form-control" id="inputGroupFile02">
  <label class="input-group-text" for="inputGroupFile02">Upload</label>
</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Publish</button>
      </div>
    </div>
  </div>
</div>

</asp:Content>
