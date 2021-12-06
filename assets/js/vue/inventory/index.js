const livestock = {
    data() {
        return {     
            start_date : new Date().getFullYear()  + '-01-01', //format yyyy + '-' + mm + '-' + dd;
            end_date:  new Date().getFullYear()  + '-12-31', //format yyyy + '-' + mm + '-' + dd; 
            livestock : [],
            livestock_types : [],          
            pagination : {
                current_page: 1,
                records: 25,
                total_pages: 0,
                pages_array : []
            }
        }
    },
    created() {
        var self = this;       
        
        //clear variables
        self.resetVariables();

        //get livestock inventory
        self.getLiveStockInventory();
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

            var livestockInventory = $.post( "/inventory/livestock/getall", data);

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

            var liveStockInventoryTypes = $.post("/livestock/getlivestocktypes" , data);

            liveStockInventoryTypes.done(function (data) {
                self.livestock_types = data;

                //add checked or unchecked status to the checkboxes for inventory types
                for(var i = 0; i < data.length; i++) {
                    if(self.livestock_types[i].type_name == 'sheep')
                        self.livestock_types[i].is_checked = true;
                    else self.livestock_types[i].is_checked = false;

                    //add dynamyc id
                    self.livestock_types[i].dynamic_id = 'livestock_type_id' + self.livestock_types[i].id;
                }
            });

            liveStockInventoryTypes.always(function () {
            });
        },
        goToPage (page_num){
            var self = this;

            self.pagination.current_page = page_num;
            self.getLiveStockInventory();
        },

        /**
         * -------------------------------------------------------------------------------
         * listens to changes in livestock type selection checkboxes
         * ------------------------------------------------------------------------------
         */
        updateLiveStockInventory (id) {
            //alert(id);
        },
        resetVariables(){

        }
    }
};

const app = Vue.createApp(livestock)
                .mount('#livestock');

