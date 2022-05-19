<%@ Page Async="true" EnableEventValidation="false" Title="Message" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Message.aspx.cs" Inherits="ipt101_gallery_project.Message" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

   <div class="container-fluid">
     <div class="container py-3 px-4">
 

        <div class="row rounded-lg overflow-hidden shadow-lg">
            <div class="bg-gray px-4 py-2 bg-light">
          <p class="h5 mb-0 py-1">Chat Message</p>
        </div>

    <!-- Chat Box-->
    <div class="col-12 px-0">
      <div class="px-4 py-5 chat-box bg-white">
        <!-- Sender Message-->
        <div class="media w-25 mb-3"><img src="img/man-300x300.png" alt="user" width="50" class="rounded-circle">
          <div class="media-body ml-3">
            <div class="bg-secondary rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-white">Hi Pogi</p>
            </div>
         
          </div>
        </div>

        <!-- Reciever Message-->
        <div class="media w-50 ml-auto mb-3">
          <div class="media-body">
            <div class="bg-primary rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-white">Hello</p>
            </div>
          </div>
        </div>

        <!-- Sender Message-->
        <div class="media w-25 mb-3"><img src="img/man-300x300.png" alt="user" width="50" class="rounded-circle">
          <div class="media-body ml-3">
            <div class="bg-secondary rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-white">Pogi 150 Unli pops</p>
            </div>
     
          </div>
        </div>

        <!-- Reciever Message-->
        <div class="media w-50 ml-auto mb-3">
          <div class="media-body">
            <div class="bg-primary rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-white">Pass, 1500 rating ko eh</p>
            </div>
         
          </div>
        </div>

        <!-- Sender Message-->
        <div class="media w-25 mb-3"><img src="img/man-300x300.png" alt="user" width="50" class="rounded-circle">
          <div class="media-body ml-3">
            <div class="bg-secondary  rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-white">Kapal ng mukha mo pla</p>
            </div>
           
          </div>
        </div>

        <!-- Reciever Message-->
        <div class="media w-50 ml-auto mb-3">
          <div class="media-body">
            <div class="bg-primary rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-white">Ayaw pa</p>
            </div>
           
          </div>
        </div>


           <div class="media w-25 mb-3"><img src="img/man-300x300.png" alt="user" width="50" class="rounded-circle">
          <div class="media-body ml-3">
            <div class="bg-secondary  rounded py-2 px-3 mb-2">
              <p class="text-small mb-0 text-white">Iww</p>
            </div>
           
          </div>
        </div>

      </div>

      <!-- Typing area -->
    
      <form action="#" class="bg-light">
              <hr />
        <div class="input-group">
          <input type="text" placeholder="Type a message" aria-describedby="button-addon2" class="form-control rounded-0 border-0 bg-light">
          <div class="input-group-append">
            <button id="button-addon2" type="submit" class="btn btn-link btn-primary text-white"> <i class="fa fa-paper-plane"></i> Send</button>
          </div>
        </div>
      </form>

    </div>
  </div>
</div>
   </div>
</asp:Content>
