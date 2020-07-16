var ForgotPassword = new Vue({
    el: '#medication',
    data: {        
        medication: {
            med_name: '',
            med_price: '',
            med_on_hand: '',
            med_desc: '',
            med_instr: '',
            med_img: 'https://via.placeholder.com/250x200.jpg'
        }        
    },
    created: function () {
        var self = this;        
    },
    methods: {             
        addMedication: function(){
            var self = this;
            
            //adding csrf to medication object
            self.medication.csrf = $('#csrf').val();
            //get text from rich text editors
            self.medication.med_desc = tinyMCE.get('med_desc').getContent();
            self.medication.med_instr = tinyMCE.get('med_instr').getContent();

            //prepare data for php
            var data = self.medication;
            data = JSON.stringify(data);

            var addMed = $.post("/medication/add/action", data);

            addMed.done(function (data) {
                
               //reset medication object 
               //self.resetMedObj();

               data = JSON.parse(data);

                //if successfully added 
               if(data.result == true){  

                    //Display a success toast, with a title
                    toastr.success("Medication item has been successfully added. <br /> You will be redirected to an update page in 5 seconds...");    
                    
                    //window.location.href = '/medication/update/{id}';                                               
                    setTimeout(function(){
                        window.location.href="/medication/update/" + data.id; // The URL that will be redirected too.
                    }, 5000); // The bigger the number the longer the delay.
               }
               else if(data == false) {                                 
                   // Display an error toast, with a title
                   toastr.error("Ops..., there appears to be an issue with adding this medication item");
               }
            });

            addMed.always(function () {
            });
        },
        resetMedObj: function(){ //reset medication object
            var self = this;

            //medication object
            medication = {
                med_name: '',
                med_price: '',
                med_on_hand: '',
                med_desc: '',
                med_instr: '',
                med_img: ''
            }        
        }
    }
});