global class ApexExample implements Queueable {

    global void execute(QueueableContext context) {
        // Your code here
        System.debug('Queueable Called');
    }
}