<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>organizations</title>
    <script src="<c:url value="/resources/js/jquery.js" />"></script>
    <script>
        <%@include file="/resources/js/sortTable.js" %>
    </script>
    <style>
        <%@ include file="/resources/css/oqs.css" %>
        <%@ include file="/resources/css/bootstrap.css" %>
    </style>
</head>
<body>
<div class="wrapper">
    <jsp:include page="fragments/header.jsp"/>
    <div class="content">

        <p class="title">List of organizations</p>

        <select class="btn btn-default dropdown-toggle" style="width: 10%" id="sortByDropDownId"
                name="sortByDropDownName">
            <option value="0">All</option>
            <c:forEach items="${types}" var="type">
                <option value="${type.id}">${type.name}</option>
            </c:forEach>
        </select>

        <script type="text/javascript">

            $(document).ready(function () {
                $("#sortByDropDownId").val("${typeId}");
            });

            $("#sortByDropDownId").change(function () {
                var typeId = $(this).val();
                $.ajax({
                    type: "GET",
                    url: 'organizations-sort-by',
                    data: "typeId=" + typeId,
                    success: function (data) {
                        $("#organizationTable tr").remove();
                        var table = document.getElementById("organizationTable");
                        var tr = document.createElement('tr');
                        var thName, thType, thAddress, thTelephone;
                        appendTh(tr, thName, "Name");
                        appendTh(tr, thType, "Type");
                        appendTh(tr, thAddress, "Address");
                        appendTh(tr, thTelephone, "Telephone");
                        table.tHead.appendChild(tr);
                        for (var i = 0; i < data.length; i++) {
                            tr = document.createElement('tr');
                            var a = document.createElement('a');
                            var td = document.createElement('td');
                            a.innerHTML = data[i].smplName;
                            a.style.color = "blue";
                            td.appendChild(a);
                            a.href = "/organization/" + data[i].smplId;
                            tr.appendChild(td);
                            var tdType = document.createElement('td');

                            //TODO data[i].type.id
                            tdType.innerHTML = data[i].smplType; //PROBLEMS WITH data[i].type.name !!! don't work, data[i].type = undefined
                            tr.appendChild(tdType);
                            var tdAddress = document.createElement('td');
                            tdAddress.innerHTML = data[i].smplAddress;
                            tr.appendChild(tdAddress);
                            var tdPhone = document.createElement('td');
                            tdPhone.innerHTML = data[i].smplTelephone;
                            tr.appendChild(tdPhone);
                            table.tBodies[0].appendChild(tr);
                        }
                    },
                    error: function (xhr, textStatus) {
                        alert([xhr.status, textStatus]);
                    }
                })
            });

            function appendTh(tr, th, name) {
                th = document.createElement('th');
                th.innerHTML = name;
                tr.appendChild(th);
            }

        </script>

        <table id="organizationTable" class="sortable table table-bordered" style="background-color: rgba(216, 191, 216, 0.8)">
            <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Address</th>
                <th>Telephone</th>
            </tr>
            <c:forEach items="${organizations}" var="organization">
                <tr>
                    <td>
                        <a style="color: blue" href="<spring:url value="/organization/{organizationId}" htmlEscape="true">
                    <spring:param name="organizationId" value="${organization.id}"/></spring:url>">
                                ${organization.name}
                        </a>
                    </td>
                    <td>${organization.type.name}</td>
                    <td>${organization.address}</td>
                    <td>${organization.phone}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <jsp:include page="fragments/footer.jsp"/>
</div>
</body>
</html>