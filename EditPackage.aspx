<%@ Page Async="true" EnableEventValidation="false" Title="Viewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditPackage.aspx.cs" Inherits="ipt101_gallery_project.EditPackage" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<% if (Request.QueryString["package_guid"] != null) { %>
		<div class="container mt-5 text-center">
			<h3 class="pt-3">Edit Package <%=package["title"] %></h3>
			<div class="row">
				<div class="col-md-8 offset-md-2">
					<div class="container input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">Upload Image</span>
							</div>
							<div class="custom-file ml-2">
								<asp:FileUpload runat="server" ID="ImageUpl" accept="image/*" />
							</div>
						</div>
						<div class="form container">
							<div class="row">
								<div class="col">
									<div class="form-group">
										<label>Package Title:</label>
										<asp:TextBox runat="server" ID="PackageTitleTbx" type="text" class="form-control" placeholder="Title" />
									</div>
								</div>
								<div class="col">
									<div class="form-group">
										<label for="Price">Price:</label>
										<div class="input-group">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text" id="php">₱</span>
                                            </div>
                                            <asp:TextBox aria-describedby="php" runat="server" step=".01" class="form-control" ID="PriceTbx" min="0" type="number"/>
                                        </div>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="Description">Description:</label>
								<asp:TextBox runat="server" ID="DescriptionTbx" type="text" class="form-control"  placeholder="Description" TextMode="MultiLine" />
							</div>
							<div>
								<button type="button" class="btn btn-secondary w-100 my-1" data-dismiss="modal">Close</button>
								<asp:Button runat="server" ID="EditPackageBtn" OnClick="EditPackageBtn_Click" type="button" class="btn btn-primary w-100 my-1" Text="Edit Package" />
							</div>
						</div>
				</div>
			</div>
		</div>
	<%} else {%>
		<h1 class="m-5 p-5 text-center">Package not found!</h1>
	<%} %>
</asp:Content>