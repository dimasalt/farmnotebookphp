var Contacts = new Vue({
    el: '#contacts',
    data: {
        contacts : [],
        contact_delete : {},
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
                if(data.length > 0){
                    self.contacts = JSON.parse(data);

                    for(var i = 0; i< self.contacts.length; i++){
                        var link = self.contacts[i].address + ', ' + self.contacts[i].city + ', ' + self.contacts[i].province + ', ' + self.contacts[i].country;
                        self.contacts[i].link = 'http://maps.google.com/maps?q=' + encodeURIComponent(link);
                    }
                    //JSON.parse(data);
                }
            });

            contList.always(function () {
            });


            // // Prevent default posting of form
            //event.preventDefault();
        },
        deleteContacModal : function(index){
            var self = this;

            //reset all messages and alerts
            self.resetAlert();

            //assign value to delete contact object
            self.contact_delete = self.contacts[index];
            self.contact_delete.index = index;

            //show the modal
            $('#deleteModal').modal('show');

        },
        deleteContact: function () {
            var self = this;

            //hide modal
            $('#deleteModal').modal('hide');

            var data = { id : self.contact_delete.id};
            data = JSON.stringify(data);

            var del = $.post("/contacts/delete", data);

            del.done(function (data) {
                data = JSON.parse(data);
                //if successfully removed remove from the local javascript array
               if(data == true){

                   self.contacts.splice(self.contact_delete.index, 1);

                   self.alert.success = true;
                   self.alert.message = 'Contact has been successfully removed.';

                   //put alert message on timer
                   setTimeout(function() {
                       $("#success-alert").alert('close');
                   }, 6000);

                   //finally reset contact delete
                   self.resetContactDelete();
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
        resetContactDelete : function () {
            var self = this;
            self.contact_delete = {};
        },
        resetAlert: function () {
            var self = this;
            self.alert.error = false;
            self.alert.success = false;
            self.alert.message = '';
        }
    }
});