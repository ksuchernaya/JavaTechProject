<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>authorization</title>

    <link href="<c:url value="/resources/css/oqs.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/bootstrap.css" />" rel="stylesheet">
</head>

<body id="page-top" class="index">

<jsp:include page="fragments/header.jsp"/>

<form class="registration-form" action="/login" method="post">
    <span id="invalid-data" style="color:red;"></span>
    <p><input type="text" class="form-control input-lg" name="email" placeholder="email"/></p>
    <p><input type="password" class="form-control input-lg" name="password" placeholder="password"/></p>
    <input type="submit" class="btn btn-lg btn-success" value="Sign in"/>
</form>

<jsp:include page="fragments/footer.jsp"/>

<script type="text/javascript">
    $(document).ready(function a() {
        if (location.href.endsWith("error"))
            document.getElementById("invalid-data").innerHTML = "You have entered incorrect data";
        else
            document.getElementById('invalid-data').innerHTML = "";
    });
</script>

</body>
</html>
