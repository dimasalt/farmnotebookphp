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
                note : $('#summernote').summernote('code'),
                csrf : $('#csrf').val()
            };

            //prepare data
            data = JSON.stringify(data);

            //submit data and update contact
            var update = $.post('/contacts/update/action', data);

            //get results
            update.done(function (data){

                //clear alerts
                self.resetAlert();

                //turn result into javascript workable variable
                data = JSON.parse(data);

               if(data === true){
                    self.alert.message = 'Contact has been successfully updated';
                    self.alert.success = true;
               }
               else {
                   self.alert.message = 'Ops! There has been problem updating contact...';
                   self.alert.error = true;
               }
            });

            update.always(function (data) {
            });


            // var data = { id : self.contact_delete.id};
            // data = JSON.stringify(data);
            //
            // var del = $.post("/contacts/delete", data);
            //
            // del.done(function (data) {
            //     data = JSON.parse(data);
            //     //if successfully removed remove from the local javascript array
            //     if(data == true){
            //
            //         self.contacts.splice(self.contact_delete.index, 1);
            //
            //         self.alert.success = true;
            //         self.alert.message = 'Contact has been successfully removed.';
            //
            //         //put alert message on timer
            //         setTimeout(function() {
            //             $("#success-alert").alert('close');
            //         }, 6000);
            //
            //         //finally reset contact delete
            //         self.resetContactDelete();
            //     }
            //     else {
            //         self.alert.error = true;
            //         self.alert.message = 'Ops..., there appears to be an issue with removing this contact';
            //
            //         //put alert message on timer
            //         setTimeout(function() {
            //             $("#error-alert").alert('close');
            //         }, 6000);
            //     }
            // });
            //
            // del.always(function () {
            // });
        },
        resetAlert: function () {
            var self = this;
            self.alert.error = false;
            self.alert.success = false;
            self.alert.message = '';
        }
    }
});