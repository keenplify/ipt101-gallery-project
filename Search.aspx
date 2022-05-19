<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="ipt101_gallery_project.Search" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>

        @media (min-width: 768px)
        {
            .card-columns {
                -webkit-column-count: 4;
                -moz-column-count: 4;
                column-count: 4;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <h3 class="text-center" style="margin-top: 3em">Searching with the keyword <strong><i><%=keyword %></i></strong></h3>
        <div class="card-columns">
            <% foreach (var user in users)
                {%>
            <a href="Profile?user_guid=<%=user["user_guid"] %>">
                <div class="card p-3 shadow mb-4">
                    <img class="card-img-top" src="<%=user["avatar_location"] != System.DBNull.Value ? user["avatar_location"] : "img/man-300x300.png" %>" alt="Card image cap">
                    <div class="card-body">
                        <%=user["firstName"] %> <%=user["lastName"] %> 
                        <span class="badge badge-info">
                            @<%=user["username"] %>
                        </span>
                    </div>
                </div>
            </a>
            <%} %>
            <% foreach (var artwork in artworks)
                {%>
            <a href="./ArtworkViewer?artwork_guid=<%=artwork["artwork_guid"] %>">
                <div class="card shadow mb-4">
                    <img
                        src="<%=artwork["image_location"] %>"
                        class="card-img-top bg-light rounded artwork-preview"
                        alt="<%=artwork["title"] %>"
                    />
                    <div class="card-body p-0 text-center">
                        <h5 class="card-title m-0"><%=artwork["title"] %></h5>
                        <span class="badge badge-info">
                            Artwork
                        </span>
                    </div>
                </div>
            </a>
            <%} %>
        </div>
    </div>
</asp:Content>
