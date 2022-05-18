<%@ Page Async="true" EnableEventValidation="false" Title="Commission Form" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CommissionForm.aspx.cs" Inherits="ipt101_gallery_project.CommissionForm" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <% if (error.Length > 0) {%>
    <script>
        alert(`<%=error %>`);
    </script>
    <%} %>

   <% if (artist != null)
       { %>
      <div class="container-fluid py-4 m-auto " style="background-color:ivory;">
        <div class="col-8 w-100 shadow-lg rounded  m-auto py-5" style="background-color:whitesmoke;">
            <h3 class="text-center mb-0 font-weight-bold text-uppercase">Commission Form</h3>
            <h5 class="text-center mb-3">
                Commissioning to: 
                <a class="badge badge-primary" href="Profile?user_guid=<%=artist["user_guid"] %>">
                    <%=artist["firstName"] %> <%=artist["lastName"] %> (@<%=artist["username"] %>)
                </a>
            </h5>
            <asp:Panel runat="server" ID="AddCommissionPnl" DefaultButton="SubmitCommissionBtn">
                <div class="container form">
                    <div class="row">

                        <div class="col-md-4 form-group">
                            <label>Package:</label>
                            <asp:DropDownList runat="server" ID="PackagesList" CssClass="form-control" title="Package" />
                        </div>

                         <div class="col form-group">
                            <label>Title:</label>
                            <asp:TextBox runat="server" ID="TitleTbx" type="text" class="form-control" placeholder="Request Title" MaxLength="128"/>
                        </div>

                    </div>

                    <div class="form-group ">
                        <label>Description:</label>
                        <asp:TextBox runat="server" ID="DescriptionTbx" type="text" class="form-control" placeholder="Request Description"  MaxLength="1024" TextMode="MultiLine" Rows="3"/>
                    </div>
                    <div class="row">                           
                        <div class="form-group col-md-8">
                            <label>Reference Image:</label>                     
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text">Upload</span>
                                </div>
                                <div class="custom-file">
                                    <asp:FileUpload runat="server" type="file" class="custom-file-input" ID="refImage" />
                                    <label class="custom-file-label" for="inputGroupFile01" id="refImageLabel">Choose file</label>
                                </div>
                            </div>
                            <script>
                                $('#MainContent_refImage').on('change', function () {
                                    //get the file name
                                    var fileName = $(this).val();
                                    //replace the "Choose a file" label
                                    $(this).next('#refImageLabel').html(fileName);
                                })
                            </script>
                        </div>
                        <div class="form-group col">
                            <label>Deadline (optional):</label>
                            <asp:TextBox runat="server" TextMode="Date" type="date" class="form-control" placeholder="Deadline" ID="DeadlineTbx" />
                        </div>
                    </div>



                    <div class="row">
                        <label class="col-form-label col-sm-3 pt-0">Select Visibility:</label>
                        <div class="col-sm-9">
                            <asp:RadioButtonList runat="server" ID="Visibility">
                                <asp:ListItem Text="Public" Value="PUBLIC" class="mr-3"/>
                                <asp:ListItem Text="Unlisted" Value="UNLISTED" class="mr-3" />
                            </asp:RadioButtonList>
                        </div>
                    </div>

                    <asp:Button runat="server" ID="SubmitCommissionBtn" Text="Submit" type="button" class="btn btn-primary btn-block" OnClick="SubmitCommissionBtn_Click" />
                </div>
            </asp:Panel>
        </div>
    </div>
    <%}
        else
        { %>
    <h1 class="m-5 text-center">Artist not found</h1>
    <%} %>
  
</asp:Content>
