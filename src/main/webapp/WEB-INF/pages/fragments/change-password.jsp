<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="<c:url value="/resources/js/registrationValidation.js" />"></script>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.username" var="currentUsername"/>
</sec:authorize>

<c:if test="${user.role == 'ROLE_USER'}">
    <c:set var="userId" value="${user.id}"></c:set>
    <c:set var="username" value="${user.email}"></c:set>
</c:if>
<c:if test="${organization.role == 'ROLE_BUSINESS'}">
    <c:set var="userId" value="${organization.id}"></c:set>
    <c:set var="username" value="${organization.email}"></c:set>
</c:if>

<p id="request-on-password-change" style="color:red;"></p>
<c:if test="${currentUsername == username}">
    <input type="button" class="btn btn-lg btn-info" style="margin-left: 50px; width: 200px" id="change-user-password"
           value="Change password" onclick="userChangePassword()">
</c:if>

<div id="change-password-form" style="display: none">
    <p><input type="password" class="form-control input-lg" style="width: 250px"
              name="old-password" placeholder="old password"/></p>
    <p><input type="password" class="form-control input-lg" style="width: 250px"
              name="new-password1" placeholder="new password" onblur="validatePassword()"/></p>
    <span id="invalid-password" style="color:red;"></span>
    <p><input type="password" class="form-control input-lg" style="width: 250px"
              name="new-password2" placeholder="repeat new password" onblur="validatePassword()"/></p>
    <input type="button" class="btn btn-lg btn-success" style="float: left;" id="save-user-password" value="Save changes">
    <input type="button" class="btn btn-lg btn-warning" style="margin-left: 7px" id="cancel-user-password" value="Cancel">
</div>

<%--скрипт для изменения пароля--%>
<script type="text/javascript">
    function userChangePassword() {
        document.getElementById("request-on-password-change").innerHTML = "";
        document.getElementById("change-user-password").style.display = 'none';
        document.getElementById("change-password-form").style.display = 'block';
        document.getElementById("change-password-form").style.marginLeft = '50px';
    }

    $("#save-user-password").click(function () {
        var oldpassword = document.getElementsByName("old-password")[0].value;
        var newpassword1 = document.getElementsByName("new-password1")[0].value;
        var newpassword2 = document.getElementsByName("new-password2")[0].value;

        $.ajax({
            type: "POST",
            url: '/user/${userId}/change-password',
            data: {"oldpassword": oldpassword, "newpassword1": newpassword1, "newpassword2": newpassword2},
            dataType: 'text',
            success: function () {
                document.getElementById("request-on-password-change").innerHTML = "Password changed successfully.";
                cleanAndCloseFields();
            },
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });

    $("#cancel-user-password").click(function () {
        cleanAndCloseFields();
    });
    
    function cleanAndCloseFields () {
        document.getElementById("change-user-password").style.display = 'block';
        document.getElementById("change-password-form").style.display = 'none';
        document.getElementsByName("old-password")[0].value = "";
        document.getElementsByName("new-password1")[0].value = "";
        document.getElementsByName("new-password2")[0].value = "";
    }
</script>