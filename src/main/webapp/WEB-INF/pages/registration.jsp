<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>registration</title>
    <script src="<c:url value="/resources/js/jquery.js" />"></script>
    <script>
        <%@include file="/resources/js/registrationValidation.js" %>
        <%@include file="/resources/js/checkRole.js" %>
    </script>

    <style>
        <%@ include file="/resources/vendor/bootstrap/css/bootstrap.min.css" %>
        <%@ include file="/resources/vendor/font-awesome/css/font-awesome.min.css" %>
        <%@ include file="/resources/css/agency.min.css" %>
        <%@ include file="/resources/css/agency.css" %>
        <%@ include file="/resources/css/oqs.css" %>
        <%@ include file="/resources/css/bootstrap.css" %>
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

</head>

<body id="page-top" class="index">

<jsp:include page="fragments/header.jsp"/>

<form class="registration-form" id="registration-form" action="/registration" method="post"
      onsubmit="return validateForm()">


    <p><input type="email" class="form-control input-lg" name="email" placeholder="email" onblur="validateEmail()" onkeyup="checkEmailInDB()"/></p>
    <span class="error-msg" id="invalid-email"></span>


    <p><input type="password" class="form-control input-lg" name="password" placeholder="password"
              onblur="validatePassword()"/></p>
    <span class="error-msg" id="invalid-password" style="color:red;"></span>

    <p><input type="radio" id="radio_user" name="role" value="ROLE_USER" onclick="check()">
        <span style="font-size: 20px;">&nbsp;user&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp;</span></p>
    <p><input type="radio" id="radio_business" name="role" value="ROLE_BUSINESS" onclick="check()">
        <span style="font-size: 20px;">&nbsp;business</span></p>
    <span class="error-msg" id="invalid-role" style="color:red;"></span>

    <p><input type="tel" class="form-control input-lg" name="phone"
              onkeypress='return (event.charCode >= 48 && event.charCode <= 57) || event.charCode==45'
              placeholder="phone" maxlength="200"/></p>
    <div id="user" style="display: none">
        <p><input type="text" class="form-control input-lg" name="firstname" placeholder="firstname" maxlength="200"/></p>
        <p><input type="text" class="form-control input-lg" name="lastname" placeholder="lastname" maxlength="200"/></p>
    </div>
    <div id="business" style="display: none">
        <p><input type="text" class="form-control input-lg" name="name" placeholder="name" maxlength="200"/></p>
        <p><select class="form-control input-lg" id="typeComboBoxId" name="typeComboBoxName">
            <option value="" disabled selected>-- Select type --</option>
            <c:forEach items="${types}" var="type">
                <option value="${type.name}" style="font-size: 20px;">${type.name}</option>
            </c:forEach>
        </select></p>
        <span class="error-msg" id="invalid-type" style="color:red;"></span>
        <p><input type="text" class="form-control input-lg" name="address" placeholder="address" maxlength="200"/></p>
        <p><textarea style="resize: none" class="form-control input-lg" name="description" rows="3" placeholder="description" maxlength="1000"></textarea></p>
    </div>
    <input type="submit" id="sign-up-btn" class="btn btn-lg btn-success" value="  Sign up  "/>
</form>
<jsp:include page="fragments/footer.jsp"/>
</body>
</html>