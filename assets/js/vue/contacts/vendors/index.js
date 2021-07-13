const app = Vue.createApp({
    data() {             
        return {
            vendors: [], 
            vendor_item: {
                id : 0,
                name : '',
                desc : '',
                address : '',
                phone : ''
            }           
        }
    },
    created() {
        var self = this;

        //get all the projects
        self.getTypes();
    },
    methods: {
        getVendors() {
            //gets all project items
            var self = this;           

            var data = {};
            data = JSON.stringify(data);

            var result = $.post("/bookkeeping/categories/get/all", data);

            result.done(function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);

                    self.transaction_cats = data;                

                    //get sub categories for the very first item
                    self.selectCategory(self.selected_index);               
                }
            });

            result.always(function () { });
        },    
        createVendor : function(){
            var self = this;

            var csrf = $('#csrf').val();

            var data = {category_item : self.work_item, csrf : csrf};
            data = JSON.stringify(data);

            var result = $.post("/bookkeeping/categories/save", data);

            result.done(function (data) {

                data = JSON.parse(data);
                if(data === true){                   
                    //Display a success toast, with a title
                    toastr.success("New changes has been successfully added");                
               }
               else if(data == false) {                  
                    // Display an error toast, with a title
                    toastr.error("Ops! There has been problem adding new changes...");
               }

               //close and clear form
               self.closeCatItemForm();
               
               //reload categories and sub categories
               self.getTypes();
            });

            result.always(function () { });
        },
        deleteVendorModal(index){
            var self = this;

             //hide modal
             $('#deleteModal').modal('hide');

            self.work_item = category_item;

             //hide modal
             $('#deleteModal').modal('show');

        },        
        deleteVendor(){
            var self = this;

            var csrf = $('#csrf').val();

            var data = {category_id : category_id, csrf : csrf};
            data = JSON.stringify(data);

            var result = $.post("/bookkeeping/categories/delete", data);

            result.done(function (data) {

                data = JSON.parse(data);
                if(data === true){                   
                    //Display a success toast, with a title
                    toastr.success("Category has been successfully removed");                
               }
               else if(data == false) {                  
                    // Display an error toast, with a title
                    toastr.error("Ops! There has been problem removing the category item...");
               }               
               
                //hide modal
                $('#deleteModal').modal('hide');

               //reload categories and sub categories
               self.getTypes();
            });

            result.always(function () { });
        },
        resetVendor(){
            var self = this;

            //reseting vendor record
            self.vendor_item = {
                id : 0,
                name : '',
                desc : '',
                address : '',
                phone : ''
            };           
        }
    }
});

const vm = app.mount('#vendors');