function check() {
    var role = $('input[name=role]:checked').val();

    document.getElementById("invalid-type").innerHTML = "";

    if (role == "ROLE_USER") {
        document.getElementsByName("name")[0].value = '';
        document.getElementsByName("typeComboBoxName")[0].value = '';
        document.getElementsByName("description")[0].value = '';
        document.getElementsByName("address")[0].value = '';
        document.getElementById("user").style.display = 'block';
        document.getElementById("business").style.display = 'none';
    }
    if (role == "ROLE_BUSINESS") {
        document.getElementsByName('firstname')[0].value = '';
        document.getElementsByName("lastname")[0].value = '';
        document.getElementById("user").style.display = 'none';
        document.getElementById("business").style.display = 'block';
    }
}