var FinancesIndex = new Vue({
    el: "#ongoing-finances",
    data: {
       finances: []
    },
    created: function () {
        var self = this;

        //get all the projects
        self.getFinances();
    },
    methods: {
        getFinances: function () {
            //gets all project items
            var self = this;           

            var data = {};
            data = JSON.stringify(data);

            var projectsList = $.post("/finances/main/get/all", data);

            projectsList.done(function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);
                    
                    self.finances = data;
                }
            });

            projectsList.always(function () { });
        },
        editOne: function(){

        },
        deleteOne: function(){

        }
    }
});
