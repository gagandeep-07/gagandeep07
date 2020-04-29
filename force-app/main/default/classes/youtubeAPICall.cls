public class youtubeAPICall {    
    public String kind;	//youtube#channelListResponse
    public String etag;	//"nxOHAKTVB7baOKsQgTtJIyGxcs8/vTpiUbKJgVANdpKL6W97KVANlj8"
	public cls_items[] items;
    class cls_items {
        
        public cls_snippet snippet;
        public cls_statistics statistics;
    }
    class cls_snippet {
        public String title;	//Salesforce Apex Hours
        public String description;	//“Salesforce Apex Hours” is a program Of the community, For the community and led By the community. A space that helps Salesforce experts across the globe share their expertise in various arenas with an intent to help the Ohana thrive!     
        public String country;	//US
    }
    
    
    class cls_statistics {
        public String viewCount;	//487672
        public String commentCount;	//0
        public String subscriberCount;	//10500
        public boolean hiddenSubscriberCount;
        public String videoCount;	//114
    }
    
    /* public static fromJSON parse(String json){
return (fromJSON) System.JSON.deserialize(json, fromJSON.class);
}*/ 
    /*
Http h = new Http();
String url = 'https://www.googleapis.com/youtube/v3/channels?part=snippet%2CcontentDetails%2Cstatistics&id=UChTdRj6YfwqhR_WEFepkcJw&key=AIzaSyAAtVQBd0-g7XWZpnoL_LcsPR3aqWTx0Bw';

HttpRequest req = new HttpRequest();
req.setEndpoint(url);
req.setMethod('GET');
HttpResponse res = h.send(req);

system.debug('Response '+res.getBody());

youtubeAPICall ob = (youtubeAPICall)System.JSON.deserialize(res.getBody(), youtubeAPICall.class);
system.debug('ob  '+ob);
*/
    
}