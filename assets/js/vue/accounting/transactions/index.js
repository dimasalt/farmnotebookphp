const transactions = {
    data() {
        return {
            transactions: [],           
            transaction_record : {},
            transaction_item : {},

            start_date : new Date().getFullYear()  + '-01-01', //format yyyy + '-' + mm + '-' + dd;
            end_date:  new Date().getFullYear()  + '-12-31', //format yyyy + '-' + mm + '-' + dd;
            transaction_category_selected : '',
            transaction_category : [],
            transaction_sub_category : [],
            transaction_sub_category_disabled : true,
            search_term : '',
            
            action: '',
            action_item: false           
        }
    },   
    created () { 
        var self = this;

        //reset transaction record and item 
        self.resetTransactionRecord();

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
         * -----------------------------------------------------------
         * adds main transaction item
         * -----------------------------------------------------------
         */
        transactionAdd(){
            var self = this;

            var data = self.transaction_record;
            data = JSON.stringify(data);

            var result = $.post("/bookkeeping/records/add", data);
    
            result.done(function (data) {
                if (data.length > 0) {
                    
                    data = JSON.parse(data);   
                    
                    if (data == true) {   
                                                
                        //reset transaction record and item 
                        self.resetTransactionRecord();

                        //get updated list of transactions
                        self.transactionsGetAll();

                        //Display a success toast, with a title
                        toastr.success("You have successfully have added a main transaction item");                                              
                    }
                    else if(data == false){
                        // Display an error toast, with a title
                        toastr.error("Ops! There appears to be an error and selected main transaction coudln't be removed");
                    }
                    
                }                
            });
    
            result.always(function () { });
        },
        /**
         * --------------------------------------------------------------------------------------
         * add item to main transaction record
         * ---------------------------------------------------------------------------------------
         */
         transactionItemAdd(){
             var self = this;

            var data = self.transaction_item;
            data = JSON.stringify(data);

            var result = $.post("/bookkeeping/record/item/add", data);
    
            result.done(function (data) {
                if (data.length > 0) {
                    
                    data = JSON.parse(data);   
                    
                    if (data == true) {   
                                           
                        //reset form values                        
                        self.resetTransactionRecord();

                        //get updated list of transactions
                        //self.transactionsGetAll();

                        //Display a success toast, with a title
                        toastr.success("You have successfully have added a main transaction item");                                              
                    }
                    else if(data == false){
                        // Display an error toast, with a title
                        toastr.error("Ops! There appears to be an error and selected main transaction coudln't be removed");
                    }
                    
                }                
            });
    
            result.always(function () { });
         },
        /**
         * -------------------------------------------------------------------------------------
         * edit main transaction record
         * -------------------------------------------------------------------------------------
         */
         transactionEdit(){
            var self = this;

            var data = self.transaction_record;
            data = JSON.stringify(data);

            var result = $.post("/bookkeeping/records/edit", data);
    
            result.done(function (data) {
                if (data.length > 0) {
                    
                    data = JSON.parse(data);   
                    
                    if (data == true) {   
                        
                        //close new transaction input form
                        //self.showForm(false);

                        //reset transaction record
                        self.resetTransactionRecord();

                        //get updated list of transactions
                        self.transactionsGetAll();

                        //Display a success toast, with a title
                        toastr.success("You have successfully have edited a main transaction record");                                              
                    }
                    else if(data == false){
                        // Display an error toast, with a title
                        toastr.error("Ops! There appears to be an error and selected main transaction coudln't be changed");
                    }
                    
                }                
            });
    
            result.always(function () { });
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

            //reset transaction record
            self.resetTransactionRecord();
    
            var result = $.post("/bookkeeping/records/del", data);
    
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

                //reset transaction record and action
               self.resetTransactionRecord();
            });
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
         *----------------------------------------------------------------------------
         * on transaction item category being changed, select proper sub categories
         * ----------------------------------------------------------------------------
         */
         categoryItemChanged(){
            var self = this;             

            for(var i = 0; i < self.transaction_category.length; i++)
                if(self.transaction_category[i].category_name == self.transaction_item.item_category){
                    self.transaction_sub_category = self.transaction_category[i].sub_category;                   
                    break;                    
                }   
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

             //show the modal
             $('#deleteModal').modal('show');
        },
         /**
         * -------------------------------------------------------------------------------
         * Hide delete modal for transaction
         * -------------------------------------------------------------------------------
         */
        delOneHide (){
            var self = this;

            //reset transaction object and action
            self.resetTransactionRecord();

             //show the modal
             $('#deleteModal').modal('toggle');
        },    
        setAction (action){
            var self = this;          

            //reset transaction record
            self.resetTransactionRecord();

            //show new transaction for action                       
            self.action = action;

            // if(self.action == 'edit'){
            //     self.showEditForm();
            // }
        },
        /**
         * -------------------------------------------------------------
         * show new transaction item form
         * -------------------------------------------------------------
         */
        showTransactionItemForm(action, transaction_id){
            var self = this;

            self.action_item = action;
            self.transaction_item.transaction_id = transaction_id;                  
        },
        /**
         * -------------------------------------------------------
         * shows edit form for transaction item
         * -------------------------------------------------------
         */
        showEditForm(index){

            var self = this;

            //coppy record and set action to update
            self.transaction_record = Object.assign({}, self.transactions[index] );            

             //show new transaction form
           self.action = 'edit';

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
        },
        /**
         * ------------------------------------------------------
         * reset for transaction and transaction item
         * ------------------------------------------------------
         */
        resetTransactionRecord(){
            var self = this;                     

            //set today date
            var today = new Date();
            var dd = String(today.getDate()).padStart(2,'0');
            var mm = String(today.getMonth() + 1).padStart(2, '0');
            //self.transaction_record.trans_date = today.getFullYear() + '-' + mm + '-' + dd;

            //reset transaction record
            self.transaction_record = {
                id : 0,
                trans_name : '',
                trans_desc : '',
                trans_address_name : '',
                trans_address : '',
                trans_currency: 'C$',
                trans_date : today.getFullYear() + '-' + mm + '-' + dd
            };

            //reset actions for record and item
            self.action = '';
            self.action_item = false;

            //transaction item
            self.transaction_item = {
                id : 0,
                transaction_id : 0,
                item_name : '',
                item_desc : '',
                item_category : '',
                item_subcategory : '',
                amount : 0,
                hst_tax : 0,
                gst_tax : 0,
                pst_tax : 0              
            };
        }
    }
};

const app = Vue.createApp(transactions)
                .mount('#transactions');
