const livestock = {
    data() {
        return {     
            start_date : '',
            end_date: '',
            livestock : [],
            livestock_item : {},
            livestock_types : [],       
            livestock_subtypes : [],
            pagination : {
                current_page: 1,
                records: 25,
                total_pages: 0,
                pages_array : []
            },
            category_selected : '',
            sub_category_selected : '',
            sub_category_disabled : true,

            action : {
                new : false,
                edit : false
            }
        }    
    },
    mounted() {
        var self = this;       
        
        //clear variables
        self.resetVariables();

        //get livestock inventory
        self.getLiveStockInventory();

        //get livestok types
        self.getLiveStockTypes();
    },
    methods: {
        /**
         * gets all livestock based on search and default values
         */
        getLiveStockInventory () {
            var self = this;

            //prepare data
            var data = {
                current_page : self.pagination.current_page,
                records : self.pagination.records
            };
            data = JSON.stringify(data); // $.param({ 'id': ticket_id });

            var livestockInventory = $.post( "/inventory/livestock/get/all", data);

            livestockInventory.done(function( data ) {

                data = JSON.parse(data);     
                self.livestock = data;

                if(self.livestock.length > 1)
                    self.pagination.total_pages = self.livestock[0].total_pages;                    
                

                //create array for pagination pages
                self.pagination.pages_array = [];
                for(var i = 0; i < self.pagination.total_pages; i++){
                    self.pagination.pages_array.push(i + 1);
                }
            });

            livestockInventory.always(function () {
                // Reenable the inputs
                // $('input').prop( "disabled", false );
            });          
        },

        /**
         * -------------------------------------------------------
         * get livestock types present on the farm
         * ------------------------------------------------------
         */
        getLiveStockTypes () {
            var self = this;

            var data = {};
            data = JSON.stringify(data);

            var liveStockInventoryTypes = $.post("/inventory/types/get/all" , data);

            liveStockInventoryTypes.done(function (data) {
                            
                if(data.length > 0){

                    data = JSON.parse(data);     
                    self.livestock_types = data;
                    self.livestock_item.livestock_types = data;

                    self.category_selected = '';
                }
            });

            liveStockInventoryTypes.always(function () {
            });
        },
        
        /**
         * ---------------------------------------------------------------
         * drop down category selection changed
         * ---------------------------------------------------------------
         */
         categoryChanged(){
            var self = this;

            if(self.category_selected.length > 0)
            {
                for(var i = 0; i < self.livestock_types.length; i++)
                {
                    if(self.livestock_types[i].category_name == self.category_selected){
                        self.livestock_subtypes = self.livestock_types[i].sub_items;
                        break;
                    }
                }
                self.sub_category_disabled = false;
            }
            else {
                self.sub_category_selected = '';
                self.sub_category_disabled = true;
            }
         },

        /**
         * -------------------------------------------------------------------
         * livestock categories for the livestock existing or new item
         * -------------------------------------------------------------------
        */     
        // livestockItemCategoryChanged(){
        //     var self = this;

        //     if(self.livestock_item.livestock_type.length > 0)
        //     {
        //         for(var i = 0; i < self.livestock_item.livestock_types.length; i++)
        //         {
        //             if(self.self.livestock_item.livestock_types[i].category_name == self.livestock_item.livestock_type){
        //                 self.livestock_subtypes = self.livestock_types[i].sub_items;
        //                 break;
        //             }
        //         }
        //         self.sub_category_disabled = false;
        //     }
        //     else self.sub_category_disabled = true;
        //  },
        /**
         * ---------------------------------------------------------------
         * reset all variables
         * ---------------------------------------------------------------
        */   
        resetVariables(){
            var self = this;

            self.start_date = new Date().getFullYear()  + '-01-01'; //format yyyy + '-' + mm + '-' + dd;
            self.end_date =  new Date().getFullYear()  + '-12-31'; //format yyyy + '-' + mm + '-' + dd; 

            self.category_selected = '';
            self.sub_category_selected = '';
            self.sub_category_disabled = true;

            //reset livestock item
            self.livestock_item = {
                id : 0,
                tag : '',
                livestock_type : '',
                livestock_subtype : '',
                sex : '',
                weight : 0,
                price : 0,
                sell_price : 0,
                is_active : 1,
                livestock_types : [],
                livestock_subtypes : []
            };

            //action item
            self.action = {
                new : true,
                edit : false
            };
        }     
    }
};

const app = Vue.createApp(livestock)
                .mount('#livestock');

