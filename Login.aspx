<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ipt101_gallery_project.Login" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
	<link rel="stylesheet" href="Assets/css/stylelogin.css">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="section">
		<div class="container">
			<div class="row full-height justify-content-center">
				<div class="col-12 text-center align-self-center py-5">
					<div class="section pb-5 pt-5 pt-sm-2 text-center">
						<h6 class="mb-0 pb-3 text-white"><span>Log In </span><span>Sign Up</span></h6>
			          	<input class="checkbox" type="checkbox" id="reg-log" name="reg-log"/>
			          	<label for="reg-log"></label>
						<div class="card-3d-wrap mx-auto">
							<div class="card-3d-wrapper">
								<div class="card-front">
									<div class="center-wrap">
										<div class="section text-center">
											<h4 class="mb-4 pb-3 text-white">Log In</h4>
											<% if (lblLoginError.Text.Length > 0)
												{ %>    
											<div class="alert alert-danger">
												<asp:Label runat="server" ID="lblLoginError"/>
											</div>
											<%} %>
											<asp:Panel runat="server" DefaultButton="LoginBtn">
												<div class="form-group">
													<asp:TextBox runat="server" type="username" name="username" class="form-style" placeholder="Your Username" ID="LoginUsername" autocomplete="off" />
													<i class="input-icon uil uil-at"></i>
												</div>	
												<div class="form-group mt-2">
													<asp:TextBox runat="server" type="password" name="logpass" class="form-style" placeholder="Your Password" ID="LoginPassword" autocomplete="off" />
													<i class="input-icon uil uil-lock-alt"></i>
												</div>
												<asp:Button runat="server" ID="LoginBtn" Text="Submit" href="#" class="btn mt-4" OnClick="LoginBtn_Click" />
											</asp:Panel>
				      					</div>
			      					</div>
			      				</div>
								<div class="card-back">
									<div class="center-wrap">
										<div class="section text-center">
											<h4 class="mb-4 pb-3 text-white">Sign Up</h4>
											<div class="form-group">
												<input type="text" name="logname" class="form-style" placeholder="Your Full Name" id="logname" autocomplete="off">
												<i class="input-icon uil uil-user"></i>
											</div>	
											<div class="form-group mt-2">
												<input type="email" name="logemail" class="form-style" placeholder="Your Email" id="logemail" autocomplete="off">
												<i class="input-icon uil uil-at"></i>
											</div>	
											<div class="form-group mt-2">
												<input type="password" name="logpass" class="form-style" placeholder="Your Password" id="logpass" autocomplete="off">
												<i class="input-icon uil uil-lock-alt"></i>
											</div>
											<a href="#" class="btn mt-4">submit</a>
				      					</div>
			      					</div>
			      				</div>
			      			</div>
			      		</div>
			      	</div>
		      	</div>
	      	</div>
	    </div>
	</div>
</asp:Content>
