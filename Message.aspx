<%@ Page Async="true" EnableEventValidation="false" Title="Message" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Message.aspx.cs" Inherits="ipt101_gallery_project.Message" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
	<style>
		.message {
			width: 75%
		}

		@media (min-width: 768px) {
			.message {
				width: 30%
			}
		}
	</style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <% if (to == null)
        {%>
    <h1 class="m-5 text-center">User not found!</h1>
    <%} else {%>
    <div class="container-fluid">
		<div class="container py-3 px-4">
			<div class="row rounded-lg overflow-hidden shadow-lg">
				<div class="bg-gray px-4 py-2 bg-light">
					<p class="h5 mb-0 py-1">
						Now Chatting With: 
						<a href="Profile?user_guid=<%=to["user_guid"] %>">
							<%=to["firstName"] %> <%=to["lastName"] %>
						</a>
					</p>
				</div>
				<!-- Chat Box-->
				<div class="col-12 px-0">
					<div class="px-4 py-5 chat-box bg-white">
						<%foreach (var message in messages)
                            {
                                bool isFromSelf = (message["to_guid"].ToString() == to["user_guid"].ToString());
								%>
						<div class="media message <%=isFromSelf ? "ml-auto text-right" : "" %>">
							<% if (!isFromSelf) {%>
								<img src="<%=to["avatar_location"] == System.DBNull.Value ? "img/man-300x300.png":to["avatar_location"]%>" alt="user" width="50" class="rounded-circle mr-1">
							<%} %>
							<div class="media-body">
								<div class="<%=isFromSelf ? "bg-primary" : "bg-secondary" %> rounded py-2 px-3 mb-2">
									<small class="mb-0 font-weight-bold text-white">
										<%=isFromSelf ? "You" : $"{to["firstName"]} {to["lastName"]}" %>
										- <%=message["created_at"] %>
									</small>
									<p class="text-small mb-0 text-white">
										<%=message["text"] %>
									</p>
								</div>
							</div>
						</div>
						<%} %>
					</div>
					<!-- Typing area -->
					<asp:Panel runat="server" ID="AddMessagePnl" class="bg-light" DefaultButton="SendMessageBtn">
						<hr />
						<div class="input-group">
							<asp:TextBox runat="server" type="text" placeholder="Type a message" aria-describedby="button-addon2" class="form-control rounded-0 border-0 bg-light" ID="MessageTbx" />
							<div class="input-group-append">
								<asp:LinkButton runat="server" ID="SendMessageBtn" class="btn btn-link btn-primary text-white" OnClick="SendMessageBtn_Click">
									<i class='fa fa-paper-plane'></i> Send
								</asp:LinkButton>
							</div>
						</div>
					</asp:Panel>
				</div>
			</div>
		</div>
	</div>
    <%} %>
</asp:Content>
