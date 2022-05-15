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

      
          <div class="row">
               <div class="col-sm-4">
                  <a href="./ArtworkViewer" class="text-dark">
                <div class="card shadow">
                    <img src="assets/img/work-1.jpg" class="card-img-top" alt="..." style="max-height: 15rem;" >
                  <div class="card-body">
                    <h5 class="card-title">Art 1</h5>
                      <div class="w-more">
                      <span class="w-ctegory">Artist Name</span> / <span class="w-date">Date Created</span>
                    </div>
                  </div>
                </div>
                    </a>
              </div>

              <div class="col-sm-4">
                  <a href="./ArtworkViewer" class="text-dark">
                <div class="card shadow">
                    <img src="assets/img/work-2.jpg" class="card-img-top" alt="..." style="max-height: 15rem;">
                  <div class="card-body">
                    <h5 class="card-title">Art 2</h5>
                      <div class="w-more">
                      <span class="w-ctegory">Artist Name</span> / <span class="w-date">Date Created</span>
                    </div>
                  </div>
                </div>
                    </a>
              </div>

                 <div class="col-sm-4">
                  <a href="./ArtworkViewer" class="text-dark">
                <div class="card shadow">
                    <img src="assets/img/work-3.jpg" class="card-img-top" alt="..." style="max-height: 15rem;">
                  <div class="card-body">
                    <h5 class="card-title">Art 3</h5>
                      <div class="w-more">
                      <span class="w-ctegory">Artist Name</span> / <span class="w-date">Date Created</span> 
                    </div>
                  </div>
                </div>
                    </a>
              </div>

            </div>

      </div>
    </section><!-- End Portfolio Section -->

        <nav aria-label="..." class="py-5">
          <ul class="pagination justify-content-center">
            <li class="page-item disabled">
              <span class="page-link">Previous</span>
            </li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item active">
              <span class="page-link">
                2
                <span class="sr-only">(current)</span>
              </span>
            </li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item">
              <a class="page-link" href="#">Next</a>
            </li>
          </ul>
        </nav>
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
