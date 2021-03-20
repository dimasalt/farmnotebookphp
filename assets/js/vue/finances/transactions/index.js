const transactions = {
    data() {
        return {
            transactions: [],
            add_new_visible : false,          
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
        }
    },   
    created () { 
        var self = this;
        self.transactionsGetAll(); //get all transactions     
    },
    methods: {    
        transactionsGetAll () {
            //gets all project items
            var self = this;           
    
            var data = {};
            data = JSON.stringify(data);
    
            var projectsList = $.post("/bookkeeping/records/get/all", data);
    
            projectsList.done(function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);
    
                    for (var i = 0; i < data.length; i++) {
    
                        //check for red or green success class styling
                        if (data[i].trans_ammount < 0) data[i].class = "text-danger";
                        else if (data[i].trans_ammount > 0) data[i].class = "text-success";
                    }
                    
                    self.transactions = data;
                }
            });
    
            projectsList.always(function () { });
        },   
        transactionEditDisplay: function(){

        },
        transactionEdit: function(){

        },
        transactionDelDisplay: function(){

        },
        transactionDel: function(){

        },
        showForm: function(is_visible){
            var self = this;

            self.add_new_visible = is_visible;
        }
    }
};

const app = Vue.createApp(transactions)
                .mount('#transactions');

                
//const vm = app.mount('#transactions');
//app.mount('#transactions');