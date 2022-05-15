<%@ Page Async="true" EnableEventValidation="false" Title="Artwork Viewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArtworkViewer.aspx.cs" Inherits="ipt101_gallery_project.ArtworkViewer" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <div class="row">
            <div class="col-md-5 m-auto" >
                <img class="img-fluid shadow-lg rounded" src="img/623467453aa95809d9b131d0_The_Scream_by_Edvard_Munch,_1893_-_Nasjonalgalleriet.png" style="max-height:35rem;"/>
            </div>

        

              <div class="col-md-5 py-4" >
                <h1 style="color: orangered; font-size: 250%;">ART 1</h1>
                   <div class="w-more">
                       <span class="w-ctegory"><i class="fa-solid fa-star"></i></span> <span class="w-date"><i class="fa-solid fa-star"></i></span>  <span class="w-date"><i class="fa-solid fa-star"></i></span>  <span class="w-date"><i class="fa-solid fa-star"></i></span>  <span class="w-date"><i class="fa-solid fa-star"></i></span>   
                    </div>
                  <h5>Crisostomo</h5>
                     <b><h5>Php 7,000</h5></b>     
                  <hr style="border-top: 1px solid #8c8b8b;"/>

                    <h5>Year Completed</h5>
                    <p>2021</p>
                   
                    <h5>Medium</h5>
                    <p>Arcylic on Canvas</p>
                  
                   <h5>Dimension</h5>
                    <p>24" x 24"</p>
                         <hr style="border-top: 1px solid #8c8b8b;"/>
                    <h5>Description</h5>
                    <ul>
                 
                        <li>Limited edition print on tiles with original artist signature and COA</li>
                        <li>With Certificate of Authenticity</li>
                        <li>Actual frame may vary from room mock ups</li>
                    </ul>

                  <div class="form-group">
                    <label for="exampleFormControlTextarea1">Comments</label>
                    <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" placeholder="Add Comment"></textarea>
                     
                  </div>
                  
                     <button class="btn btn-sm btn-primary col-4">Publish</button> 

                      
            </div>
        </div>
    </div>

    <hr style="border-top: 1px solid #8c8b8b;"/>    

    <div class="container-fluid w-100 h-100">
        <h3 class="text-center py-4">Other Works By Crisostomo</h3>


        <div class="container">
              
             <div class="row">
               <div class="col-sm-3">
                  <a href="./ArtworkViewer" class="text-dark">
                <div class="card shadow">
                    <img src="assets/img/work-1.jpg" class="card-img-top" alt="..." style="max-height: 15rem;" >
                  <div class="card-body">
                    <h5 class="card-title" style="color: orangered;">Art 1</h5>
                      <div class="w-more">
                       <span class="w-ctegory">Crisostomo</span> / <span class="w-date">P7000</span> 
                    </div>
                  </div>
                </div>
                    </a>
              </div>

              <div class="col-sm-3">
                  <a href="./ArtworkViewer" class="text-dark">
                <div class="card shadow">
                    <img src="assets/img/work-2.jpg" class="card-img-top" alt="..." style="max-height: 15rem;">
                  <div class="card-body">
                    <h5 class="card-title" style="color: orangered;">Art 2</h5>
                      <div class="w-more">
                     <span class="w-ctegory">Crisostomo</span> / <span class="w-date">P7000</span> 
                    </div>
                  </div>
                </div>
                    </a>
              </div>

                 <div class="col-sm-3">
                  <a href="./ArtworkViewer" class="text-dark">
                <div class="card shadow">
                    <img src="assets/img/work-3.jpg" class="card-img-top" alt="..." style="max-height: 15rem;">
                  <div class="card-body">
                    <h5 class="card-title" style="color: orangered;">Art 3</h5>
                      <div class="w-more">
                       <span class="w-ctegory">Crisostomo</span> / <span class="w-date">P7000</span>  
                    </div>
                  </div>
                </div>
                    </a>
              </div>

                  <div class="col-sm-3">
                  <a href="./ArtworkViewer" class="text-dark">
                <div class="card shadow">
                    <img src="assets/img/work-3.jpg" class="card-img-top" alt="..." style="max-height: 15rem;">
                  <div class="card-body">
                    <h5 class="card-title" style="color: orangered;">Art 4</h5>
                      <div class="w-more">
                      <span class="w-ctegory">Crisostomo</span> / <span class="w-date">P7000</span> 
                    </div>
                  </div>
                </div>
                    </a>
              </div>

            </div>
            </div>
    </div>
    <br />

</asp:Content>
