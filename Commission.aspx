<%@ Page Async="true" EnableEventValidation="false" Title="Artist Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Commission.aspx.cs" Inherits="ipt101_gallery_project.Commission" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <br />
        <div class="container">
            <div class="text-center">
                <h1> Your Active Commissions</h1>
            </div>
            <br />
            <div class="col-11 m-auto">
            <table class="table table-striped border table-hover">
              <thead>
                <tr>
                    <th scope="col">Client Name</th>
                    <th scope="col">Commission Title</th>
                    <th scope="col">Artwork Package</th>
                    <th scope="col">Deadline</th>
                    <th scope="col">Status</th>
                    <th scope="col">Actions</th>
                </tr>
              </thead>
              <tbody>
                <% foreach (var commission in artistCommissions)
                    {
                        var status = (string)commission["status"];
                        %>
                  <tr>
                      <td>
                          <a href="Profile?user_guid=<%=commission["user_guid"] %>">
                              <%=commission["firstName"] %> <%=commission["lastName"] %> 
                          </a>
                      </td>
                      <td scope="row">
                        <%=commission["title"] %>
	                </td>
	                <td>
                        <%=commission["package_title"] %>
                        <span class="badge badge-info">
                            (₱<%=(double)Double.Parse(commission["package_price"].ToString()) / 100 %>)
                        </span>
	                </td>
                    <td>
                        <%=commission["deadline"] %>
                    </td>
	                <td>
                        <div class="input-group">
                            <select class="form-select form-control" name="order_info_status" aria-describedby="check" title="Set Status" id="<%=commission["commission_guid"]%>-set-status"  <%=status == "CANCELLED" || status == "FINISHED" ? "disabled":""%> >
                                <option value="REQUESTED" <%=status == "REQUESTED" ? "selected" : "" %> disabled>REQUESTED</option>
                                <option value="PREPAIRING"  <%=status == "PREPAIRING" ? "selected" : "" %> >PREPAIRING</option>
                                <option value="WORK IN PROGRESS"  <%=status == "WORK IN PROGRESS" ? "selected" : "" %> >WORK IN PROGRESS</option>
                                <option value="FINISHED"   <%=status == "FINISHED" ? "selected" : "" %> disabled>FINISHED</option>
                                <option value="CANCELLED"  <%=status == "CANCELLED" ? "selected" : "" %> disabled>CANCELLED</option>
                            </select>
                            <button class="btn btn-primary" type="button"  id="<%=commission["commission_guid"]%>-submit" <%=status == "CANCELLED" || status == "FINISHED" ? "disabled":""%>>
                                <i class="bi bi-check"></i>
                            </button>
                            <script>
                                $("#<%=commission["commission_guid"]%>-submit").click(() => {
                                    const select = $("#<%=commission["commission_guid"]%>-set-status option:selected");
                                    window.location.replace("actions/changeCommissionStatus?commission_guid=<%=commission["commission_guid"]%>&status=" + select.text());
                                })
                            </script>
                        </div>
	                </td>
	                <td class="d-flex flex-column">
		                <!-- Button trigger modal -->
                        <a href="Message?user_guid=<%=commission["created_by"] %>" class="btn btn-info btn-sm mb-1">Message Client</a>
                        <%  if (status == "WORK IN PROGRESS")
                            {%>
                        <a href="AddArtworkFromCommission?commission_guid=<%=commission["commission_guid"] %>" class="btn btn-success btn-sm mb-1">Upload Artwork</a>
                        <%} else if (status == "FINISHED") {%>
                        <a href="ArtworkViewer?artwork_guid=<%=commission["artwork_guid"] %>" class="btn btn-success btn-sm mb-1">View Artwork</a>
                        <%} %>
                        <button type="button" class="btn btn-primary btn-sm mb-1" data-toggle="modal" data-target="#<%=commission["commission_guid"] %>Modal">
                          More Details
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="<%=commission["commission_guid"] %>Modal" tabindex="-1" role="dialog" aria-labelledby="<%=commission["commission_guid"] %>Title" aria-hidden="true">
                          <div class="modal-dialog" role="document">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="<%=commission["commission_guid"] %>Title"><%=commission["title"] %></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                <p style="word-wrap: break-word">
                                    <span class="badge badge-info mr-2">DESCRIPTION</span><%=commission["description"] %>
                                </p>
                                <div>
                                    <span class="badge badge-info mr-2">REFERENCE IMAGE</span>
                                    <img src="<%=commission["reference_image_location"] %>" class="img-fluid"/>
                                </div>
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                              </div>
                            </div>
                          </div>
                        </div>
	                </td>
                  </tr>
                  <%} %>
              </tbody>
            </table>
                </div>
        </div>
    
</asp:Content>
