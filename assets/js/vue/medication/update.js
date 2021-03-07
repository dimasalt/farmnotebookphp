var UpdateMedication = new Vue({
    el: '#medication',
    data: {     
        medication: {}     
    },
    created: function () {
        var self = this;

        //populate list of medications
        self.getMedication();
    },
    methods: {      
        getMedication: function(){     //gets one medication item
            var self = this;

            var id = $('#id').val();

            var data = {id : id};
            data = JSON.stringify(data);

            var medOne = $.post("/medication/getOne", data);

            medOne.done(function (data) {
                if(data.length > 0)
                    self.medication = JSON.parse(data);
            });

            medOne.always(function () {
            });          
        },       
        updateMed: function(){
            var self = this;            

              var data = {id : self.medication.id };

              data = JSON.stringify(data);

              var del = $.post("/medication/delete", data);

              del.done(function (data) {
                
               self.medication = {} ;

               data = JSON.parse(data);
                //if successfully removed remove from the local javascript array
               if(data == true){
                    self.getList();

                    //Display a success toast, with a title
                    toastr.success("Selected medication has been successfully removed.");                                                   
               }
               else if(data == false) {                                 
                   // Display an error toast, with a title
                   toastr.error("Ops..., there appears to be an issue with removing this medication item");
               }
            });

            del.always(function () {
            });
        }
    }
});