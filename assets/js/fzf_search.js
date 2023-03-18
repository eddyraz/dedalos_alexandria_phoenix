jQuerycode(){

        $(".pager-button").click( () => {
            const new_tab_data = this.dataFetching(11,20) ;
            console.log(new_tab_data) ;
        });

               $("#fzf").on("keyup", function() {
                    var value = $(this).val().toLowerCase();
                    $("#dedalost tr").filter(function() {
                        $(this).toggle($(this).text()
                        .toLowerCase().indexOf(value) > -1)
                    });
               });

    $(".pageIndex").on("keyup", function() {


    });
    }
