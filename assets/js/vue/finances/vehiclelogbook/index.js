const vehiclebooklogs = {
    data() {
        return {
            booklogs: [],
            new_booklog: {},       
            start_date: '',
            end_date : '' 
        }
    },   
    created () { 
        var self = this;

        var today = new Date();
        // var dd = String(today.getDate()).padStart(2, '0');
        // var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();

        //format is yyyy/mm/dd
        self.start_date = yyyy + '-01-01';
        self.end_date = yyyy + '-12-01';

        self.bookLogsGetAll(); //get all transactions     
    },
    methods: {    
        bookLogsGetAll () {
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
    }
};

const app = Vue.createApp(vehiclebooklogs)
                .mount('#vehiclelogbook');

                
//const vm = app.mount('#transactions');
//app.mount('#transactions');