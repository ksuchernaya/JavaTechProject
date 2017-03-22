function validateEmail() {
    var email = document.forms["registration-form"]["email"].value;

    if (email == null || email == "") {
        document.getElementById("invalid-email").innerHTML = "email is required";
        return false;
    } else if (email.length < 5 || email.length > 63 || email.indexOf("@") < 0 || email.indexOf(".") < 0 ||
        email.indexOf("@") > email.indexOf(".")) {
        document.getElementById("invalid-email").innerHTML = "invalid email";
        return false;
    } else {
        document.getElementById("invalid-email").innerHTML = "";
        return true;
    }
}

function checkEmailInDB() {
    var email = document.forms["registration-form"]["email"].value;
    
    $.ajax({
        type: "POST",
        url: '/check-user-in-db',
        data: "email=" + email,
        success: function (data) {
            if(data == true)
                document.getElementById("invalid-email").innerHTML = "email is already used";
            else
                document.getElementById("invalid-email").innerHTML = "";
        },
        error: function (xhr, textStatus) {
            alert([xhr.status, textStatus]);
        }

    })
}

function validatePassword() {
    var password = document.forms["registration-form"]["password"].value;

    if (password == null || password == "") {
        document.getElementById("invalid-password").innerHTML = "password is required";
        return false;
    } else if (/^[a-zA-Z1-9]+$/.test(password) === false) {
        document.getElementById("invalid-password").innerHTML = "password must contain latin letters only";
        return false;
    } else if (password.length < 6 || password.length > 50) {
        document.getElementById("invalid-password").innerHTML = "password must contain 6-50 symbols";
        return false;
    } else if (/^[A-Z]+$/.test(password.substr(0, 1)) === false) {
        document.getElementById("invalid-password").innerHTML = "first letter must be in upper case";
        return false;
    } else {
        document.getElementById("invalid-password").innerHTML = "";
        return true;
    }
}

function validateRole() {
    var role = $('input[name=role]:checked').val();

    if (role != undefined)
        return true;
    else
        document.getElementById("invalid-type").innerHTML = "please, choose type";
    return false;
}

function validateForm() {
    if (validateEmail() && validatePassword() && validateRole())
        return true;
    else
        return false;
}