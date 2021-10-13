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
                scoop : 2.5,
                range_start : 200,
                range_end : 600,
                heads : 1
            },
            is_feed_proper : false            
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

                    //load all feeds into datalist
                    self.feeds = data;   
                    
                    //counters for proper feed if presented
                    let grain_count = 0, protein_count = 0, hay_count = 0;
                    
                    //find default feeds and check if there enough protein, grain and hay in default feeds
                    for(var i=0; i < self.feeds.length; i++){
                        if(self.feeds[i].is_default == 1){

                            //display default feeds
                            self.default_feeds.push(self.feeds[i]);

                            //check feed types
                            if (self.feeds[i].feed_type == "Grain")
                                grain_count++;
                            else if (self.feeds[i].feed_type == "Protein")
                                protein_count++;
                            else 
                                hay_count++;
                        }
                    }

                    //check if feed can be calculated
                    if(grain_count > 0 && protein_count > 0 && hay_count > 0)
                        self.is_feed_proper = true;
                    else self.is_feed_proper = false;
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
            let grain_temp = {}, protein_temp = {}, hay_temp = {}, result_temp = {};

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
            
                let grain_square, hay_square, grain_tot_lb, hay_tot_lb;

                //calculate TDN %
                grain_square = grain_temp.feed_tdn - self.nutrition_req[i].tdn;
                if (grain_square < 0)
                    grain_square = grain_square * (-1);

                hay_square = hay_temp.feed_tdn - self.nutrition_req[i].tdn;
                if (hay_square < 0)
                    hay_square = hay_square * (-1);
                
                let grain_ratio = hay_square / (hay_square + grain_square);
                let hay_ratio = grain_square / (hay_square + grain_square);

                grain_tot_lb = grain_ratio * self.nutrition_req[i].dm_per_day;
                hay_tot_lb = hay_ratio * self.nutrition_req[i].dm_per_day;

                /* round decimals */
                grain_tot_lb = Math.round(grain_tot_lb * 10) / 10;
                hay_tot_lb = Math.round(hay_tot_lb * 10) / 10;     

                //assing values to the temporary result object
                result_temp.weight = self.nutrition_req[i].weight;
                result_temp.grain_tot_lb = grain_tot_lb;
                result_temp.hay_tot_lb = hay_tot_lb; 

              

                //calculate CP %
                let  grain_CP, hay_CP;
                grain_CP = grain_ratio * grain_temp.feed_cp;       
                hay_CP = hay_ratio * hay_temp.feed_cp;

                let grain_req_CP = (self.nutrition_req[i].cp - hay_CP);
                let grain_needed_CP = (grain_req_CP / grain_ratio);    
            
                let grain_square_CP, protein_square_CP;
                grain_square_CP = grain_temp.feed_cp - grain_needed_CP;
                protein_square_CP = protein_temp.feed_cp - grain_needed_CP;
                
                if(grain_square_CP < 0) 
                    grain_square_CP = grain_square_CP * (-1);

                if(protein_square_CP < 0)
                    protein_square_CP = protein_square_CP * (-1);       


                let grain_ratio_CP, protein_ratio_CP;
                grain_ratio_CP = protein_square_CP / (grain_square_CP + protein_square_CP);
                protein_ratio_CP = grain_square_CP /  (grain_square_CP + protein_square_CP);       
                
                let grain_lb = grain_ratio_CP * grain_tot_lb;
                let protein_lb = protein_ratio_CP * grain_tot_lb;   
                
                /* round decimals */
                grain_lb = Math.round(grain_lb * 10) / 10;
                protein_lb = Math.round(protein_lb * 10) / 10;     

                result_temp.grain_lb = grain_lb;
                result_temp.protein_lb = protein_lb;

                //add total dry matter needed and animal type
                result_temp.dm = self.nutrition_req[i].dm_per_day;
                result_temp.animal_type = self.nutrition_req[i].animal_type;

                self.results.push(Object.assign({}, result_temp));
            
            }
        }
    }
};

const app = Vue.createApp(Ration)
                .mount('#ration');
