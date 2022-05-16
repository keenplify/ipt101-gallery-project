<%@ Page Async="true" EnableEventValidation="false" Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="ipt101_gallery_project.Profile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container-fluid bg-primary d-flex align-item-center mb-4 py-4"> 
        
        <div class="container">
                <div class="row align-item-center">
                    <div class="col-lg-7 text-center text-lg-left">
                        <h4 class="text-white font-weight-normal mt-5">Hello, my name</h4>
                        <h1 class="text-white font-weight-normal text-uppercase" style="font-size: 75px;">Bob Marley</h1>
                        <h4 class="text-white font-weight-normal text-uppercase">Painter</h4>

                     <div class="d-flex align-item-center justify-content-center justify-content-lg-start pt-2">
                        <a class="btn btn-light  shadow" href="./CommissionForm">Request Commission</a>
                    </div>
                    </div>

                    <div class="col-lg-5 px-8 pl-lg-0 pb-5 pb-lg-4">
                        <img class="img-fluid rounded-circle shadow-lg w-75" src="img/man-300x300.png"/>
                    </div>  
                    </div>
            </div>
            </div>


    <div class="container">

        <div class="container">

            <h3 class=" text-center font-weight-normal text-uppercase py-4">artwork of Bob Marley</h3>

        <!-- Gallery -->
            <div class="row">
              <div class="col-lg-4 col-md-12 mb-4 mb-lg-0">
                   <a href="./ArtworkViewer" class="text-dark">
                <img
                  src="assets/img/work-1.jpg"
                  class="w-100 shadow-1-strong rounded mb-4 s"
                  alt="Boat on Calm Water"
                />
                  </a>
               
              </div>

                <div class="col-lg-4 col-md-12 mb-4 mb-lg-0">
                   <a href="./ArtworkViewer" class="text-dark">
                <img
                  src="assets/img/work-2.jpg"
                  class="w-100 shadow-1-strong rounded mb-4"
                  alt="Boat on Calm Water"
                />
                  </a>
              </div>


                   <div class="col-lg-4 col-md-12 mb-4 mb-lg-0">
                   <a href="./ArtworkViewer" class="text-dark">
                <img
                  src="assets/img/work-3.jpg"
                  class="w-100 shadow-1-strong rounded mb-4"
                  alt="Boat on Calm Water"
                />
                  </a>
              </div>


               
              </div>
            </div>
            <!-- Gallery -->


            </div>

    </div>

            



</asp:Content>
