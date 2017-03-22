<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>admin-page</title>
</head>
<body>

<h1>Admin page</h1>

<select id="serviceDropDownListId" name="serviceDropDownListName">
    <c:forEach items="${services}" var="service">
        <option value="${service.id}">${service.name}</option>
    </c:forEach>
</select>
<form action="/">

</form>
<table class="sortable">
    <tr>
        <th>USER ID</th>
        <th>USER/BSN EMAIL</th>
        <th>ROLE</th>
        <th>USER FIRSTNAME</th>
        <th>USER LASTNAME</th>
        <th>PHONE</th>
        <th>BSN NAME</th>
        <th>BSN TYPE</th>

    </tr>
    <c:forEach items="${users}" var="user">
        <tr>
            <td>${user.id}</td>
            <td>${user.email}</td>
            <td>${user.role}</td>
            <td>${user.firstname}</td>
            <td>${user.lastname}</td>
            <td>${user.phone}</td>
            <td>${user.name}</td>
            <td>${user.type.name}</td>

        </tr>
    </c:forEach>
</table>

</body>
</html>
