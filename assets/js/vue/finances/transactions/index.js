var FinancesIndex = new Vue({
    el: "#transactions",
    data: {
       add_new_visible : false, 
       transactions: [],
       transaction_record : {
           name : '',
           price : 0,
           date : ''
       }
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

            var projectsList = $.post("/finances/transactions/get/all", data);

            projectsList.done(function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);
                    
                    self.transactions = data;
                }
            });

            projectsList.always(function () { });
        },
        editOne: function(){

        },
        deleteOne: function(){

        },
        displayForm: function(is_visible){
            var self = this;

            self.add_new_visible = is_visible;
        }
    }
});
