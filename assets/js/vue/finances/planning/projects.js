var PlanningProjects = new Vue({
    el: "#projects",
    data: {
        starting_expence: {},
        project_item_new : {
            project_name : '',
            project_price : '',
            project_price_actual : '',
            is_start : 0,
            created_at : ''
        },
        project_item_new_visible: false,     
        project_item_delete : {},
        project_item_edit : {},
        projects: [],
        projects_total: {
            predicted_expences: 0,
            actual_expences: 0,
            predicted_expences_class: "",
            actual_expences_class: ""
        },
        chart_data : [] //data for date chart
    },
    created: function () {
        var self = this;

        //get all the projects
        self.getProjects();

        // Use new Date() to generate a new Date object containing the current date and time.
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear();
        
        self.project_item_new.created_at = yyyy + '-' + mm + '-' + dd;     
    },
    methods: {
        getProjects: function () {
            //gets all project items
            var self = this;

            //clear list of projects and total calculations
            self.projects = [];
            self.projects_total.predicted_expences = 0;
            self.projects_total.actual_expences = 0;

            var data = {};
            data = JSON.stringify(data);

            var projectsList = $.post("/finances/projects/get/all", data);

            projectsList.done(function (data) {
                if (data.length > 0) {                  

                    data = JSON.parse(data);

                     // Create USD currency formatter.
                     var formatter = new Intl.NumberFormat('en-US', {
                        style: 'currency',
                        currency: 'USD',
                    });

                    for (var i = 0; i < data.length; i++) {

                        //check for red or green success class styling
                        if (data[i].project_price < 0) data[i].class = "text-danger";
                        else if (data[i].project_price > 0) data[i].class = "text-success";

                        //convert money to familiar usd format
                        data[i].project_price_formated = formatter.format(data[i].project_price);
                        data[i].project_price_actual_formated = formatter.format(data[i].project_price_actual);


                        //check if project is done
                        if(data[i].is_done == 1){
                            data[i].class = data[i].class + ' ' + "remove-line";
                            data[i].checked = true;
                        }
                        else data[i].checked = false;

                        //check for start point
                        if (data[i].is_start == 1) {
                            self.starting_expence = data[i];                       
                        }
                        else {
                              //set edit to invisible
                            data[i].is_edit = false;

                            //populate projects list
                            self.projects.push(data[i]);      
                        }

                        //calculate predicted and actual expences
                        self.projects_total.predicted_expences =
                            self.projects_total.predicted_expences +
                            parseInt(data[i].project_price);
                        self.projects_total.actual_expences =
                            self.projects_total.actual_expences +
                            parseInt(data[i].project_price_actual);                                                                          
                    }                                                                                           

                    //format total numbers to usd currency
                    self.projects_total.predicted_expences_formated = formatter.format(self.projects_total.predicted_expences);
                    self.projects_total.actual_expences_formated = formatter.format(self.projects_total.actual_expences);
                }

                //assign information for the chart
                self.chart_data = data;
                self.chartJS();

                //self.plotlyChart();
            });

            projectsList.always(function () { });
        },
        editShow: function(index){ //displays edit forms
            var self = this;

            //close any open edit forms
            for(var i = 0; i < self.projects.length; i++)
                self.projects[i].is_edit = false;

            //display edit forms
            self.projects[index].is_edit = true;

            //assing values
            self.project_item_edit = self.projects[index];
        },
        editCancel: function(index){ //hides edit forms
            var self = this;

            //hide edit forms
            //self.projects[index].is_edit = false;
            self.project_item_edit = {};
            self.getProjects();
        }, 
        editOne: function (index) {
            //remove one project item
            var self = this;   
            
            var data = self.project_item_edit;   
            data.csrf = $('#csrf').val();
            

            data = JSON.stringify(data);
           
            //close any open edit forms
            for(var i = 0; i < self.projects.length; i++)
                self.projects[i].is_edit = false;           

            var projectedit = $.post("/finances/projects/update", data);

            projectedit.done(function (data) {
                data = JSON.parse(data);             

                if (data == true) {

                    //reset edit project item
                    self.project_item_edit = {};

                    //reset abd load projects again                    
                    self.getProjects();

                    //Display a success toast, with a title
                    toastr.success("You have successfully updated selected project");                
                }
                else if(data == false){
                    // Display an error toast, with a title
                    toastr.error("Ops! There appears to be an error and project coudln't be updated");
                }
                
            });

            projectedit.always(function () { });
        },
        editProjectStatus: function (id, index) {
            //remove one project item
            var self = this;   
            
            //set data variable
            var data;

            data = {
                id : self.projects[index].id,
                csrf : $('#csrf').val()
            };

            if(self.projects[index].checked == true)
                data.is_done = 1;
            else data.is_done = 0;                                      

            data = JSON.stringify(data);                    

            var projectedit = $.post("/finances/projects/updatestatus", data);

            projectedit.done(function (data) {
                data = JSON.parse(data);             

                if (data == true) {                  

                    //reset abd load projects again                    
                    self.getProjects();

                    //Display a success toast, with a title
                    toastr.success("You have successfully updated selected project status");                
                }
                else if(data == false){
                    // Display an error toast, with a title
                    toastr.error("Ops! There appears to be an error and project status coudln't be updated");
                }
                
            });

            projectedit.always(function () { });
        },
        delOneShow: function (id, project_name){ 
            //show remove item modal
            var self = this;
       
            //clear delete item
            self.project_item_delete = {};

            //assing values to the delete item
            self.project_item_delete.id = id;
            self.project_item_delete.project_name = project_name;

            //show the modal
             $('#deleteModal').modal('show');
        },  
        delOne: function () { 
            //remove one project item
            var self = this;

            //hide modal
            $('#deleteModal').modal('hide');

            var data = { 
                id: self.project_item_delete.id,
                csrf : $('#csrf').val()
            };
            data = JSON.stringify(data);

            var projectdel = $.post("/finances/projects/delete", data);

            projectdel.done(function (data) {
                data = JSON.parse(data);             

                if (data == true) {
                    if(self.starting_expence.id == self.project_item_delete.id)
                        self.starting_expence = {};
                    else {
                        for (var i = 0; i < self.projects.length; i++) {
                            if(self.projects[i].id == self.project_item_delete.id)
                                self.projects.splice(i, 1);                          
                        }
                    }    

                    //reload list of projects                    
                    self.getProjects();

                    //Display a success toast, with a title
                    toastr.success("You have successfully removed selected item");                
                }
                else if(data == false){
                    // Display an error toast, with a title
                    toastr.error("Ops! There appears to be an error and selected item coudln't t be removed");
                }
                
            });

            projectdel.always(function () { });
        },
        addNewShow: function(){
            var self = this;

            self.project_item_new_visible = true;
        },
        addNewHide: function(){
            var self = this;

            self.project_item_new_visible = false;
        },
        addNew: function (is_start) {
            //remove one project item
            var self = this;            

            //hide new project form
            self.project_item_new_visible = false;
           
            //set an actual expence if none been inserted
            if(self.project_item_new.project_price_actual == '')            
                self.project_item_new.project_price_actual = 0;        

            var data = self.project_item_new; 
 
            if(is_start == 1)
                data.project_price_actual = parseInt(data.project_price);                 
                        
            
            data.is_start = is_start;
            data.csrf = $('#csrf').val();  

            data = JSON.stringify(data);

            var projectdel = $.post("/finances/projects/add", data);

            projectdel.done(function (data) {
                data = JSON.parse(data);             

                if (data == true) {

                    //reset new project item and hide new project form if applicable                    
                    self.resetNewItem();

                    //reset abd load projects again                    
                    self.getProjects();

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
        chartJS : function(){   
            
            var self = this;    
            
            var timeFormat = 'YYYY/MM/DD';

            //assing data for labels and datasets
            var labels = [], data = [];            
            for(var i = 0; i < self.chart_data.length; i++){
                //labels.push(self.chart_data[i].project_name);

                if(data.length == 0)
                    data.push({ x: self.chart_data[i].created_at, y: self.chart_data[i].project_price  });
                else 
                {
                    var sum = parseInt(self.chart_data[i].project_price) + parseInt(data[i-1].y); 
                    data.push({ x: self.chart_data[i].created_at, y: sum  });
                }

            }

            var config = {
                type: 'line',
                data: {
                    //labels: labels,
                    datasets: [{
                        label: 'Predicted expenses',                                
                        backgroundColor : "#000000",                
                        borderColor: "#000000",
                        borderDash: [5, 5],
                        fill: false,
                        data: data
                    }]
                },
                options: {
                    responsive: true,
                    title: {
                        text: 'Predicted and Actual expenses',
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
            
            var ctx = document.getElementById("canvas").getContext("2d");
            var myChart = new Chart(ctx, config);
        },      
        plotlyChart: function()  {
            var self = this;

            var x = [], y = [];
            for(var i = 0; i < self.chart_data.length; i++){
                x.push(self.chart_data[i].created_at);

                if(y.length == 0)
                    y.push( self.chart_data[i].project_price );
                else 
                    y.push( parseInt(y[i-1]) + parseInt(self.chart_data[i].project_price ));    
            }

            var trace1 = {
                type: "scatter",
                mode: "lines",
                name: 'Predicted expenses',
                x: x,
                y: y,              
                line: {color: '#1E90FF'}
            };

            var data = [ trace1 ];

            var layout = {
                title: 'Predicted and Actual expenses',    
                xaxis: {
                    title: {
                      text: 'Date',
                      font: {
                        family: 'Verdana',
                        size: 16,
                        color: '#000000'
                      }
                    },
                  },
                  yaxis: {
                    title: {
                      text: '$',
                      font: {
                        family: 'Verdana',
                        size: 16,
                        color: '#000000'
                      }
                    }
                  }           
            };
              
            Plotly.newPlot('myDiv', data, layout);           
        },
        resetNewItem: function(){
            var self = this;

            self.project_item_new = {
                project_name : '',
                project_price : '',
                project_price_actual : 0,
                is_start : 0,
                created_at : ''
            };
        }
    }
});
