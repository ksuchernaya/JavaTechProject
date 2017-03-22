<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>my-profile</title>

    <script src="<c:url value="/resources/js/jquery.js" />"></script>
    <script src="<c:url value="/resources/js/sortTable.js" />"></script>
    <link href="<c:url value="/resources/css/oqs.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/bootstrap.css" />" rel="stylesheet">
</head>

<body>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.username" var="username"/>
</sec:authorize>

<div class="wrapper">
    <jsp:include page="fragments/header.jsp"/>
    <div class="content">
        <sec:authorize access="hasRole('ROLE_USER')">
            <p class="title">My profile</p>
            <div id="my-profile-user-info">
                <p class="simple-text">Hello, <span id="firstname">${user.firstname}</span><span
                        id="lastname">&nbsp;${user.lastname}</span></p>
                <p class="simple-text" id="email">Email: ${user.email}</p>
                <p class="simple-text" id="phone">Telephone: ${user.phone}</p>
            </div>
            <div id="my-profile-user-info-change" style="display: none;">
                <p><input type="text" class="form-control input-lg" name="new-firstname" style="margin-left: 50px; width: 250px" value="${user.firstname}"></p>
                <p><input type="text" class="form-control input-lg" name="new-lastname" style="margin-left: 50px; width: 250px" value="${user.lastname}"></p>
                <p><input type="text" class="form-control input-lg" name="new-phone" style="margin-left: 50px; width: 250px" value="${user.phone}"></p>
                <input type="button" class="btn btn-lg btn-success" id="save-user-info-btn" style="margin-left: 50px; float: left" value="Save changes">
                <input type="button" class="btn btn-lg btn-warning" id="cancel-user-info-btn" style="margin-left: 7px" value="Cancel">
            </div>

            <c:if test="${username == user.email}">
                <input type="button" class="btn btn-lg btn-info" id="edit-user-info-btn" style="margin-left: 50px; width: 200px" value="Edit personal data">
            </c:if>

            <jsp:include page="fragments/change-password.jsp"/>

            <%--скрипт для изменения данных юзера--%>
            <script>
                $("#edit-user-info-btn").click(function () {
                    document.getElementById("edit-user-info-btn").style.display = 'none';
                    document.getElementById("my-profile-user-info").style.display = 'none';
                    document.getElementById("my-profile-user-info-change").style.display = 'block';
                });

                $("#save-user-info-btn").click(function () {
                    document.getElementById("edit-user-info-btn").style.display = 'block';
                    document.getElementById("my-profile-user-info").style.display = 'block';
                    document.getElementById("my-profile-user-info-change").style.display = 'none';
                    var firstname = document.getElementsByName("new-firstname")[0].value;
                    var lastname = document.getElementsByName("new-lastname")[0].value;
                    var phone = document.getElementsByName("new-phone")[0].value;
                    $.ajax({
                        type: "POST",
                        url: '/user/${user.id}/change-info',
                        data: {"firstname": firstname, "lastname": lastname, "phone": phone},
                        dataType: 'text',
                        success: function (data) {
                            var info = data.split(",");
                            document.getElementById("firstname").innerHTML = info[0];
                            document.getElementById("lastname").innerHTML = "&nbsp;" + info[1];
                            document.getElementById("phone").innerHTML = "Telephone: " + info[2];
                        },
                        error: function (xhr, textStatus) {
                            alert([xhr.status, textStatus]);
                        }
                    })
                });

                $("#cancel-user-info-btn").click(function () {
                    document.getElementById("edit-user-info-btn").style.display = 'block';
                    document.getElementById("my-profile-user-info").style.display = 'block';
                    document.getElementById("my-profile-user-info-change").style.display = 'none';
                });
            </script>

            <c:if test="${!empty schedule}">
                <p class="title">My bookings</p>
                <table class="sortable table table-bordered" style="background-color: rgba(216, 191, 216, 0.8)">
                    <tr>
                        <th>Organization</th>
                        <th>Service</th>
                        <th>Master</th>
                        <th>Date</th>
                        <th>Time</th>
                    </tr>
                    <c:forEach items="${schedule}" var="sch">
                        <tr id="${sch.id}">
                            <c:set value="${sch.id}" var="a"></c:set>
                            <td>${sch.bsn.name}</td>
                            <td>${sch.service.name}</td>
                            <td>${sch.master.name}</td>
                            <td><fmt:formatDate value="${sch.date}" pattern="dd-MM-yyyy"/></td>
                            <td>${sch.time}</td>
                            <c:if test="${username == user.email}">
                                <td>
                                    <input type="button" class="btn btn-md btn-danger" value="Delete">
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </table>
            </c:if>
        </sec:authorize>

        <script>
            $(".delete-booking").click(function () {
                var bookingId = $(this).closest('tr').attr('id');
                $.ajax({
                    type: "POST",
                    url: "/delete-booking/" + bookingId,
                    success: $(this).closest("tr").remove(),
                    error: function (xhr, textStatus) {
                        alert([xhr.status, textStatus]);
                    }
                })
            });
        </script>

    </div>
    <jsp:include page="fragments/footer.jsp"/>
</div>
</body>
</html>
