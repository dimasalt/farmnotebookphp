const Feed = {
    data() {
        return {   
            feeds: [],
            feed_item : {}           
        }
    },
    mounted() {
        var self = this;       
        
        //get intial information from database
        self.getFeeds();
       
    },
    methods: {
        getFeeds (){
            var self = this;
                         
            let data = {};

            //reset variables
            self.feeds = [];           
           
            //prepare data for php          
            data = JSON.stringify(data);

            var result = $.post("/ration/feeds/get/all", data);

            result.done(function (data) {                     
               data = JSON.parse(data);

                //if successfully added 
               if(data.length > 0){  

                    //load all feeds into datalist
                    self.feeds = data;   
                    
                    
               }            
            });

            result.always(function () {
            });
        },  
        /**
         * ----------------------------------------------
         * show deletion modal 
         * ----------------------------------------------
         */
        showDeleteModal(id, name){

            var self = this;

            //reset variables
            self.resetVariables();

            //set new values
            self.feed_item.id = id;
            self.feed_item.feed_name = name;

            $('#deleteModalRecord').modal('show');
        },
        hideDeleteModal(){
            var self = this;

            //reset variables and hide the delete modal
            self.resetVariables();
            $('#deleteModalRecord').modal('hide');
        },
        /**
         * ------------------------------------------------
         * remove feed from database and list
         * ------------------------------------------------
         */
         deleteFeed(){
             var self = this;

             //hide modal
             $('#deleteModalRecord').modal('hide');

             var self = this;
                         
             let data = {
                csrf : $('#csrf').val(),
                id : self.feed_item.id
             };              
            
             //prepare data for php          
             data = JSON.stringify(data);
 
            var result = $.post("/ration/feeds/delete", data);
 
            result.done(function (data) {                     
                data = JSON.parse(data);
 
                if(data == true){
                    //Display a success toast, with a title
                    toastr.success("You have successfully have removed feed item");  
                    
                    //reload feeds
                    self.getFeeds();
                }
                else if(data == false){
                    // Display an error toast, with a title
                    toastr.error("Ops! There appears to be an error and selected feed item cannot be removed");
                }

                //reset feed item variable values
                self.resetVariables();
            });

                
             result.always(function () {
             });
         },
        /**
         * ---------------------------------
         * reset variables 
         * ---------------------------------
         */
        resetVariables() {
            var self = this;

            //self.feeds = [];
            
            feed_item = {};
            self.feed_item.id = 0;
        }
    }
};

const app = Vue.createApp(Feed)
                .mount('#feed');
