// Define a new global component called button-counter
const transactionList = {
  data() {
    return {
      transactions: []
    }
  },
  created (){
    var self = this;
    self.transactionsGetAll(); //get all transactions
  },
  methods: {
    transactionsGetAll () {
        //gets all project items
        var self = this;           

        var data = {};
        data = JSON.stringify(data);

        var projectsList = $.post("/finances/transactions/get/all", data);

        projectsList.done(function (data) {
            if (data.length > 0) {
                data = JSON.parse(data);

                for (var i = 0; i < data.length; i++) {

                    //check for red or green success class styling
                    if (data[i].trans_ammount < 0) data[i].class = "text-danger";
                    else if (data[i].trans_ammount > 0) data[i].class = "text-success";
                }
                
                self.transactions = data;
            }
        });

        projectsList.always(function () { });
    }
  },
  template: '#transaction-list'
};




