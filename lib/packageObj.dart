

class Package {
  String id;
  String tracking;
  String timestamp;
  String deliverStatus;
  String courrier;
  String origin;
  String destination;
  String serviceType;
  String imgURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Icon-round-Question_mark.jpg/1024px-Icon-round-Question_mark.jpg";
  List<String> event = [];
  List<String> eventTime = [];

  String statusCode = "";
  set setStatusCode(String code) {
    statusCode = code;
  }
  String get getCode {
    return statusCode;
  }

  set setCourrierLogo(String courrier) {
    if (courrier.toUpperCase() == "USPS") {
      imgURL = "https://pbs.twimg.com/profile_images/864100712883597313/a1fN6W7g_400x400.jpg";
    } else if (courrier.toUpperCase() == "UPS") {
      imgURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/United_Parcel_Service_logo_2014.svg/402px-United_Parcel_Service_logo_2014.svg.png";
    } else if (courrier.toUpperCase() == "FEDEX") {
      imgURL =  "https://lh3.googleusercontent.com/YtXTsa-6SaaMl02-OUo8iRztlX5Thu4aCLavunIV1M5hm9y4ySTPpMjpY44fL4ayz7Se";
    } else if (courrier.toUpperCase() == "DHL"){
      imgURL = "https://www.crazy-stuff.net/crazy-img/content/logos/84-dhl.jpg";
    } else {
      imgURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Icon-round-Question_mark.jpg/1024px-Icon-round-Question_mark.jpg";
    }
  }

  String get getCourrierLogo {
    return imgURL;
  }


  Package(this.id,this.tracking,this.deliverStatus,this.timestamp,this.courrier,this.event,this.eventTime,this.origin,this.destination,this.serviceType);

}