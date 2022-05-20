<%@ Page Async="true" EnableEventValidation="false" Title="Artwork Viewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArtworkViewer.aspx.cs" Inherits="ipt101_gallery_project.ArtworkViewer" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        .rating {
          display: inline-block;
          position: relative;
          line-height: 1px;
          height: 6px;
        }

        .rating label {
          position: absolute;
          top: 0;
          left: 0;
          height: 100%;
          cursor: pointer;
        }

        .rating label:last-child {
          position: static;
        }

        .rating label:nth-child(1) {
          z-index: 5;
        }

        .rating label:nth-child(2) {
          z-index: 4;
        }

        .rating label:nth-child(3) {
          z-index: 3;
        }

        .rating label:nth-child(4) {
          z-index: 2;
        }

        .rating label:nth-child(5) {
          z-index: 1;
        }

        .rating label input {
          position: absolute;
          top: 0;
          left: 0;
          opacity: 0;
        }

        .rating label .icon {
          float: left;
          color: transparent;
        }

        .rating label:last-child .icon {
          color: #000;
        }

        .rating:not(:hover) label input:checked ~ .icon,
        .rating:hover label:hover input ~ .icon {
          color: #09f;
        }

        .rating label input:focus:not(:checked) ~ .icon:last-child {
          color: #000;
          text-shadow: 0 0 5px #09f;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%if (artwork != null)
        {%>
    <div class="container">
        <div class="row">
            <div class="col-md-5 m-auto" >
                <img class="img-fluid shadow-lg rounded" src="<%=artwork["image_location"] %>" style="max-height:35rem;"/>
            </div>

        

              <div class="col-md-5 py-4" >
                <h1 style="color: orangered; font-size: 250%;"><%=artwork["title"] %></h1>
                  <% 
                      if ((user == null ? "no user":user["user_guid"].ToString()) == artwork["commissioned_by"].ToString())
                      {%>
                  <label class="font-weight-bold">Set Rating: </label>
                    <div class="rating">
                        <label>
                        <input type="radio" name="stars" value="1" <%= (int)artwork["rating"] == 1 ? "checked":"" %> />
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        </label>
                        <label>
                        <input type="radio" name="stars" value="2" <%= (int)artwork["rating"] == 2 ? "checked":"" %> />
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        </label>
                        <label>
                        <input type="radio" name="stars" value="3" <%= (int)artwork["rating"] == 3 ? "checked":"" %> />
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>   
                        </label>
                        <label>
                        <input type="radio" name="stars" value="4" <%= (int)artwork["rating"]== 4 ? "checked":"" %>/>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        </label>
                        <label>
                        <input type="radio" name="stars" value="5" <%= (int)artwork["rating"] == 5 ? "checked":"" %>/>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        <span class="icon"><i class="fa-solid fa-star"></i></span>
                        </label>
                    </div>
                    <script>
                        $(':radio').change(function () {
                            $.get("/Actions/SetArtworkRating?artwork_guid=<%=artwork["artwork_guid"]%>&rating=" + this.value);
                        });
                    </script>
                  <%} else if ((int)artwork["rating"] > 0) {
                          %> <label class="font-weight-bold">Rating: </label> <%
                        for (var i = 0; i < (int)artwork["rating"]; i++)
                        {
                            %>
                                <i class="fa-solid fa-star" style="color: #09f"></i>
                            <%
                        }
                        for (var i=(int)artwork["rating"]; i<5; i++)
                        {
                            %>
                                <i class="fa-solid fa-star"></i>
                            <%
                        }
                      } else {%>
                  No rating
                  <%} %>
                   
                  <h5>Uploaded by: <a class="badge badge-primary" href="Profile?user_guid=<%=artwork["user_guid"] %>"><%=artwork["firstName"] %> <%=artwork["lastName"] %></a></h5>  
                  <% if (artwork["commissioned_by"].ToString().Length > 0) {%>
                  <h5>Commissioned by: <a class="badge badge-primary" href="Profile?user_guid=<%=artwork["c_guid"] %>"><%=artwork["c_firstName"] %> <%=artwork["c_lastName"] %></a></h5>  
                  <%} %>
                  <hr style="border-top: 1px solid #8c8b8b;"/>
                   
                    <h5>Medium</h5>
                    <p><%=artwork["medium"] %></p>
                  
                   <h5>Dimensions</h5>
                    <p><%=artwork["dimensions"] %></p>
                         <hr style="border-top: 1px solid #8c8b8b;"/>
                    <h5>Description</h5>
                    <p>
                        <%=artwork["description"] %>
                    </p>

                  <h5>Comments</h5>
                  <% if (user != null)
                      {%>
                  <%if ((bool)user["is_active"])
                      {%>
                    <asp:Panel runat="server" ID="AddCommentPnl" DefaultButton="AddCommentBtn">
                        <div class="input-group">
                            <asp:TextBox runat="server" class="form-control" id="CommentTbx" TextMode="MultiLine" rows="1" placeholder="Add Comment"></asp:TextBox>
                            <asp:Button runat="server" class="btn btn-sm btn-primary col-4" Text="Publish" ID="AddCommentBtn" OnClick="AddCommentBtn_Click"></asp:Button>
                        </div>
                    </asp:Panel>
                  <%} else {%>

                  <p>You cannot participate in the comment section since your account is currently <span class="badge badge-secondary">inactive</span>.</p>
                  <%} %>
                  <%}
                      else
                      { %>
                  <div>
                      <p>You are not logged in. <a href="Login.aspx">Please login to become a part of the conversation.</a></p>
                  </div>
                  <%} %>
                  <% foreach (var comment in comments) { %>
                  <div class="my-2">
                      <a class="font-weight-bold" href="Profile?user_guid=<%=comment["created_by"] %>">@<%=comment["username"] %>:</a>
                      <span>
                          <%=comment["text"] %>
                      </span>
                  </div>
                  <%} %>
            </div>
        </div>
    </div>

    <hr style="border-top: 1px solid #8c8b8b;"/>    

    <div class="container-fluid w-100 h-100">
        <h3 class="text-center py-4">Other Works By <%=artwork["firstName"] %> <%=artwork["lastName"] %></h3>


        <div class="container">
              
        <div class="row mb-5">
                <% foreach (var artwork in artworks)
                  {%>
              <div class="col-sm-4 mb-3">
                  <a href="./ArtworkViewer?artwork_guid=<%=artwork["artwork_guid"] %>" class="text-dark">
                <div class="card shadow">
                    <img src="<%=artwork["image_location"] %>" class="card-img-top" alt="..." style="max-height: 15rem; object-fit: contain" >
                  <div class="card-body">
                    <h5 class="card-title"><%=artwork["title"] %></h5>
                      <div class="w-more">
                      <span class="w-ctegory">@<%=artwork["username"] %></span>  <span class="w-date"><%=artwork["created_at"].ToString().Length > 0 ? "/ " + DateTime.Parse(artwork["created_at"].ToString()).ToLongDateString() : "" %></span>
                    </div>
                  </div>
                </div>
                    </a>
              </div>
              <%} %>
        </div>
    </div>
    <br />
    <%}
        else
        {%>
    <h1 class="text-center m-5">Artwork not found!</h1>
    <%} %>

</asp:Content>
