public class MyUserLoginProcessor {

    public static List<UserLogin__c> enhanceLoginDetails() {

        Map<Id,User> userMap = new Map<Id,User>();
        for(User u : [Select Id, FirstName,LastName from User]){
          userMap.put(u.Id,u);
        }
         
        List<LoginHistory> logins = new List<LoginHistory>();
        List<UserLogin__c> userLogins = new List<UserLogin__c>();
        // Adding limit for now, but since this table is huge, I would suggest you add some filter like time or user.
        logins = [Select Id, LoginTime,UserId from LoginHistory order by LoginTime LIMIT 100];
        for(LoginHistory lh : logins){
            // Get the user firstName LastName
             String firstName = userMap.get(lh.UserId).FirstName;
             String lastName = userMap.get(lh.UserId).FirstName;
             
             UserLogin__c loginDetails = new UserLogin__c();
             loginDetails.Fullname__c = lastName +','+ firstName;
             loginDetails.Login_History_Id__c = lh.Id;
             
             userLogins.add(loginDetails);
        }
        
        return userLogins;
    }
    
}