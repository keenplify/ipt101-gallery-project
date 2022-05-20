<%@ Page Async="true" EnableEventValidation="false" Title="Viewer" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RViewer.aspx.cs" Inherits="ipt101_gallery_project.RViewer" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
	<br />
	<h2 class="text-center">Pricing Packages</h2>
	<div class="text-center">
		<button type="button" class="btn btn-primary m-auto" data-toggle="modal" data-target="#add">
		Add Packages
		</button>
	</div>
	<br />
	<div class="container py-3">
		<div class="row">
			<% foreach (var package in packages)
                {%>
			<div class="col-sm-4">
				<div class="card shadow ">
					<img class="card-img-top rounded" style="max-height: 15rem; object-fit:contain" src="<%=package["image_location"] %>" alt="Card image cap">
					<div class="card-body">
						<h5 class="card-title"><%=package["title"] %></h5>
						<p class="card-text"><%=package["description"] %></p>
						<span>
						<button class="btn btn-outline-dark disabled col-6" >₱<%=(float)((int)package["price"] / 100) %></button>

						<a type="button" class="btn btn-success" href="EditPackage?package_guid=<%=package["package_guid"] %>">Edit</a>

						<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#delete<%=package["package_guid"] %>Modal"> Delete </button>
						</span>
					</div>
				</div>
			</div>
			<!-- Modal for delete-->
			<div class="modal fade" id="delete<%=package["package_guid"] %>Modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header border-bottom-0">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body text-center">
							<div class="container">
								<i class="fa-solid fa-trash-can " style="color:red; font-size:350%;"></i>
								<h4 class="py-3">Are you sure?</h4>
								<p>Do you really want to delete these records? This process cannot be undone</p>
								<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
								<a href="Actions/DeletePackage?package_guid=<%=package["package_guid"] %>" type="button" class="btn btn-danger">Delete</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%} %>
		</div>
	</div>
	<!-- Modal for Add -->
	<div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title border-bottom-0">Add Packages</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<asp:Panel runat="server" ID="AddPackage">
					<div class="modal-body">
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
										<label for="Price">Prices:</label>
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
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						<asp:Button runat="server" ID="AddPackageBtn" OnClick="AddPackageBtn_Click" type="button" class="btn btn-primary" Text="Add Package" />
					</div>
				</asp:Panel>
			</div>
		</div>
	</div>
</asp:Content>