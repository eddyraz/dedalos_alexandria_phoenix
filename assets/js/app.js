// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"


import jquery from "jquery"


let hooks = {}

hooks.saveLoginToken = {
    mounted() {
    	this.handleEvent("save_login_token", ({payload}) => {
           localStorage.setItem("login_token", payload)})	


  },    
};



// hooks.searchFilter ={
//     mounted() {
//     this.el.addEventListener("input", e => {	
  
//                $("#fzf").on("keyup", function() {
//                     var value = $(this).val().toLowerCase();
//                     $("#dedalost tr").filter(function() {
//                         $(this).toggle($(this).text()
//                         .toLowerCase().indexOf(value) > -1)
//                     });

//                });
//       })
//     }		       
// };


hooks.searchFilter = {
    const input = document.querySelector('#search-input');
    const table = document.querySelector('#results-table');
    updated() {
        this.el.addEventListener("input", e => {
        searchTerm = this.el.value.toLowerCase()    
//            console.log(searchTerm)
	    console.log(table.rows)
        
      }),
    },
};
// hooks.searchFilter2 = {
// // Get references to the input and table elements
// const input = document.querySelector('#search-input');
// const table = document.querySelector('#my-table');

// // Add an event listener to the input element
// input.addEventListener('input', () => {
//   // Get the search term entered by the user
//   const searchTerm = input.value.toLowerCase();

//   // Loop through each row of the table
//   Array.from(table.rows).forEach(row => {
//     // Get the text content of the row
//     const rowData = Array.from(row.cells)
//       .map(cell => cell.textContent.toLowerCase())
//       .join('');

//     // Check if the row contains the search term
//     if (rowData.includes(searchTerm)) {
//       // Show the row if it contains the search term
//       row.style.display = '';
//     } else {
//       // Hide the row if it doesn't contain the search term
//       row.style.display = 'none';
//     }
//   });
// });    
// }

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: hooks})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

