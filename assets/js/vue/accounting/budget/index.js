const app = Vue.createApp({
    data() {
        return {
            budget_start_item: {},
            budget_item : {},       
            budgets: [],
            budget_total: {
                predicted_expences: 0,
                actual_expences: 0,
                predicted_expences_class: "",
                actual_expences_class: ""
            },
            chart_data : [], //data for the charts
            myChart : {}
        }
    },
    created() {
        var self = this;

        //set the planning item
        self.resetVariables();

        //get all the budgets
        self.getBudget();       
    },
    methods: {
        getBudget() {
            //gets all project items
            var self = this;

            //clear all variables
            self.resetVariables();

            var data = {};
            data = JSON.stringify(data);

            var result = $.post("/bookkeeping/budget/get/all", data);

            result.done(function (data) {
                if (data.length > 0) {                  

                    data = JSON.parse(data);

                     // Create USD currency formatter.
                     var formatter = new Intl.NumberFormat('en-US', {
                        style: 'currency',
                        currency: 'USD',
                    });

                    for (var i = 0; i < data.length; i++) {

                        //check for red or green success class styling
                        if (data[i].budget_amount < 0) data[i].class = "text-danger";
                        else if (data[i].budget_amount > 0) data[i].class = "text-success";

                        //convert money to familiar usd format
                        data[i].budget_amount_formated = formatter.format(data[i].budget_amount);
                        data[i].budget_amount_actual_formated = formatter.format(data[i].budget_amount_actual);


                        //check if project is done
                        if(data[i].is_done == 1){
                            data[i].class = data[i].class + ' ' + "remove-line";
                            data[i].checked = true;
                        }
                        else data[i].checked = false;

                        //check for start point
                        if (data[i].is_start == 1) {
                            self.budget_start_item = data[i];                       
                        }
                        else {
                              //set edit to invisible
                            data[i].is_edit = false;

                            //populate budgets list
                            self.budgets.push(data[i]);      
                        }

                        //calculate predicted and actual expences
                        self.budget_total.predicted_expences =
                            self.budget_total.predicted_expences +
                            parseInt(data[i].budget_amount);
                        self.budget_total.actual_expences =
                            self.budget_total.actual_expences +
                            parseInt(data[i].budget_amount_actual);                                                                          
                    }                                                                                           

                    //format total numbers to usd currency
                    self.budget_total.predicted_expences_formated = formatter.format(self.budget_total.predicted_expences);
                    self.budget_total.actual_expences_formated = formatter.format(self.budget_total.actual_expences);
                }
                     

                //assign information for the chart
                self.chart_data = data;
                self.chartJSLine();                        
            });

            result.always(function () { });
        },
        budgetCreateItem: function (is_start) {
            //remove one project item
            var self = this;            

            //hide new project form
            self.budget_item.is_new = false;
           
            //set an actual expence if none been inserted
            if(self.budget_item.budget_amount_actual == '')            
                self.budget_item.budget_amount_actual = 0;        

            var data = self.budget_item; 
 
            if(is_start == 1)
                data.budget_amount_actual = parseInt(data.budget_amount);                 
                        
            
            data.is_start = is_start;
            data.csrf = $('#csrf').val();  

            data = JSON.stringify(data);

            var projectdel = $.post("/bookkeeping/budget/add", data);

            projectdel.done(function (data) {
                data = JSON.parse(data);             

                if (data == true) {                    
                    //reset abd load budgets again                    
                    self.getBudget();

                    //Display a success toast, with a title
                    toastr.success("You have successfully added new project to the list");                
                }
                else if(data == false){
                    // Display an error toast, with a title
                    toastr.error("Ops! There appears to be an error and project coudln't be added");
                }            
            });

            projectdel.always(function () { });
        },  
        budgetDeleteModalShow: function (id, budget_name){ 
            //show remove item modal
            var self = this;

            //assing values to the delete item
            self.budget_item.id = id;
            self.budget_item.budget_name = budget_name;

            //show the modal
             $('#deleteModal').modal('show');
        },  
        budgetDelete: function () { 
            //remove one project item
            var self = this;

            //hide modal
            $('#deleteModal').modal('hide');

            var data = { 
                id: self.budget_item.id,
                csrf : $('#csrf').val()
            };
            data = JSON.stringify(data);

            var result = $.post("/bookkeeping/budget/delete", data);

            result.done(function (data) {
                data = JSON.parse(data);             

                if (data == true) {
                    if(self.budget_start_item.id == self.budget_item.id)
                        self.budget_start_item = {};
                    else {
                        for (var i = 0; i < self.budgets.length; i++) {
                            if(self.budgets[i].id == self.budget_item.id)
                                self.budgets.splice(i, 1);                          
                        }
                    }                      

                    //reload list of budgets                    
                    self.getBudget();

                    //Display a success toast, with a title
                    toastr.success("You have successfully removed selected item");                
                }
                else if(data == false){
                    // Display an error toast, with a title
                    toastr.error("Ops! There appears to be an error and selected item coudln't t be removed");
                }   
            });

            result.always(function () { });
        },            
        budgetUpdateFormShow: function(index){ //displays edit forms
            var self = this;

            //close any open edit forms
            for(var i = 0; i < self.budgets.length; i++)
                self.budgets[i].is_edit = false;

            //display edit forms
            self.budgets[index].is_edit = true;

            //assing values
            self.budget_item = Object.assign({}, self.budgets[index]);
        },     
        budgetUpdate: function (index) {
            //remove one project item
            var self = this;   
            
            var data = self.budget_item;   
            data.csrf = $('#csrf').val();
            

            data = JSON.stringify(data);
           
            //close any open edit forms
            for(var i = 0; i < self.budgets.length; i++)
                self.budgets[i].is_edit = false;           

            var result = $.post("/bookkeeping/budget/update", data);

            result.done(function (data) {
                data = JSON.parse(data);             

                if (data == true) {                   
                    //reset abd load budgets again                    
                    self.getBudget();

                    //Display a success toast, with a title
                    toastr.success("You have successfully updated selected project");                
                }
                else if(data == false){
                    // Display an error toast, with a title
                    toastr.error("Ops! There appears to be an error and project coudln't be updated");
                }
                
                //call charts
                self.chartJSLine();
            });

            result.always(function () { });
        },
        budgetUpdateStatus: function (id, index) {
            //remove one project item
            var self = this;   
            
            //set data variable
            var data;

            data = {
                id : id,
                csrf : $('#csrf').val()
            };

            if(self.budgets[index].checked == true)
                data.is_done = 1;
            else data.is_done = 0;                                      

            data = JSON.stringify(data);                    

            var result = $.post("/bookkeeping/budget/update/status", data);

            result.done(function (data) {
                data = JSON.parse(data);             

                if (data == true) {                  

                    //reset abd load budgets again                    
                    self.getBudget();

                    //Display a success toast, with a title
                    toastr.success("You have successfully updated selected project status");                
                }
                else if(data == false){
                    // Display an error toast, with a title
                    toastr.error("Ops! There appears to be an error and project status coudln't be updated");
                }            
            });

            result.always(function () { });
        },        
        chartJSLine : function(){   
            
            var self = this;        
            
            //remove old canvas and create new
            $('#canvas_line').remove();
            $('#chart_wrapper').append('<canvas id="canvas_line" class="shadow-sm mt-2"  style="background-color:white;"></canvas>');

            //assing data for labels and datasets
            var data_predicted = [], data_actual = [];            
            for(var i = 0; i < self.chart_data.length; i++){
                //labels.push(self.chart_data[i].planning_name);

                if(data_predicted.length == 0 && data_actual.length == 0){
                    data_predicted.push({ x: self.chart_data[i].budget_date, y: self.chart_data[i].budget_amount  });
                    data_actual.push({ x: self.chart_data[i].budget_date, y: self.chart_data[i].budget_amount_actual  });
                }
                else 
                {
                    var sum_predicted = parseInt(self.chart_data[i].budget_amount) + parseInt(data_predicted[i-1].y); 
                    data_predicted.push({ x: self.chart_data[i].budget_date, y: sum_predicted  });

                    var sum_actual = parseInt(self.chart_data[i].budget_amount_actual) + parseInt(data_actual[i-1].y); 
                    data_actual.push({ x: self.chart_data[i].budget_date, y: sum_actual });
                }

            }

            var timeFormat = 'YYYY/MM/DD';
            
            var config = {
                type: 'line',
                data: {
                    //labels: labels,
                    datasets: [{
                            label: 'Projected',                                
                            backgroundColor : "#FF0000",                
                            borderColor: "#FF0000",
                            borderDash: [5, 5],
                            borderWidth : 2,
                            tension : 0.5,                    
                            fill: false,
                            data: data_predicted
                        },
                        {
                            label: 'Actual',                                
                            backgroundColor : "#008000",                
                            borderColor: "#008000",
                            borderDash: [5, 5],
                            borderWidth : 2,   
                            tension : 0.5,                             
                            fill: false,
                            data: data_actual
                        }
                    ]},
                    options: {
                        responsive: true,
                        title: {
                            text: 'Projected and Actual expenses',
                            display: true
                        },
                        scales:     {
                            xAxes: [{
                                type:       "time",
                                distribution: 'series',
                                time:       
                                {
                                    format: timeFormat,
                                    tooltipFormat: 'll'
                                },
                                scaleLabel: {
                                    display:     true,
                                    labelString: 'Date'
                                }
                            }],
                            yAxes: [{
                                scaleLabel: {
                                    display:     true,
                                    labelString: '$'
                                }
                        }]
                    }
                }
            };  
            

            // Chart.defaults.global.defaultFontFamily =  'Source Sans Pro';
            // Chart.defaults.global.defaultFontColor =  '#000000';
            
            var ctx = document.getElementById("canvas_line").getContext("2d");
            self.myChart = new Chart(ctx, config);   
            
            /**
             * ---------------------------------------------------------------------------------
             * To be honest, though, in cases like yours, I have often used a container div to wrap my canvas and, 
             * whenever I needed to create a new chart, I placed a new canvas element in this div. I then used this 
             * newly created canvas for the new chart. If you ever come across strange behavior, possibly related to 
             * charts occupying the canvas before the current chart, have this approach in mind too.
             * ---------------------------------------------------------------------------------
             */
        },             
        resetVariables: function(){
            var self = this;

            //clear list of budgets and total calculations
            self.budgets = [];
            self.budget_total.predicted_expences = 0;
            self.budget_total.actual_expences = 0;


             // Use new Date() to generate a new Date object containing the current date and time.
            var today = new Date();
            var dd = String(today.getDate()).padStart(2, '0');
            var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
            var yyyy = today.getFullYear();
            
            //self.budget_item.created_at = yyyy + '-' + mm + '-' + dd;     

            self.budget_item = {
                id : 0,
                planning_name : '',
                budget_amount : 0,
                budget_amount_actual : 0,
                is_start : 0,
                is_done : 0,
                budget_date : yyyy + '-' + mm + '-' + dd,
                is_new : false
            }; 
            
            //reset chart data
            self.chart_data = [];
        }
    }
});

const vm = app.mount('#budget');