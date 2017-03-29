<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>organization</title>

    <script src="<c:url value="/resources/js/jquery.js" />"></script>
    <script src="<c:url value="/resources/js/popup.js" />"></script>
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

        <c:if test="${username == organization.email}">
            <p class="simple-text">Hello! You are logged in as ${organization.email}</p>
        </c:if>
        <p class="simple-text">Name: ${organization.name}</p>
        <p class="simple-text">Type: ${organization.type.name}</p>
        <p class="simple-text">Address: ${organization.address}</p>
        <p class="simple-text">Telephone: ${organization.phone}</p>
        <p class="simple-text">Services:</p>
        <ul id="service-list">
            <c:forEach items="${services}" var="service">
                <li id="li${service.id}" style="margin-left: 50px"><a
                        href="/organization/${organization.id}/service/${service.id}"
                        class="link" htmlEscape="true">${service.name}</a></li>
            </c:forEach>
        </ul>
        <p class="simple-text">${organization.description}</p>

        <c:if test="${username == organization.email}">
            <br>
            <p class="simple-text">Add service:</p>
            <select class="form-control input-lg" style="margin-left: 50px; width: 200px; float: left"
                    id="serviceComboBoxId" name="serviceComboBoxName">
                <option value="0" selected="true" disabled="disabled">-- Choose service --</option>
                <c:forEach items="${servicesByType}" var="service">
                    <option value="${service.id}">${service.name}</option>
                </c:forEach>
            </select>
            <input type="button" class="btn btn-lg btn-success" style="width: 200px; margin-left: 10px"
                   value="Add service" id="add-service">

            <p class="simple-text">Or you can add your own service:</p>
            <input type="text" class="form-control input-lg"
                   style="margin-left: 50px; margin-bottom: 10px; width: 200px; float: left" name="serviceName"
                   placeholder="Service">
            <input type="button" class="btn btn-lg btn-success"
                   style="width: 200px; margin-left: 10px; margin-bottom: 10px" value="Add new service"
                   id="add-new-service">

            <p>
                <select class="form-control input-lg" style="margin-left: 50px; width: 200px; float: left"
                        id="serviceByBsnComboBoxId" name="serviceByBsnComboBoxName">
                    <option value="0" selected="true">-- Choose service --</option>
                    <c:forEach items="${services}" var="service">
                        <option value="${service.id}">${service.name}</option>
                    </c:forEach>
                </select>
                <input type="button" class="btn btn-lg btn-danger" style="width: 200px; margin-left: 10px"
                       value="Delete service" id="delete-service">
            </p>

            <div id="mastersDropDownForService" class="mastersDropDownForService" style="display: none">
                <div class="selectBox" onclick="showMasterCheckboxes()">
                    <select class="form-control input-lg" style="margin-bottom: 10px">
                        <option>Select master for service</option>
                    </select>
                    <div class="overSelect"></div>
                </div>
                <div id="checkboxes1">
                    <label for="checkbox1" class="label"><input type="checkbox" id="checkbox1" name="service"
                                                                value="ha1"/>First
                        checkbox</label>
                </div>
                <input type="button" class="btn btn-lg btn-success" style="width: 200px; margin-left: 100px"
                       id="save-service-master" style="width: 100px" value="Save changes">
            </div>

            <br>
            <p class="simple-text">Add master:</p>
            <p>
                <input type="text" class="form-control input-lg" style="width: 200px; margin-left: 50px; float: left"
                       name="master" placeholder="Master">
                <input type="button" class="btn btn-lg btn-success" style="width: 200px; margin-left: 10px"
                       value="Add new master" id="add-master">
            </p>

            <p><select class="form-control input-lg" style="margin-left: 50px; width: 200px; float: left"
                       id="masterComboBoxId" name="masterComboBoxName">
                <option value="0" selected="true">-- Choose master --</option>
                <c:forEach items="${allMasters}" var="master">
                    <option value="${master.id}">${master.name}</option>
                </c:forEach>
            </select>
                <input type="button" class="btn btn-lg btn-danger" style="width: 200px; margin-left: 10px"
                       value="Delete master" id="delete-master">
            </p>

            <div id="changeMasterName" style="display: none">
                <input type="text" class="form-control input-lg" style="width: 200px; float: left; margin-left: 50px"
                       id="newMasterName">
                <input type="button" class="btn btn-lg btn-warning"
                       style="margin-left: 10px; margin-bottom: 10px; width: 200px" id="saveNewMasterName"
                       value="Change name">
            </div>

            <div id="servicesDropDownForMaster" class="servicesDropDownForMaster" style="display: none">
                <div class="selectBox" onclick="showCheckboxes()">
                    <select class="form-control input-lg" style="margin-bottom: 10px">
                        <option>Select service for master</option>
                    </select>
                    <div class="overSelect"></div>
                </div>
                <div id="checkboxes">
                    <label for="checkbox2" class="label"><input type="checkbox" id="checkbox2" name="service"
                                                                value="ha1"/>First
                        checkbox</label>
                </div>
                <input type="button" class="btn btn-lg btn-success" style="width: 200px; margin-left: 100px"
                       id="save-master-service" value="Save changes">
            </div>
            <br>
            <div class="mastersSchedule" style="min-height: 50px">
                <span class="simple-text" style="margin-bottom: 20px; float: left">Master's schedule: </span>
                <select id="mastersScheduleDropDown" class="form-control input-md"
                        style="float: left; width: 200px; margin-left: 10px">
                    <option value="0" selected="true">-- Choose master --</option>
                    <c:forEach items="${allMasters}" var="master">
                        <option value="${master.id}">${master.name}</option>
                    </c:forEach>
                </select>
                <table id="mastersScheduleTable" class="sortable table table-bordered"
                       style="background-color: rgba(216, 191, 216, 0.8); margin-left: 50px; width: 90%; display: none">
                    <th></th>
                </table>
            </div>

            <br>
            <jsp:include page="fragments/change-password.jsp"/>
        </c:if>
    </div>
    <br>
    <br>
    <br>
    <br>
    <jsp:include page="fragments/footer.jsp"/>
