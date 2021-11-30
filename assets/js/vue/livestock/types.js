const livestockTypes = {
    data() {
        return {     
            livestock_types : [],
            work_item : {
                id : 0,
                parent_id : 0,
                category_name : '',
                category_description : ''
            },       
            cat_work_form: false,
            selected_index : 0
        }
    },
    created() {     
    },
    methods: {
        /**
         * gets all livestock based on search and default values
         */
        getLiveStockTypes () {
            var self = this;

            //prepare data
            var data = {
               csrf : $('#csrf').val()
            };
            data = JSON.stringify(data); // $.param({ 'id': ticket_id });

            var livestockTypes = $.post( "/inventory/types/get/all", data);

            livestockTypes.done(function( data ) {

                data = JSON.parse(data);   
                
                if(data.length > 0)                
                    self.livestock_types = data;            
            });

            livestockTypes.always(function () {
                // Reenable the inputs
                // $('input').prop( "disabled", false );
            });          
        }
    }
};

const app = Vue.createApp(livestockTypes)
                .mount('#livestocktypes');

