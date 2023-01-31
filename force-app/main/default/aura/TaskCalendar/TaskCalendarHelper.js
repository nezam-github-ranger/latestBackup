({
    getResponse: function(component) {
        var action = component.get("c.getTasks");       
			action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                console.log("Data => " + result);
                var eventArr = [];
                result.forEach(function(key) {
                    eventArr.push({
                        'id':key.Id,
                        'start':key.CreatedDate,
                        'end':key.CompletedDateTime,
                        'title':key.Status
                    });
                });
                console.log(eventArr);
                this.loadCalendar(eventArr);
                
            } else if (state === "INCOMPLETE") {
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Errorage: " + errors[0].message);
                    }
                } else {
                    console.log("Unknownr");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    loadCalendar :function(data){   
        var m = moment();
        $('#calendar').fullCalendar({
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay,listWeek'
            },
            defaultDate: m.format(),
            editable: true,
            navLinks: true, // can click day/week names to navigate views
            weekNumbers: true,
            weekNumbersWithinDays: true,
            weekNumberCalculation: 'ISO',
            editable: true,
            eventLimit: true,
            
            events:data
        });
    },
    
})