var Contacts = new Vue({
    el: '#contact',
    data: {
        alert : {
            error : false,
            success: false,
            message: ''
        }
    },
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

                //clear alerts
                self.resetAlert();

                //turn result into javascript workable variable
                data = JSON.parse(data);

               if(data === true){
                    self.alert.message = 'New contact has been successfully added';
                    self.alert.success = true;
               }
               else {
                   self.alert.message = 'Ops! There has been problem adding new contact...';
                   self.alert.error = true;
               }
            });

            update.always(function (data) {
            });
        },
        resetAlert: function () {
            var self = this;
            self.alert.error = false;
            self.alert.success = false;
            self.alert.message = '';
        }
    }
});