<%@ Page Async="true" EnableEventValidation="false" Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ipt101_gallery_project._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

     <!-- ======= Hero Section ======= -->
  <div id="hero" class="hero route bg-image" style="background-image: url('assets/img/artbg.jpg'); margin-top: -60px">
    <div class="overlay-itro"></div>
    <div class="hero-content display-table">
      <div class="table-cell">
        <div class="container">
          <!--<p class="display-6 color-d">Hello, world!</p>-->
          <h1 class="hero-title mb-4">Art Commission</h1>

          <!-- <p class="pt-3"><a class="btn btn-primary btn js-scroll px-4" href="#about" role="button">Learn More</a></p> -->
        </div>
      </div>
    </div>
  </div><!-- End Hero Section -->

  <main id="main">
    <!-- ======= Portfolio Section ======= -->
    <section id="work" class="portfolio-mf sect-pt4 route">
      <div class="container">
        <div class="row">

          <div class="col-sm-12">
            <div class="title-box text-center">
              <h3 class="title-a">
               Art Commission
              </h3>
              <p class="subtitle-a fs-1">
               Art Collections
              </p>
              <div class="line-mf"></div>
            </div>
          </div>
        </div>

      
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
    </section><!-- End Portfolio Section -->
  </main><!-- End #main -->

    
    <script>
        $(function () {
            var $nav = $(".navbar-fixed-top");
            $nav.addClass('navbar-transparent');

            $(document).scroll(function () {
                $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
            });
        });
    </script>
</asp:Content>
