public class youtubeAPICMPClass {
    
    @AuraEnabled 
    public Static Statistics getDetails(String channelId){
        Http h = new Http();
        String url = 'https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=UChTdRj6YfwqhR_WEFepkcJw&key=AIzaSyAAtVQBd0-g7XWZpnoL_LcsPR3aqWTx0Bw';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        
        system.debug('Response '+res.getBody());
        
        JSON2Apexgagan ob = (JSON2Apexgagan)System.JSON.deserialize(res.getBody(), JSON2Apexgagan.class);
        system.debug('ob  '+ob);
        Statistics ac = new Statistics();
        for(JSON2Apexgagan.items each : ob.items){
            ac.viewCount=each.statistics.viewCount;
            ac.commentCount=each.statistics.commentCount;
            ac.subscriberCount=each.statistics.subscriberCount;
            ac.subscriberCount=each.statistics.subscriberCount;
            ac.hiddenSubscriberCount=each.statistics.hiddenSubscriberCount;
            ac.videoCount=each.statistics.videoCount;
            
            //13:46:06:201 USER_DEBUG [16]|DEBUG|check  -Statistics:[commentCount=0, hiddenSubscriberCount=false, subscriberCount=10700, videoCount=114, viewCount=502229]
            system.debug('check  -'+each.statistics);
        }
        system.debug('ac'+ac);
        return ac;
    }
    public class Statistics {
        @AuraEnabled
        public String viewCount {get;set;} 
        @AuraEnabled
        public String commentCount {get;set;} 
        @AuraEnabled
        public String subscriberCount {get;set;} 
        @AuraEnabled
        public Boolean hiddenSubscriberCount {get;set;} 
        @AuraEnabled
        public String videoCount {get;set;} 
    }
    
}