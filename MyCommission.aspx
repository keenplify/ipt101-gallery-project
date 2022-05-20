<%@ Page Async="true" EnableEventValidation="false" Title="Commission" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MyCommission.aspx.cs" Inherits="ipt101_gallery_project.MyCommission" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container">
            <h1 class="text-center py-4"> My Commission Requests </h1>

            <table class="table table-striped border table-hover">
              <thead>
                <tr>
                  <th scope="col">Artist Name</th>
                  <th scope="col">Commission Title</th>
                  <th scope="col">Artwork Package</th>
                  <th scope="col">Status</th>
                  <th scope="col">Actions</th>
                </tr>
              </thead>
              <tbody>
                <%foreach (var item in myCommissions.Select((value, index) => new { value, index })) {
                        var commission = item.value;
                        var index = item.index;
                %>
                <tr>
	                <td scope="row">
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
		                <%=commission["status"] %>
	                </td>
	                <td class="d-flex flex-column">
		                <!-- Button trigger modal -->
                        <a href="Message?to_guid=<%=commission["artist_guid"] %>" class="btn btn-info btn-sm mb-1">Message Artist</a>
                        <button type="button" class="btn btn-primary btn-sm mb-1" data-toggle="modal" data-target="#MoreDetails<%=index%>Modal">
                          More Details
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="MoreDetails<%=index%>Modal" tabindex="-1" role="dialog" aria-labelledby="MoreDetails<%=index%>Title" aria-hidden="true">
                          <div class="modal-dialog" role="document">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="MoreDetails<%=index%>Title"><%=commission["title"] %></h5>
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
                        
                        <%if (commission["status"].ToString() != "FINISHED")
                            {%>
                            <%if (commission["status"].ToString() == "REQUESTED") { %>
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-danger btn-sm mb-1" data-toggle="modal" data-target="#Cancel<%=index%>Modal">
                                Cancel Commission
                            </button>

                            <!-- Modal -->
                            <div class="modal fade" id="Cancel<%=index %>Modal" tabindex="-1" role="dialog" aria-labelledby="Cancel<%=index %>Title" aria-hidden="true">
                              <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                  <div class="modal-header">
                                    <h5 class="modal-title" id="Cancel<%=index %>Title">Cancel Commission</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                      <span aria-hidden="true">&times;</span>
                                    </button>
                                  </div>
                                  <div class="modal-body">
                                      <p>
                                        This will cancel the commission <span class="font-weight-bold font-italic">"<%=commission["title"] %>"</span>. Are you sure to do this action?
                                      </p>
                                      <small>
                                        (This will also return the full amount of artwork you've paid before)
                                      </small>
                                  </div>
                                  <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <a href="Actions/CancelCommission?commission_guid=<%=commission["commission_guid"] %>" class="btn btn-danger">Cancel Commission</a>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <%} else { %>
                            <!-- Button trigger modal -->
                            <button type="button" class="btn btn-secondary btn-sm mb-1 disabled" disabled>
                                Cancel Commission
                            </button>
                            <%} %>
                        <%}
                            else
                            { %>
                        <a href="ArtworkViewer?artwork_guid=<%=commission["artwork_guid"] %>" class="btn btn-success btn-sm mb-1">View Artwork</a>
                        <%} %>
	                </td>
                </tr>
                <%} %>
              </tbody>
            </table>
                </div>
        




    


<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Upload Artwork</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <h3 class="text-center">Publish Artwork</h3>
          <div class="input-group mb-3">
  <input type="file" class="form-control" id="inputGroupFile02">
  <label class="input-group-text" for="inputGroupFile02">Upload</label>
</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Publish</button>
      </div>
    </div>
  </div>
</div>

</asp:Content>
