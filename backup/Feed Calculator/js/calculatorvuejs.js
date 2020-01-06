var app = new Vue({
    el: '#calculator',
    data: {
        an_start_weight: 75,
        an_number: 6,
        an_feed_ratio: 0.02,
        an_projected_weight_increase: 2,
        an_target_weight : 700,

        calculator_result: [],
        total_feed_required: 0
    },
    methods: {
        calculate: function (event) {
            self = this;

            //reset some values
            self.total_feed_required = 0;
            self.calculator_result = [];

            var an_monthly_weight = self.an_start_weight;
            var monthly_weight_increase = self.an_projected_weight_increase * 30.5;
            var month_count = 1;

           while(an_monthly_weight < self.an_target_weight){
                self.calculator_result.push({
                    month: month_count,
                    monthly_weight: an_monthly_weight,
                    feed_required: parseInt(an_monthly_weight * 30.5 * self.an_feed_ratio),
                    feed_bales: (an_monthly_weight * 30.5 * self.an_feed_ratio / 40).toFixed(2),
                    feed_bales_all: (an_monthly_weight * self.an_number * 30.5 * self.an_feed_ratio / 40).toFixed(2)
                });

               //total for all animals
               self.total_feed_required = self.total_feed_required +  (an_monthly_weight * 30.5 * self.an_feed_ratio);

                if(parseInt(an_monthly_weight) + parseInt(monthly_weight_increase) >= parseInt(self.an_target_weight))
                    break;

                month_count++;
                an_monthly_weight = parseInt(an_monthly_weight) + parseInt(monthly_weight_increase) ;
           }

           //final feed calculation
            self.total_feed_required = self.total_feed_required * self.an_number;

        }
    }
})