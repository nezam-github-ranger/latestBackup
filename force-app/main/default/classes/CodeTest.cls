public class CodeTest {
    
    public static void forUpdateUse(){
    	Contact [] accts = [SELECT Id, LastName FROM Contact LIMIT 2 FOR UPDATE];
        System.debug('accts[0] ==> ' + accts[0].Id + ' || accts[0] ==> ' + accts[1].Id);
        System.debug('accts[0] ==> ' + accts[0].LastName + ' || accts[0] ==> ' + accts[1].LastName);
        accts[1].LastName = 'Again Change';
        UPDATE accts;
    }

}