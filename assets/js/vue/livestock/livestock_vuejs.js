var Login = new Vue({
    el: '#livestock_flock',
    data: {
        livestock_length_min : 10,
        livestock_total : 0,
        livestock : {},
        livestock_types : {},
        alert : {
            error : false,
            message: ''
        },
        pagination : {
            current_page: 1,
            records: 25,
            total_pages: 0,
            pages_array : []
        }
    },
    created: function () {
    },
    mounted : function() {
        var self = this;
        this.getLiveStockInventory();
        this.getLiveStockTypes();
    },
    methods: {
        getLiveStockInventory: function () {
            var self = this;

            //prepare data
            var data = {
                'current_page' : self.pagination.current_page,
                'records' : self.pagination.records
            };
            data = JSON.stringify(data); // $.param({ 'id': ticket_id });

            var livestockInventory = $.post( "/livestock/getlivestock", data);

            livestockInventory.done(function( data ) {
                self.livestock = data;

                if(self.livestock.length > 1){
                    self.pagination.total_pages = self.livestock[0].total_pages;
                }

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


            // Prevent default posting of form
            //event.preventDefault();
        },

        /**
         * -------------------------------------------------------
         * get livestock types present on the farm
         * ------------------------------------------------------
         */
        getLiveStockTypes : function () {
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
        goToPage : function(page_num){
            var self = this;

            self.pagination.current_page = page_num;
            self.getLiveStockInventory();
        },

        /**
         * -------------------------------------------------------------------------------
         * listens to changes in livestock type selection checkboxes
         * ------------------------------------------------------------------------------
         */
        updateLiveStockInventory: function (id) {
            //alert(id);
        }
    }
});