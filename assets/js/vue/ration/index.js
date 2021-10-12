const Ration = {
    data() {
        return {   
            results: [],
            feeds: [],
            default_feeds: [],
            selected_feed : '',
            nutrition_req: [],
            requirements : {
                adg : 3,
                cp : 22,
                tdn : 80,
                scoop : 2.5,
                range_start : 100,
                range_end : 900,
                heads : 1
            }            
        }
    },
    mounted() {
        var self = this;       
        
        //get intial information from database
        self.getFeeds();
        self.getFeedRequirements();
       
    },
    methods: {
        getFeeds (){
            var self = this;
                         
            let data = {};

            //reset variables
            self.feeds = [];
            self.default_feeds = [];
           
            //prepare data for php          
            data = JSON.stringify(data);

            var result = $.post("/ration/ration_calculator/getfeeds", data);

            result.done(function (data) {                     
               data = JSON.parse(data);

                //if successfully added 
               if(data.length > 0){  

                    self.feeds = data;     
                    
                    for(var i=0; i < self.feeds.length; i++)
                        if(self.feeds[i].is_default == 1)
                            self.default_feeds.push(self.feeds[i]);
               }            
            });

            result.always(function () {
            });
        },  
        /**
         * ----------------------------------------------------
         * gets feed requirements for cattle
         * -----------------------------------------------------     
         */
        getFeedRequirements(){
            var self = this;

            //reset old feed requirements
            self.nutrition_req = [];

            //prepare data for php        
            let data = {               
                csrf : $('#csrf').val()
            };  
            data = JSON.stringify(data);

            var result = $.post("/ration/ration_calculator/getFeedRequirements", data);
 
            result.done(function (data) {                     
                data = JSON.parse(data);
 
                 //if successfully added 
                if(data.length > 0){  
 
                    self.nutrition_req = data;                        
                }            
            });
 
             result.always(function () {
            });
        },
        /**
         *-----------------------------------------------
         * sets feed as default. 
         * 1 means feed is default. 0 means feed is not default
         * --------------------------------------------------
         */
        setFeedAsDefault (is_default = 0){
            var self = this;

            let id = 0;
            //find selected feed
            for(let i = 0; i < self.feeds.length; i++){
                if(self.feeds[i].feed_name == self.selected_feed)
                {
                    id = self.feeds[i].id;     
                    break;               
                }
            }

            //prepare data object
            let data = {
                id : id,
                is_default : is_default,
                csrf : $('#csrf').val()
            };

            //prepare data for php          
            data = JSON.stringify(data);

            var result = $.post("/ration/ration_calculator/setDefaultFeed", data);

            result.done(function (data) {                     
                data = JSON.parse(data);
 
                 //if successfully added 
                if(data == true){  

                    self.selected_feed = '';
                    self.getFeeds();
                }            
            });
 
            result.always(function () {
            });
        },
        /**
         * gets all livestock based on search and default values
         */
        calculateFeedRequirement () {
            var self = this;

            //define temporary variables
            var grain_temp = {}, protein_temp = {}, hay_temp = {}, result_temp = {};

            //assign values to a temp variables
            for (var i = 0; i < self.feeds.length; i++) {
                if (self.feeds[i].feed_type == "Grain")
                    grain_temp = self.feeds[i];
                else if (self.feeds[i].feed_type == "Protein")
                    protein_temp = self.feeds[i];
                else 
                    hay_temp = self.feeds[i];
            }

            //calculate requirements
            for (var i = 0; i < self.nutrition_req.length; i++) {
            
                var grain_square, hay_square, grain_tot_lb, hay_tot_lb;

                //calculate TDN %
                grain_square = grain_temp.feed_tdn - self.nutrition_req[i].tdn;
                if (grain_square < 0)
                    grain_square = grain_square * (-1);

                hay_square = hay_temp.feed_tdn - self.nutrition_req[i].tdn;
                if (hay_square < 0)
                    hay_square = hay_square * (-1);
                
                var grain_ratio = hay_square / (hay_square + grain_square);
                var hay_ratio = grain_square / (hay_square + grain_square);

                grain_tot_lb = grain_ratio * self.nutrition_req[i].dm_per_day;
                hay_tot_lb = hay_ratio * self.nutrition_req[i].dm_per_day;

                /* round decimals */
                grain_tot_lb = Math.round(grain_tot_lb * 10) / 10;
                hay_tot_lb = Math.round(hay_tot_lb * 10) / 10;     

                //assing values to the temporary result object
                result_temp.grain_tot_lb = grain_tot_lb;
                result_temp.hay_tot_lb = hay_tot_lb; 

              

                //calculate CP %
                var  grain_CP, hay_CP;
                grain_CP = grain_ratio * grain_temp.feed_cp;       
                hay_CP = hay_ratio * hay_temp.feed_cp;

                var grain_req_CP = (self.nutrition_req[i].cp - hay_CP);
                var grain_needed_CP = (grain_req_CP / grain_ratio);    
            
                var grain_square_CP, protein_square_CP;
                grain_square_CP = grain_temp.feed_cp - grain_needed_CP;
                protein_square_CP = protein_temp.feed_cp - grain_needed_CP;
                
                if(grain_square_CP < 0) 
                    grain_square_CP = grain_square_CP * (-1);

                if(protein_square_CP < 0)
                    protein_square_CP = protein_square_CP * (-1);       


                var grain_ratio_CP, protein_ratio_CP;
                grain_ratio_CP = protein_square_CP / (grain_square_CP + protein_square_CP);
                protein_ratio_CP = grain_square_CP /  (grain_square_CP + protein_square_CP);       
                
                var grain_lb = grain_ratio_CP * grain_tot_lb;
                var protein_lb = protein_ratio_CP * grain_tot_lb;   
                
                /* round decimals */
                grain_lb = Math.round(grain_lb * 10) / 10;
                protein_lb = Math.round(protein_lb * 10) / 10;     
            
            }
        }
    }
};

const app = Vue.createApp(Ration)
                .mount('#ration');
