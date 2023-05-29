document.querySelector("#fzf").addEventListener("keyup", function() {
    var value = this.value.toLowerCase();
    document.querySelectorAll("#dedalost tr").forEach(function(row) {
        row.style.display = row.textContent.toLowerCase().indexOf(value) > -1 ? "" : "none";
    });
});