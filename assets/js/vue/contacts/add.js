var Contacts = new Vue({
    el: '#contact',
    data: { },
    created: function () {
    },
    methods: {
        contactAdd: function () {
            var self = this;

            //assign contact data
            var data = {
                contact_name : $('#inputname').val(),
                address : $('#inputaddress').val(),
                city : $('#inputcity').val(),
                postal : $('#inputpostal').val(),
                country : $('#inputcountry').val(),
                province : $('#inputprovince').val(),
                phone : $('#inputphone').val(),
                email : $('#inputpemail').val(),
                note : $('#summernote').summernote('code'),
                csrf : $('#csrf').val()
            };

            //prepare data
            data = JSON.stringify(data);

            //submit data and update contact
            var update = $.post('/contacts/add/action', data);

            //get results
            update.done(function (data){                

                //turn result into javascript workable variable
                data = JSON.parse(data);

               if(data === true){                   
                    //Display a success toast, with a title
                    toastr.success("New contact has been successfully added");                
               }
               else if(data == false) {                  
                    // Display an error toast, with a title
                    toastr.error("Ops! There has been problem adding new contact...");
               }
            });

            update.always(function (data) {
            });
        }
    }
});