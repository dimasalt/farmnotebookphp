const transactions = {
    data() {
        return {
            transactions: [],           
            transaction_record : {
                is_new : false,
                is_delete : false
            },
            start_date : new Date().getFullYear()  + '-01-01', //format yyyy + '-' + mm + '-' + dd;
            end_date:  new Date().getFullYear()  + '-12-31', //format yyyy + '-' + mm + '-' + dd;
            transaction_category_selected : '',
            transaction_category : [],
            transaction_sub_category : [],
            transaction_sub_category_disabled : true,
            search_term : ''     
        }
    },   
    created () { 
        var self = this;

        //get all transactions     
        self.transactionsGetAll(); 
        //get transaction categories
        self.getCategories();
    },
    methods: {    
        /**
         * if seach term changed get new records list
         */
        goSearch() {
            var self = this;
           
            self.transactionsGetAll();
        },
        transactionsGetAll () {
            //gets all project items
            var self = this;           
    
            var data = {search_term : self.search_term};

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
        /**
         * -------------------------------------------------------------
         * get transaction categories
         * -------------------------------------------------------------
         */
        getCategories (){
            var self = this;

            var data = {};
            data = JSON.stringify(data);
    
            var result = $.post("/bookkeeping/categories/get/all", data);
    
            result.done(function (data) {
                if (data.length > 0) {
                    
                    data = JSON.parse(data);                  

                    self.transaction_category.push({id: '0', category_name : ''});
                    for (var i = 0; i < data.length; i++)
                        self.transaction_category.push(data [i]);
                    
                        
                    self.transaction_category_selected = self.transaction_category[0].id;
                }                
            });
    
            result.always(function () { });
        },
        /**
         * -----------------------------------------------------------------
         * get transaction sab categories
         * -----------------------------------------------------------------
         */
        getSubCategories (){
            var self = this;

            var data = {};
            data = JSON.stringify(data);
    
            var result = $.post("/bookkeeping/categories/get/all", data);
    
            result.done(function (data) {
                if (data.length > 0) {
                    
                    data = JSON.parse(data);                  

                    self.transaction_category.push({id: '0', category_name : ''});
                    for (var i = 0; i < data.length; i++)
                        self.transaction_category.push(data [i]);
                    
                        
                    self.transaction_category_selected = transaction_category[0].id;
                }                
            });
    
            result.always(function () { });
        },
        /**
         * -----------------------------------------------------------------------------------
         * when selected category in drop down has changed
         * -----------------------------------------------------------------------------------
         */
        categoryChanged() {
            var self = this;

            for(var i = 0; i < self.transaction_category.length; i++)
                if(self.transaction_category[i].id == self.transaction_category_selected){
                    self.transaction_sub_category = self.transaction_category[i].sub_category;
                    break;                    
                }   
                
            if(self.transaction_category_selected == '0')
                self.transaction_sub_category_disabled = true;
            else self.transaction_sub_category_disabled = false;
        },
        /**
         * -------------------------------------------------------------------------------
         * show delete modal for transaction
         * -------------------------------------------------------------------------------
         */
        delOneShow (id, name){
            var self = this;

            self.transaction_record.id = id;
            self.transaction_record.trans_name = name;
            self.transaction_record.is_delete = true;

             //show the modal
             $('#deleteModal').modal('show');
        },
        /**
         * ------------------------------------------------------------------------------
         * remove main transaction items and all sub items
         * ------------------------------------------------------------------------------
         */
        delTransactionMain(){
            var self = this;

            var data = self.transaction_record;
            data = JSON.stringify(data);
    
            var result = $.post("/bookkeeping/records/del/main", data);
    
            result.done(function (data) {
                if (data.length > 0) {
                    
                    data = JSON.parse(data);   
                    
                    if (data == true) {                       
    
                        //hide the modal
                        $('#deleteModal').modal('hide');

                        //get updated list of transactions
                        self.transactionsGetAll();

                        //Display a success toast, with a title
                        toastr.success("You have successfully have removed main transaction item");                                              
                    }
                    else if(data == false){
                        // Display an error toast, with a title
                        toastr.error("Ops! There appears to be an error and selected transaction item coudln't t be removed");
                    }
                    
                }                
            });
    
            result.always(function () {
                var self = this;

                transaction_record = {
                    is_new : false,
                    is_delete : false
                };

             });
        },
        showForm (is_visible){
            var self = this;

            //show new transaction form
            self.transaction_record.is_new = is_visible;
        },
        assignDates(){
            var self = this;

            var today = new Date();
            // var dd = String(today.getDate()).padStart(2, '0');
            // var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
            var yyyy = today.getFullYear();
    
            //format is yyyy/mm/dd
            self.start_date = yyyy + '-01-01';
            self.end_date = yyyy + '-12-01';
    
            //booklogitem
            //self.booklog_item.travel_date = yyyy + '-' + mm + '-' + dd;
        }
    }
};

const app = Vue.createApp(transactions)
                .mount('#transactions');

                
//const vm = app.mount('#transactions');
//app.mount('#transactions');