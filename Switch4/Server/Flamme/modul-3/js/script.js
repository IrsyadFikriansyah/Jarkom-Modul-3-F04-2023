document.addEventListener("DOMContentLoaded", function () {
    var nameInput = document.getElementById("nameInput");
    var submitButton = document.getElementById("submitButton");
    var greeting = document.getElementById("greeting");

    submitButton.addEventListener("click", function (event) {
        event.preventDefault();
        var name = nameInput.value;
        greeting.textContent = "Hello, " + name + "!";
    });
});
