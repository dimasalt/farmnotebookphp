var FinancesIndex = new Vue({
    el: "#transactions",
    data: {
       add_new_visible : false, 
       transactions: [],
       transaction_record : {
           name : '',
           price : 0,
           date : '',
           category : '',
           type : ''
       },
       transaction_category : [],
       transaction_type: [],
       chart_show: true,
       chart_data : []
    },
    created: function () {
        var self = this;

        //get all the projects
        self.transactionsGetAll();
    },
    methods: {
        transactionsGetAll: function () {
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
        transactionEdit: function(){

        },
        transactionDel: function(){

        },
        showForm: function(is_visible){
            var self = this;

            self.add_new_visible = is_visible;
        }
    }
});
