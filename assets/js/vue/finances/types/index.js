var FinancesIndex = new Vue({
    el: "#transactiontypes",
    data: {     
        transaction_cats: [], 
        transaction_subcats: [],
        work_item : {
            cat_id : 0,
            cat_name : '',
            cat_desc : '',
            type : ''
        },
        selected_index : 0,
        cat_work_form: false
    },
    created: function () {
        var self = this;

        //get all the projects
        self.getTypes();
    },
    methods: {
        getTypes: function () {
            //gets all project items
            var self = this;           

            var data = {};
            data = JSON.stringify(data);

            var result = $.post("/finances/categories/get/all", data);

            result.done(function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);

                    self.transaction_cats = data;

                    for(var i = 0; i < self.transaction_cats.length; i++)
                        

                    //get sub categories for first/selected item
                    self.selectCategory(self.selected_index);

                    // for (var i = 0; i < data.length; i++) {

                    //     //check for red or green success class styling
                    //     if (data[i].trans_type_name == 'expense') data[i].class = "text-danger";
                    //     else if (data[i].trans_type_name == 'income') data[i].class = "text-success";
                    // }
                    
                    // self.transactions = data;
                }
            });

            result.always(function () { });
        },
        selectCategory: function(index){
            var self = this;


            //reset transaction sub category array
            self.transaction_subcats = [];

            //adjust value of selected index
            self.selected_index = index;

            //change active element in the list
            for(var i = 0; i < self.transaction_cats.length; i++)
            {
                if(i == index) self.transaction_cats[i].is_active = true;
                else self.transaction_cats[i].is_active = false;
            }

            //get sub categories for selected category type
            var data = {id : self.transaction_cats[index].id};
            data = JSON.stringify(data);

            var result = $.post("/finances/categories/get/allsub", data);

            result.done(function (data) {
                if (data.length > 0) {
                    data = JSON.parse(data);
                
                    self.transaction_subcats = data;                 
                }
            });

            result.always(function () { });
        },
        showCatItemForm: function(index, name, description){
            var self = this;

            //assing edit or new item
            self.work_item.cat_name = name;
            self.work_item.cat_desc = description;        

            self.selected_index = index;
            self.cat_work_form = true;
        },
        closeCatItemForm: function(){
            var self = this;

              //assing edit or new item
              self.work_item.cat_name = '';
              self.work_item.cat_desc = '';        

            self.cat_work_form = false;
        }
    }
});
