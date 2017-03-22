<%@ page import="com.oqs.crud.UserDAO" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.userdetails.UserDetails" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script src="<c:url value="/resources/js/jquery.js" />"></script>

<style>
    <%@ include file="/resources/vendor/bootstrap/css/bootstrap.min.css" %>
    <%@ include file="/resources/vendor/font-awesome/css/font-awesome.min.css" %>
    <%@ include file="/resources/css/agency.min.css" %>
    <%@ include file="/resources/css/agency.css" %>
    <c:import url="https://fonts.googleapis.com/css?family=Montserrat:400,700"/>
    <c:import url="https://fonts.googleapis.com/css?family=Kaushan+Script"/>
    <c:import url="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic"/>
    <c:import url="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"/>
</style>


<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

<!-- jQuery -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Core JavaScript -->
<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

<!-- Plugin JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

<!-- Contact Form JavaScript -->
<script src="/resources/js/jqBootstrapValidation.js"></script>
<script src="/resources/js/contactUs.js"></script>

<!-- Theme JavaScript -->
<script src="/resources/js/agency.min.js"></script>

<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}"/>

<%
    Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
    UserDAO userDAO = WebApplicationContextUtils.getWebApplicationContext(application).getBean(UserDAO.class);
    String username;
    long userId = 0;

    if (principal instanceof UserDetails) {
        username = ((UserDetails) principal).getUsername();
    } else {
        username = principal.toString();
    }

    if (!username.equals("anonymousUser"))
        userId = userDAO.getUserIdByUsername(username);
    session.setAttribute("userId", userId);
%>

<nav id="mainNav" class="navbar navbar-default navbar-custom navbar-fixed-top">
    <div class="container">
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
            </button>
            <a class="navbar-brand page-scroll" href="/">OQS</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav navbar-right">
                <li class="hidden">
                    <a href="#page-top"></a>
                </li>
                <li>
                    <a class="page-scroll" href="/">Home page</a>
                </li>
                <li>
                    <a class="page-scroll" href="#services" id="organizations-btn" style="visibility: hidden">Organizations</a>
                </li>

                <li>
                    <a class="page-scroll" href="#about" id="about-btn" style="visibility: hidden">About</a>
                </li>
                <li>
                    <a class="page-scroll" href="#contact" id="contact-btn" style="visibility: hidden">Contact</a>
                </li>
                <script>
                    $(document).ready(function () {
                        if (${url == null}) {
                            $("#organizations-btn").css("visibility", "visible");
                            $("#about-btn").css("visibility", "visible");
                            $("#contact-btn").css("visibility", "visible");
                        }
                    });
                </script>
                <sec:authorize access="hasAnyRole('ROLE_USER', 'ROLE_ADMIN', 'ROLE_BUSINESS')">
                    <li>
                        <a class="page-scroll" href="/logout">Logout</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="/user/${userId}">My profile</a>
                    </li>
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    <li>
                        <a class="page-scroll" href="/authorization">Sign in</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="/registration">Sign up</a>
                    </li>
                </sec:authorize>

            </ul>
        </div>
    </div>
</nav>