</div>
<%--показать чекбоксы для сервиса--%>
<script>
    var expanded = false;
    function showMasterCheckboxes() {
        var checkboxes = document.getElementById("checkboxes1");
        if (!expanded) {
            checkboxes.style.display = "block";
            expanded = true;
        } else {
            checkboxes.style.display = "none";
            expanded = false;
        }
    }
</script>

<%--добавление сервиса, добавление нового сервиса, изменение сервис-мастер, удаление сервиса--%>
<script>
    var serviceId;
    var selected;

    $("#add-service").click(function () {
        serviceId = document.getElementById("serviceComboBoxId").value;
        $.ajax({
            type: "POST",
            url: "/add-service/" + ${organization.id},
            data: "serviceId=" + serviceId,
            success: function (data) {
                document.getElementById("serviceComboBoxId").value = "0";
                addServiceLi(data);
                $("#serviceByBsnComboBoxId").append('<option value="' + serviceId + '">' + data + '</option>');
            },
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });

    $("#add-new-service").click(function () {
        var serviceName = document.getElementsByName("serviceName")[0].value;
        $.ajax({
            type: "POST",
            url: "/add-new-service/" + ${organization.id},
            data: "serviceName=" + serviceName,
            success: function (data) {
                document.getElementsByName("serviceName")[0].value = "";
                addServiceLi(serviceName);
                $("#serviceByBsnComboBoxId").append('<option value="' + data + '">' + serviceName + '</option>');
                $("#serviceComboBoxId").append('<option value="' + data + '">' + serviceName + '</option>');
            },
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });

    function addServiceLi(data) {
        if (data != "") {
            var a = document.createElement('a');
            var li = document.createElement('li');
            var serviceList = document.getElementById("service-list");
            a.textContent = data;
            a.href = "/organization/" + ${organization.id} +"/service/" + serviceId;
            li.appendChild(a);
            li.setAttribute("id", "li" + serviceId);
            serviceList.appendChild(li);
        }
    }

    $("#serviceByBsnComboBoxId").change(function () {
        serviceId = $(this).val();
        var serviceName = $("#serviceByBsnComboBoxId option:selected").text();
        if (serviceId != 0) {
            var checkboxes = document.getElementById('checkboxes1');
            while (checkboxes.firstChild) {
                checkboxes.removeChild(checkboxes.firstChild);
            }
            $.ajax({
                type: "GET",
                url: "/addCheckBoxesForService/${organization.id}/" + serviceId,
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data[0].length; i++) {
                        var checkbox = document.createElement('input');
                        checkbox.type = "checkbox";
                        checkbox.name = "service";
                        checkbox.value = data[0][i].id;
                        checkbox.id = data[0][i].id + "checkbox";
                        var label = document.createElement('label');
                        label.htmlFor = data[0][i].id + "checkbox";
                        label.appendChild(document.createTextNode(data[0][i].name));
                        checkboxes.appendChild(checkbox);
                        checkboxes.appendChild(label);
                        for (var j = 0; j < data[1].length; j++)
                            if (data[0][i].id == data[1][j].id)
                                document.getElementById(data[0][i].id + "checkbox").checked = true;
                    }
                },
                error: function (xhr, textStatus) {
                    alert([xhr.status, textStatus]);
                }
            });

            document.getElementById("mastersDropDownForService").style.display = 'block';
        } else {
            document.getElementById("mastersDropDownForService").style.display = 'none';
        }
    });

    $("#save-service-master").click(function () {
        selected = [];
        serviceId = $("#serviceByBsnComboBoxId").val();
        $('#checkboxes1 input:checked').each(function () {
            selected.push($(this).val());
        })
        $.ajax({
            type: "POST",
            url: "/change-service-master/" + serviceId,
            data: "selected=" + selected,
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });

    $("#delete-service").click(function () {
        $.ajax({
            type: "POST",
            url: "/delete-service/" + ${organization.id},
            data: "serviceId=" + serviceId,
            success: function () {
                var li = document.getElementById("li" + serviceId);
                li.parentNode.removeChild(li);
                alert(serviceId);
                $("#serviceByBsnComboBoxId option[value='" + serviceId + "']").remove();
                document.getElementById("mastersDropDownForService").style.display = 'none';
                document.getElementById("save-service-master").style.display = 'none';
            },
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });
</script>

<%--показать чекбоксы для мастера--%>
<script>
    var expanded = false;
    function showCheckboxes() {
        var checkboxes = document.getElementById("checkboxes");
        if (!expanded) {
            checkboxes.style.display = "block";
            expanded = true;
        } else {
            checkboxes.style.display = "none";
            expanded = false;
        }
    }
</script>

<%--добавление мастера, изменение мастер-сервис, имя мастера, удаление мастера--%>
<script>
    var masterId;
    var selected = [];

    $("#add-master").click(function () {
        var masterName = document.getElementsByName("master")[0].value;
        $.ajax({
            type: "POST",
            url: "/add-master/" + ${organization.id},
            data: "masterName=" + masterName,
            success: function (data) {
                document.getElementsByName("master")[0].value = "";
                $("#masterComboBoxId").append('<option value="' + data + '">' + masterName + '</option>');
            },
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });

    $("#masterComboBoxId").change(function () {
        masterId = $(this).val();
        var masterName = $("#masterComboBoxId option:selected").text();
        if (masterId != 0) {
            document.getElementById("newMasterName").value = masterName;
            var checkboxes = document.getElementById('checkboxes');
            while (checkboxes.firstChild) {
                checkboxes.removeChild(checkboxes.firstChild);
            }
            $.ajax({
                type: "GET",
                url: "/addCheckBoxes/${organization.id}/" + masterId,
                data: "selected=" + selected,
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data[0].length; i++) {
                        var checkbox = document.createElement('input');
                        checkbox.type = "checkbox";
                        checkbox.name = "service";
                        checkbox.value = data[0][i].id;
                        checkbox.id = data[0][i].id + "checkbox";
                        var label = document.createElement('label');
                        label.htmlFor = data[0][i].id + "checkbox";
                        label.appendChild(document.createTextNode(data[0][i].name));
                        checkboxes.appendChild(checkbox);
                        checkboxes.appendChild(label);
                        for (var j = 0; j < data[1].length; j++)
                            if (data[0][i].id == data[1][j].id)
                                document.getElementById(data[0][i].id + "checkbox").checked = true;
                    }
                },
                error: function (xhr, textStatus) {
                    alert([xhr.status, textStatus]);
                }
            });

            document.getElementById("changeMasterName").style.display = 'block';
            document.getElementById("servicesDropDownForMaster").style.display = 'block';
            document.getElementById("save-master-service").style.display = 'block';

        } else {
            document.getElementById("changeMasterName").style.display = 'none';
            document.getElementById("servicesDropDownForMaster").style.display = 'none';
            document.getElementById("save-master-service").style.display = 'none';
        }
    });

    $("#delete-master").click(function () {
        $.ajax({
            type: "POST",
            url: "/delete-master/",
            data: "masterId=" + masterId,
            success: function () {
                $("#masterComboBoxId option[value='" + masterId + "']").remove();
                document.getElementById("changeMasterName").style.display = 'none';
                document.getElementById("servicesDropDownForMaster").style.display = 'none';
                document.getElementById("save-master-service").style.display = 'none';
            },
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });

    $("#save-master-service").click(function () {
        var nonSelected = [];
        selected = [];
        masterId = $("#masterComboBoxId").val();
        $('#checkboxes input:checked').each(function () {
            selected.push($(this).val());
        });
        $('#checkboxes input:not(:checked)').each(function () {
            nonSelected.push($(this).val());
        });

        $.ajax({
            type: "POST",
            url: "/change-master-service/" + masterId,
            data: "selected=" + selected + "&nonSelected=" + nonSelected,
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });

    $("#saveNewMasterName").click(function () {
        var newMasterName = document.getElementById("newMasterName").value;
        $.ajax({
            type: "POST",
            url: "/organization/${organization.id}/change-master-name/" + masterId,
            data: "newMasterName=" + newMasterName,
            dataType: 'json',
            success: function (masters) {
                document.getElementById("newMasterName").value = '';
                document.getElementById("changeMasterName").style.display = 'none';

                var masterElement = document.getElementById("masterComboBoxId");
                masterElement.length = 0;
                masterElement.options[0] = new Option('--Choose master--', 0);
                masterElement.selectedIndex = 0;
                var masters = masters;
                for (var i = 0; i < masters.length; i++) {
                    masterElement.options[masterElement.length] = new Option(masters[i].name, masters[i].id);
                }
            },
            error: function (xhr, textStatus) {
                alert([xhr.status, textStatus]);
            }
        })
    });
</script>
<%--показать расписание для мастера--%>
<script>
    $("#mastersScheduleDropDown").change(function () {
                var masterId = $(this).val();
                $.ajax({
                    type: "GET",
                    url: '/masters-schedule',
                    data: "masterId=" + masterId,
                    success: function (data) {
                        $("#mastersScheduleTable tr").remove();
                        var table = document.getElementById("mastersScheduleTable");
                        if (data.length != 0) {
                            table.style.display = "block";
                            var tr = document.createElement('tr');
                            var thService, thDate, thEmail;
                            appendTh(tr, thService, "Service");
                            appendTh(tr, thDate, "Date");
                            appendTh(tr, thEmail, "Email");
                            table.tHead.appendChild(tr);
                            for (var i = 0; i < data.length; i++) {
                                tr = document.createElement('tr');
                                var tdService = document.createElement('td');
                                tdService.innerHTML = data[i].simpleService;
                                tr.appendChild(tdService);
                                var tdDate = document.createElement('td');
                                tdDate.innerHTML = data[i].simpleDate;
                                tr.appendChild(tdDate);
                                var tdEmail = document.createElement('td');
                                tdEmail.innerHTML = data[i].simpleUser;
                                tr.appendChild(tdEmail);
                                table.tBodies[0].appendChild(tr);
                            }
                        } else {
                            table.style.display = "none";
                        }

                    },
                    error: function (xhr, textStatus) {
                        alert([xhr.status, textStatus]);
                    }
                })
            }
    );

    function appendTh(tr, th, name) {
        th = document.createElement('th');
        th.innerHTML = name;
        tr.appendChild(th);
    }
</script>
</body>
</html>
