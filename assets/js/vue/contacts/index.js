const contacts = {
    data(){
        return {
            contacts : [],
            contacts_count : 0,
            contact_item : {},
            contact_type : [],
            contact_selected : -1,
            contact_type_selected : -1,
            search_term: '',
            contact_delete : {},
            action : ''
        }
    },
    created() {
        var self = this;

        //set select for contacts or vendors
        self.contact_type = [
            {contact_type : 1, name : 'vendor' },
            {contact_type : 2, name : 'customer' },
            {contact_type : 3, name : 'contacts'},
        ];

        //reset/set all the variables
        self.resetContact();

        //populate list of contacts
        self.contactsGetAll();
    },
    methods: {
        contactsGetAll(){
            var self = this;

            self.contacts_count = 0;

            var data = {search_term: self.search_term, contact_type: self.contact_selected};
            data = JSON.stringify(data);

            var contList = $.post("/contacts/get/all", data);

            contList.done(function (data) {
                if(data.length > 0){
                    self.contacts = JSON.parse(data);

                    for(var i = 0; i< self.contacts.length; i++){
                        var link = self.contacts[i].address;
                        self.contacts[i].link = 'http://maps.google.com/maps?q=' + encodeURIComponent(link);

                        //add count
                        self.contacts_count ++;
                    }                   
                }
            });

            contList.always(function () {
            });

            // // Prevent default posting of form
            //event.preventDefault();
        },
        contactAddOrEdit() {
            var self = this;

            //assign contact data
            var data = {
                id : self.contact_item.id,
                name : self.contact_item.name,
                address : self.contact_item.address,
                phone: self.contact_item.phone,
                email: self.contact_item.email,
                note: self.contact_item.note,
                contact_type : self.contact_type_selected,               
                csrf : $('#csrf').val()
            };

            //prepare data
            data = JSON.stringify(data);

            //check if it's new item or update
            if (typeof self.contact_item.id == "undefined" || self.contact_item.id.length == 0 ) {
            // if(self.contact_item.id.length == 0){
                 //submit data and add new contact
                var result = $.post('/contacts/add', data);
            }
            else { //otherwise update existing contac
                //submit data and update contact
                var result = $.post('/contacts/update', data);
            }           

            //get results
            result.done(function (data){                

                //turn result into javascript workable variable
                data = JSON.parse(data);

               if(data === true){                   
                    //Display a success toast, with a title
                    toastr.success("Contact has been successfully saved");   
                    
                    //reset variables
                    self.resetContact();

                    //load new uddated contact list
                    self.contactsGetAll();
               }
               else if(data == false) {                  
                    // Display an error toast, with a title
                    toastr.error("Ops! There has been problem with saving a contact...");
               }
            });

            result.always(function (data) {
            });
        },
        contactEditFormShow(index){
            var self = this;

            //copy object for editing
            self.contact_item = Object.assign({}, self.contacts[index] );

            //assign value for select box
            self.contact_type_selected = self.contact_item.type;

            //set action
            self.action = 'edit';
        },
        deleteContacModalShow(index){
            var self = this;           

            //assign value to delete contact object
            self.contact_delete = self.contacts[index];
            self.contact_delete.index = index;

            //show the modal
            $('#deleteModal').modal('show');

        },
        deleteContacModalHide(index){
            var self = this;           

            //show the modal
            $('#deleteModal').modal('hide');

            //reset variables
            self.resetContact();

        },
        deleteContact() {
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

                   //self.contacts.splice(self.contact_delete.index, 1);                

                    //Display a success toast, with a title
                    toastr.success("Selected contact has been successfully removed.");                                

                   //finally reset contact delete
                   self.resetContact();

                   //get updated contact list
                   self.contactsGetAll();
               }
               else if(data == false) {                                 
                   // Display an error toast, with a title
                   toastr.error("Ops..., there appears to be an issue with removing this contact");
               }
            });

            del.always(function () {
            });
        },
        //reset all local variables
        resetContact() {
            var self = this;

            self.contact_delete = {};

            self.contact_item = {
                id : '',
                name : '',
                address: '',
                phone: '',
                email: '',
                is_vendor : false
            };

            self.action = '';
        }        
    }
};

const app = Vue.createApp(contacts)
                .mount('#contacts');