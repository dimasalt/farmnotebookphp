const vehiclebooklogs = {
    data() {
        return {
            odometer : {},
            odometer_item : {
                id: 0,
                year_start_odometer : '',
                year_end_odometer : '',
                vehicle_desc : '',
                is_addoredit : false       
            },
            booklogs: [],  
            booklog_item : {
                vehicle_log_book_id : 0,
                destination : '',
                address : '',
                purpose : '',
                travel_distance : 0,
                travel_date : '',
                is_new : false
            },         
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
             
             //reset odometer
             self.odometer = {};
    
             //prepare data
             var data = {booklog_date : self.booklog_date};
             data = JSON.stringify(data);
     
             var odometerReadings = $.post("/bookkeeping/vehiclelogbook/get/odometer", data);
     
             odometerReadings.done(function (data) {
                 if (data.length > 0) {
                     data = JSON.parse(data);                 
                     
                     self.odometer = data;

                     //get all records for current odometer year
                     if(self.odometer != false)
                        self.bookLogsGetAll();
                    else if(self.odometer == false)
                        self.odometer_item.is_addoredit = true;
                 }               
             });
     
             odometerReadings.always(function () { });
        },
        bookLogsGetAll () {           
            var self = this;          
            
            //reset booklog records
            self.booklogs = [];
    
            //prepare data
            var data = {odometer_id : self.odometer.id};
            data = JSON.stringify(data);
    
            var projectsList = $.post("/bookkeeping/vehiclelogbook/get/all", data);
    
            projectsList.done(function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);                
                    
                    self.booklogs = data;
                }
            });
    
            projectsList.always(function () { });
        },     
        /**
         * -------------------------------------------------------
         * add or edit odometer reading for specific year
         * --------------------------------------------------------
         */
        odometerAddOrEdit(){
            var self = this;            
            
            var data = {odometer : self.odometer_item};
            data.created_at = self.booklog_date;
            data.csrf = $('#csrf').val();  

            //prepare json
            data = JSON.stringify(data);

            var odometerNew = $.post("/bookkeeping/vehiclelogbook/addoredit/odometer", data);
    
            odometerNew.done(function (data) {
                if(data.length > 0){
                    //parse json
                    data = JSON.parse(data);

                    if(data == true){
                        //Display a success toast, with a title
                        toastr.success("You have successfully added new odometer to a records");      
                        
                        //pull new odometer record
                        self.getOdometer();
                    }
                    else if(data == false){
                        // Display an error toast, with a title
                        toastr.error("Ops! There appears to be an error and odometer coudln't be added");
                    }               
                } 
                
                //reset odometer_item
                self.odometer_item = {
                    id: 0,
                    year_start_odometer : '',
                    year_end_odometer : '',
                    vehicle_desc : '',
                    is_addoredit : false       
                };
            });
     
            odometerNew.always(function () { });
        },     
        showOdometerForm(){
            var self = this;
            
            //copy odometer values without linking original values with changed ones
            self.odometer_item = Object.assign({}, self.odometer );

            //show form
            self.odometer_item.is_addoredit = true;

        },
        /**
         * -------------------------------------------------------
         * remove odometer
         * --------------------------------------------------------
         */
        odometerDelModalShow(){
            var self = this;    

            //show the modal
            $('#deleteModal').modal('show');
        },
        odometerDelOne(){
            var self = this;    
            
            //show the modal
            $('#deleteModal').modal('hide');
            
            var data = {id : self.odometer.id};           
            data.csrf = $('#csrf').val();  

            //prepare json
            data = JSON.stringify(data);

            var odometerDel = $.post("/bookkeeping/vehiclelogbook/del/odometer", data);
    
            odometerDel.done(function (data) {
                if(data.length > 0){
                    //parse json
                    data = JSON.parse(data);

                    if(data == true){
                        //Display a success toast, with a title
                        toastr.success("You have successfully removed an odometer from the records");      
                        
                        //select current year date 
                        var today = new Date();                       
                        var yyyy = today.getFullYear();
                
                        //format is yyyy/mm/dd
                        self.booklog_date = yyyy + '-01-01';                     
                
                        //get current year odometer                   
                        self.getOdometer();           
                    }
                    else if(data == false){
                        // Display an error toast, with a title
                        toastr.error("Ops! There appears to be an error and odometer coudln't be removed");
                    }               
                }                              
            });
     
            odometerDel.always(function () { });
        },
        showNewBooklogForm(status){
            var self = this;

            self.booklog_item.is_new = status;
        },       
        booklogItemAdd(){
            var self = this;          
            
            var data = {
                vehicle_log_book_id : self.odometer.id,                
                booklog_item : self.booklog_item,
                csrf : $('#csrf').val()
            };                     

            //prepare json
            data = JSON.stringify(data);

            var booklogAdd = $.post("/bookkeeping/vehiclelogbook/add/booklog", data);
    
            booklogAdd.done(function (data) {
                if(data.length > 0){
                    //parse json
                    data = JSON.parse(data);

                    if(data == true){
                        //Display a success toast, with a title
                        toastr.success("You have successfully added an logbook item from the records");                                                    
                    }
                    else if(data == false){
                        // Display an error toast, with a title
                        toastr.error("Ops! There appears to be an error and booklog item coudln't be removed");
                    }               
                }                              
            });
     
            booklogAdd.always(function () { });

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