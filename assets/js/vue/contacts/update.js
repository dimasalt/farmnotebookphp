var Contacts = new Vue({
    el: '#contact',
    data: {},
    created: function () {
    },
    methods: {
        contactUpdate: function () {
            var self = this;

            //assign contact data
            var data = {
                id : $('#inputid').val(),
                contact_name : $('#inputname').val(),
                address : $('#inputaddress').val(),
                city : $('#inputcity').val(),
                postal : $('#inputpostal').val(),
                country : $('#inputcountry').val(),
                province : $('#inputprovince').val(),
                phone : $('#inputphone').val(),
                email : $('#inputpemail').val(),                 
                note: tinyMCE.get('contact_note').getContent(),
                //note: tinyMCE.activeEditor.getContent(),
                csrf : $('#csrf').val()
            };

            //prepare data
            data = JSON.stringify(data);

            //submit data and update contact
            var update = $.post('/contacts/update/action', data);

            //get results
            update.done(function (data){              

                //turn result into javascript workable variable
                data = JSON.parse(data);

               if(data === true){
                    toastr.success("Contact has been successfully updated.");                       
               }
               else if(data == false){
                toastr.success("Contact has been successfully updated.");             
               }
            });

            update.always(function (data) {
            });


          
        }
    }
});