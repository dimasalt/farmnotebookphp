const vehiclebooklogs = {
    data() {
        return {
            odometer : {},
            booklogs: [],           
            booklog_date: '',
            booklogs_pager: []            
        }
    },   
    created () { 
        var self = this;

        var today = new Date();
        // var dd = String(today.getDate()).padStart(2, '0');
        // var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();

        //format is yyyy/mm/dd
        self.booklog_date = yyyy + '-01-01';
        // self.end_date = yyyy + '-12-01';

        self.getOdometer(); //get year start and end odometer      
    },
    methods: {    
        getOdometer() {
             //gets all project items
             var self = this;           
    
             var data = {booklog_date : self.booklog_date};
             data = JSON.stringify(data);
     
             var odometerReadings = $.post("/bookkeeping/vehiclelogbook/get/odometer", data);
     
             odometerReadings.done(function (data) {
                 if (data.length > 0) {
                     data = JSON.parse(data);                 
                     
                     self.odometer = data;

                     //get all records for current odometer year
                     self.bookLogsGetAll();
                 }
             });
     
             odometerReadings.always(function () { });
        },
        bookLogsGetAll () {           
            var self = this;          
            
            //reset booklog records
            self.booklogs = [];
    
            //prepare data
            var data = {year_id : self.odometer.id};
            data = JSON.stringify(data);
    
            var projectsList = $.post("/bookkeeping/vehiclelogbook/get/all", data);
    
            projectsList.done(function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);
    
                    // for (var i = 0; i < data.length; i++) {
    
                    //     //check for red or green success class styling
                    //     if (data[i].trans_ammount < 0) data[i].class = "text-danger";
                    //     else if (data[i].trans_ammount > 0) data[i].class = "text-success";
                    // }
                    
                    self.booklogs = data;
                }
            });
    
            projectsList.always(function () { });
        },     
        onYearChange()   {
            var self = this;     
            
            //reset existing items
            self.odometer = {};
            self.booklogs = [];

            //pull new information
            self.getOdometer();
        }
    }
};

const app = Vue.createApp(vehiclebooklogs)
                .mount('#vehiclelogbook');

                
//const vm = app.mount('#transactions');
//app.mount('#transactions');