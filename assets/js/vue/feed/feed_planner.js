var app = new Vue({
    el: '#app',
    data: {
      results: [],
      feeds: [{
          type: "grain",
          name: "corn",
          CP: 10,
          TDN: 90
        },
        {
          type: "protein",
          name: "soy bean meal",
          CP: 47,
          TDN: 77
        },
        {
          type: "weed",
          name: "hay",
          CP: 7,
          TDN: 55
        }
      ],
      nutrition_req: [{
          type: "steer/heifer",
          weight: 200,
          CP: 22,
          TDN: 80,
          DM: 5.4,
          target: 3,
        },
        {
          type: "steer/heifer",
          weight: 300,
          CP: 22,
          TDN: 80,
          DM: 8.3,
          target: 3,
        },
        {
          type: "steer/heifer",
          weight: 400,
          CP: 18.7,
          TDN: 80,
          DM: 10.4,
          target: 3,
        }
      ]
    },
    created: function() {
      var self = this;
  
      //call calculations
      self.calculate();
    },
    methods: {
      //function to calculate feed requirements and proportions
      calculate: function() {
        var self = this;
  
        //define temporary variables
        var grain_temp = {}, protein_temp = {}, hay_temp = {}, result_temp = {};
  
        //assign values to a temp variables
        for (var i = 0; i < self.feeds.length; i++) {
          if (self.feeds[i].type == "grain")
            grain_temp = self.feeds[i];
          else if (self.feeds[i].type == "protein")
            protein_temp = self.feeds[i];
          else hay_temp = self.feeds[i];
        }
  
        //calculate requirements
        for (var i = 0; i < self.nutrition_req.length; i++) {
        
          var grain_square, hay_square, grain_tdn, hay_tdn;
  
          //calculate TDN %
          grain_square = grain_temp.TDN - self.nutrition_req[i].TDN;
          if (grain_square < 0)
            grain_square = grain_square * (-1);
  
          hay_square = hay_temp.TDN - self.nutrition_req[i].TDN;
          if (hay_square < 0)
            hay_square = hay_square * (-1);
            
          var grain_ratio = hay_square / (hay_square + grain_square);
          var hay_ratio = grain_square / (hay_square + grain_square);
  
          grain_tdn = grain_ratio * self.nutrition_req[i].DM;
          hay_tdn = hay_ratio * self.nutrition_req[i].DM;
  
          /* round decimals */
          grain_tdn = Math.round(grain_tdn * 10) / 10;
          hay_tdn = Math.round(hay_tdn * 10) / 10;     
  
          //assing values to the temporary result object
          result_temp.grain_tdn = grain_tdn;
          result_temp.hay_tdn = hay_tdn; 
  
  
          //calculate CP %
          var  grain_CP, hay_CP;
          grain_CP = grain_ratio * grain_temp.CP;       
          hay_CP = hay_ratio * hay_temp.CP;
          
          var grain_req_CP = (self.nutrition_req[i].CP - hay_CP);
          var grain_needed_CP = (grain_req_CP / grain_ratio);    
         
          var grain_square_CP, protein_square_CP;
          grain_square_CP = grain_temp.CP - grain_needed_CP;
          protein_square_CP = protein_temp.CP - grain_needed_CP;
          
          if(grain_square_CP < 0) 
            grain_square_CP = grain_square_CP * (-1);
          if(protein_square_CP < 0)
            protein_square_CP = protein_square_CP * (-1);       
          
          var grain_ratio_CP, protein_ratio_CP;
          grain_ratio_CP = protein_square_CP / (grain_square_CP + protein_square_CP);
          protein_ratio_CP = grain_square_CP /  (grain_square_CP + protein_square_CP);       
          
          var grain_lb = grain_ratio_CP * grain_tdn;
          var protein_lb = protein_ratio_CP * grain_tdn;                
         
        }  
      }
    }
  });
  
  