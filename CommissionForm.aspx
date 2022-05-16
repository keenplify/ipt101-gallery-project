<%@ Page Async="true" EnableEventValidation="false" Title="Commission Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CommissionForm.aspx.cs" Inherits="ipt101_gallery_project.CommissionForm" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

   
    <div class="container-fluid py-4 m-auto " style="background-color:ivory;">
        <div class="col-8 w-100 shadow-lg rounded  m-auto py-5" style="background-color:whitesmoke;">
            <h3 class="text-center font-weight-normal text-uppercase  mb-3">Commission Form</h3>


            <div class="container form">
              <div class="row">

                <div class="form-group col">
                    <label>Package:</label>
                
                    <div class="dropdown show d-grid">
                      <a class="btn btn-secondary dropdown-toggle w-100 text-left" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
                        Package
                      </a>

                      <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="#">Action</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                      </div>
                    </div>
                </div>

                 <div class="form-group col">
                    <label>Title:</label>
                  <input type="text" class="form-control" placeholder="Title">
                </div>

                  </div>

                 <div class="form-group ">
                    <label>Description:</label>
                  <input type="text" class="form-control" placeholder="Description">
                </div>

                

                    <div class="row">                           
                        <div class="form-group col">
                    <label>References:</label>                     
                    <div class="input-group mb-3">
                  <div class="input-group-prepend">
                    <span class="input-group-text">Upload</span>
                  </div>
                    <div class="custom-file">
                    <input type="file" class="custom-file-input" id="inputGroupFile01">
                    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
                  </div>
                </div>
                </div>

                         <div class="form-group col">
                    <label>Deadline:</label>
                  <input type="date" class="form-control" placeholder="Deadline">
                </div>
                       
                  </div>



               <fieldset class="form-group">
                <div class="row">
                  <legend class="col-form-label col-sm-2 pt-0">Select:</legend>
                  <div class="col-sm-10">
                    <div class="form-check">
                      <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios1" value="option1" checked>
                      <label class="form-check-label" for="gridRadios1">
                        Private
                      </label>
                    </div>
                    <div class="form-check">
                      <input class="form-check-input" type="radio" name="gridRadios" id="gridRadios2" value="option2">
                      <label class="form-check-label" for="gridRadios2">
                        Public
                      </label>
                    </div>
       
                  </div>
                </div>
              </fieldset>

                <button type="button" class="btn btn-primary btn-block">Submit</button>
            </div>

        </div>
    </div>
</asp:Content>
