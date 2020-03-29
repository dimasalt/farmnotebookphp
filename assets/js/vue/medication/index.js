var ForgotPassword = new Vue({
    el: '#medication',
    data: {
        meds : [],
        medication: {},
        alert : {
            error : false,
            success: false,
            message: ''
        }
    },
    created: function () {
        var self = this;

        //populate list of medications
        self.getList();
    },
    methods: {
        getList: function(){ //gets all medication items
            var self = this;

            var data = {};
            data = JSON.stringify(data);

            var medList = $.post("/medication/getList", data);

            medList.done(function (data) {
                if(data.length > 0)
                    self.meds = JSON.parse(data);
            });

            medList.always(function () {
            });


            // // Prevent default posting of form
            //event.preventDefault();
        },
        getOne: function(){     //gets one medication item
            var self = this;

            var data = {};
            data = JSON.stringify(data);

            var medOne = $.post("/medication/getOne", data);

            medOne.done(function (data) {
                if(data.length > 0)
                    self.meds = JSON.parse(data);
            });

            medOne.always(function () {
            });          
        }
    }
});