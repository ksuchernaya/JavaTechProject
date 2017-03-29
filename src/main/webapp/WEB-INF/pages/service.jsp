<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Service</title>
    <style>
    <%--<%@ include file="/resources/css/oqs.css" %>--%>
    <%@ include file="/resources/css/bootstrap.css" %>
    <%@ include file="/resources/css/bootstrap-datepicker.css" %>

    </style>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(function () {
            $("#datepicker").datepicker({dateFormat: 'dd-mm-yy'});
        });
    </script>

</head>
<body>
<sec:authorize access="isAuthenticated()">
    <sec:authentication var="user" property="principal.username"/>
</sec:authorize>

<%--<jsp:include page="fragments/header.jsp"/>--%>


<div class="service-middle">
    ${organization.name}

    <form action="/booking-add/${organization.id}/${user}/${service.id}" method="post"
          onsubmit=" return confirmBooking();">

        <p>${service.name}</p>

        <select id="masterDropDownListId" name="masterDropDownListName">
            <option value="" disabled selected>-- Choose master --</option>
            <c:forEach items="${masters}" var="master">
                <option value="${master.id}" name="${master.name}">${master.name}</option>
            </c:forEach>
        </select>

        <p>Date: <input  type="text" id="datepicker" class="datepicker" name="dateName" readonly></p>



        <p>Choose comfortable time:
            <select id="timeDropDownListId" name="timeDropDownListName">
                <option disabled selected>-- Time --</option>
            </select>
        </p>

        <script type="text/javascript">
            var masterId;
            var date;
            var time;

            $("#masterDropDownListId").change(function () {
                masterId = $(this).val();
                if (document.getElementById('datepicker').value != "") {
                    fillTimeDropDownList();
                }
            });

            $("#datepicker").change(function () {
                date = $(this).val();
                if (document.getElementById('masterDropDownListId').value != "" && date != "") {
                    fillTimeDropDownList();
                }
            });

            $("#timeDropDownListId").change(function () {
                time = $(this).val();
            });

            function confirmBooking() {
                var masterDropDownElement = document.getElementById("masterDropDownListId");
                var masterName = masterDropDownElement.options[masterDropDownElement.selectedIndex].text;
                if (confirm("Your booking:\n" + "master: " + masterName + "\ndate: " + date + "\ntime: " + time))
                    return true;
                else
                    return false;
            }
            function fillTimeDropDownList() {
                $.ajax({
                    type: "GET",
                    url: '/scheduleByMaster',
                    data: {"masterId": masterId, "date": date},
                    success: function (data) {
                        var timeElement = document.getElementById("timeDropDownListId");
                        timeElement.length = 1;
                        for (var i = 0; i < data[0].length; i++) {
                            var option = new Option(data[0][i], data[0][i]);
                            for (var j = 0; j < data[1].length; j++) {
                                if (data[0][i] == data[1][j])
                                    option.disabled = true;
                            }
                            timeElement.options[timeElement.length] = option;
                        }
                    },
                    error: function (xhr, textStatus) {
                        alert([xhr.status, textStatus]);
                    }
                })
            }
        </script>

        <p><textarea name="bookingComment" placeholder="Write your wishes here"></textarea></p>

        <sec:authorize access="hasRole('ROLE_USER')">
            <input type="submit" value="Booked">
        </sec:authorize>

    </form>
</div>
</body>
</html>
