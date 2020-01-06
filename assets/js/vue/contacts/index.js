var Contacts = new Vue({
    el: '#contacts',
    data: {
        contacts : [],
        alert : {
            error : false,
            success: false,
            message: ''
        }
    },
    created: function () {
        var self = this;

        //populate list of contacts
        self.getAll();
    },
    methods: {
        getAll: function(){
            var self = this;

            var data = {};
            data = JSON.stringify(data);

            var contList = $.post("/contacts/getList", data);

            contList.done(function (data) {
                if(data.length > 0)
                    self.contacts = JSON.parse(data);
            });

            contList.always(function () {
            });


            // // Prevent default posting of form
            //event.preventDefault();
        },
        deleteContact: function (id, index) {
            var self = this;

            //reset all messages and alerts
            self.resetAlert();

            var data = { id : id};
            data = JSON.stringify(data);

            var del = $.post("/contacts/delete", data);

            del.done(function (data) {
                data = JSON.parse(data);
                //if successfully removed remove from the local javascript array
               if(data == true){

                   self.contacts.splice(index, 1);

                   self.alert.success = true;
                   self.alert.message = 'Contact has been successfully removed.';

                   //put alert message on timer
                   setTimeout(function() {
                       $("#success-alert").alert('close');
                   }, 6000);
               }
               else {
                   self.alert.error = true;
                   self.alert.message = 'Ops..., there appears to be an issue with removing this contact';

                   //put alert message on timer
                   setTimeout(function() {
                       $("#error-alert").alert('close');
                   }, 6000);
               }
            });

            del.always(function () {
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