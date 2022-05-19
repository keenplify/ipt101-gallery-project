<%@ Page Async="true" EnableEventValidation="false" Title="Commission Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AddArtworkFromCommission.aspx.cs" Inherits="ipt101_gallery_project.AddArtworkFromCommission" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <% if (error.Length > 0) {%>
    <script>
        alert(`<%=error %>`);
    </script>
    <%} %>

   <% if (commission != null)
       { %>
      <div class="container-fluid py-4 m-auto " style="background-color:ivory;">
        <div class="col-8 w-100 shadow-lg rounded  m-auto py-5" style="background-color:whitesmoke;">
            <h3 class="text-center mb-0 font-weight-bold text-uppercase">Add Artwork Form</h3>
            <h5 class="text-center mb-3">
                Uploading to commission: 
                <span class="badge badge-primary">
                    <%=commission["title"]%>
                </span> 
            </h5>
            <div class="alert alert-info">
                By uploading an artwork, we will mark the commission as 
                <span class="badge badge-success">
                    FINISHED
                </span> 
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
    <%}
        else
        { %>
    <h1 class="m-5 text-center">Commission not found</h1>
    <%} %>
  
</asp:Content>
