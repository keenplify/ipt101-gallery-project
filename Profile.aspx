<%@ Page Async="true" EnableEventValidation="false" Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="ipt101_gallery_project.Profile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <% if (error.Length > 0) {%>
    <script>
        alert(`<%=error %>`);
    </script>
    <%} %>

    <% if (_user != null) {%>
        <div class="container-fluid bg-primary d-flex align-item-center mb-4 py-4"> 
        
        <div class="container">
                <div class="row align-item-center">
                    <div class="col-lg-7 text-center text-lg-left">
                        <h4 class="text-white font-weight-normal mt-5">Hello, my name is</h4>
                        <h1 class="text-white font-weight-bold text-uppercase" style="font-size: 75px;">
                            <%=_user["firstName"] %> <%=_user["lastName"] %>
                        </h1>
                        <h4 class="text-white font-weight-normal">
                            @<%=_user["username"] %>
                        </h4>
                         <% if ((bool)_user["is_active"])
                            {%>
                        <span class="badge badge-info d-inline-block">
                            <span class="d-flex align-items-center flex-grow-0 w-auto h-100">
                                <span data-feather="check-circle" class="mr-2"></span> This user is active and is verified.
                            </span>
                        </span>
                        <%} else {%>
                        <span class="badge badge-secondary d-inline-block">
                            <span class="d-flex align-items-center flex-grow-0 w-auto h-100">
                                <span data-feather="x-circle" class="mr-2"></span> This user is not yet active
                            </span>
                        </span>
                        <%} %>
                        
                     <div class="d-flex align-item-center justify-content-center justify-content-lg-start pt-2">
                        
                        <% if ((bool)_user["is_active"] && (bool)user["is_active"])
                            {%>
                         <%if (isSameUser) {%>
                         <!-- Button trigger modal -->
                        <button type="button" class="btn btn-success m-2 shadow" data-toggle="modal" data-target="#exampleModal">
                            <span data-feather="upload" class="mr-2"></span>
                            Upload Your Artwork
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Upload an Artwork</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                    </div>
                                    <asp:Panel runat="server" ID="AddArtworkPnl" DefaultButton="AddArtworkBtn">
                                        <div class="modal-body">
                                            <div class="form-group">
                                                <label>Artwork Title</label>
                                                <asp:TextBox runat="server" ID="TitleTbx" CssClass="form-control" placeholder="Artwork Title" />
                                            </div>
                                            <div class="form-group">
                                                <label>Artwork Description</label>
                                                <asp:TextBox runat="server" ID="DescriptionTbx" TextMode="MultiLine" MaxLength="1024" Rows="3" CssClass="form-control" placeholder="Artwork Description" />
                                            </div>
                                            <div class="form-group">
                                                <label>Artwork Medium</label>
                                                <asp:TextBox runat="server" ID="MediumTbx" CssClass="form-control" placeholder="Artwork Medium" />
                                            </div>
                                            <div class="form-group">
                                                <label>Artwork Dimensions</label>
                                                <asp:TextBox runat="server" ID="DimensionsTbx" CssClass="form-control" placeholder="Artwork Dimensions" />
                                            </div>
                                            <div class="form-group">
                                                <label>Artwork Image</label>
                                                <asp:FileUpload runat="server" ID="ImageUpl" CssClass="form-control" />
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                            <asp:Button runat="server" CssClass="btn btn-primary" ID="AddArtworkBtn" Text="Submit"  OnClick="AddArtworkBtn_Click"/>
                                        </div>
                                    </asp:Panel>
                                </div>
                            </div>
                        </div>
                         <%} else { %>
                            <a class="btn btn-light m-2 shadow" href="./CommissionForm?artist_guid=<%=_user["user_guid"] %>">
                                <span data-feather="plus" class="mr-2"></span>
                                Request Commission
                            </a>
                            <a class="btn btn-light m-2 shadow" href="./Message?to_guid=<%=_user["user_guid"] %>">
                                <span data-feather="mail" class="mr-2"></span>
                                Send Message
                            </a>
                         <%} %>
                         <%} %>
                    </div>
                    </div>

                    <div class="col-lg-5 px-8 pl-lg-0 pb-5 pb-lg-4 mt-3 d-flex justify-content-center">
                        <img class="img-fluid rounded-circle shadow-lg w-75 bg-light" src="<%=_user["avatar_location"].ToString().Length > 0 ? _user["avatar_location"] : "img/man-300x300.png"%>" />
                    </div>  
                    </div>
            </div>
            </div>


    <div class="container">

        <div class="container">

            <h3 class=" text-center font-weight-normal text-uppercase py-4">Artworks of <%=_user["firstName"] %> <%=_user["lastName"] %></h3>

            <!-- Gallery -->
            <%if (artworks.Count > 0)
                {%>
            <div class="card-columns justify-content-center">
                <%foreach (var artwork in artworks)
                    { %>
                <a href="./ArtworkViewer?artwork_guid=<%=artwork["artwork_guid"] %>">
                    <div class="card shadow mb-4">
                        <img
                            src="<%=artwork["image_location"] %>"
                            class="card-img-top bg-light rounded artwork-preview"
                            alt="<%=artwork["title"] %>"
                        />
                        <div class="card-body p-0 text-center">
                            <h5 class="card-title m-0"><%=artwork["title"] %></h5>
                        </div>
                    </div>
                </a>
                <%} %>
            </div>
            <%} else {%>
            <h4 class="text-center m-5">No artworks found.</h4>
            <%} %>
            </div>
            <!-- Gallery -->


            </div>
    <%} else {%>
    <h3 class="text-center my-5">
        User not found.
    </h3>
    <%} %>
</asp:Content>
