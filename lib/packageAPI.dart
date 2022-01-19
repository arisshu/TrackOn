import 'dart:convert';
import 'package:TrackOn/packageObj.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
//Request only work for DHL Courrier only
Future<void> getAPIDhl(String tracking, Package currentObj) async {
  var headers = {
    'DHL-API-Key': 'demo-key',
  };

  var params = {
    'trackingNumber': '${tracking}',
  };
  var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

  var res = await http.get(Uri.parse('https://api-eu.dhl.com/track/shipments?$query'), headers: headers);
  if (res.statusCode != 200) {
    if (res.statusCode == 429) {
      currentObj.deliverStatus = "Rate Limited, try new IP";
    } else if (res.statusCode == 404){ {
      currentObj.deliverStatus = "Shipment not found";
    }
      currentObj.setStatusCode = res.statusCode.toString();
    }

    throw Exception('http.get error: statusCode= ${res.statusCode}');
  }
    //print(res.body);


    //final value2 = '{"shipments":[{"id":"2363770146","service":"express","origin":{"address":{"addressLocality":"TOKYO - JAPAN"},"servicePoint":{"url":"http://www.dhl.co.jp/en/country_profile.html","label":"Origin Service Area"}},"destination":{"address":{"addressLocality":"LOS ANGELES, CA - USA"},"servicePoint":{"url":"http://www.dhl-usa.com/en/country_profile.html","label":"Destination Service Area"}},"status":{"timestamp":"2021-12-29T10:21:00","location":{"address":{"addressLocality":"LOS ANGELES, CA - USA"}},"statusCode":"delivered","status":"delivered","description":"Delivered"},"details":{"proofOfDelivery":{"timestamp":"2021-12-29T10:21:00","signatureUrl":"https://webpod.dhl.com/webPOD/DHLePODRequest?hwb=L1%2FPNz0lDwdEz9PhLNgG6w%3D%3D&pudate=EZY5ht1pEYgurtHEdInzNQ%3D%3D&appuid=ImV4pRFulf2Dr7izJUuJFQ%3D%3D&language=en&country=G0","documentUrl":"https://webpod.dhl.com/webPOD/DHLePODRequest?hwb=L1%2FPNz0lDwdEz9PhLNgG6w%3D%3D&pudate=EZY5ht1pEYgurtHEdInzNQ%3D%3D&appuid=ImV4pRFulf2Dr7izJUuJFQ%3D%3D&language=en&country=G0","signed":{"@type":"Person","name":"Delivered"}},"proofOfDeliverySignedAvailable":false,"totalNumberOfPieces":1,"pieceIds":["JD014600009057819381"]},"events":[{"timestamp":"2021-12-29T10:21:00","location":{"address":{"addressLocality":"LOS ANGELES, CA - USA"}},"description":"Delivered","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-29T08:35:00","location":{"address":{"addressLocality":"LOS ANGELES, CA - USA"}},"description":"Shipment is out with courier for delivery","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-28T09:01:00","location":{"address":{"addressLocality":"LOS ANGELES, CA - USA"}},"description":"Arrived at DHL Delivery Facility LOS ANGELES - USA","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-28T08:51:00","location":{"address":{"addressLocality":"LOS ANGELES GATEWAY, CA - USA"}},"description":"Shipment has departed from a DHL facility LOS ANGELES GATEWAY - USA","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-28T07:45:00","location":{"address":{"addressLocality":"LOS ANGELES GATEWAY, CA - USA"}},"description":"Processed at LOS ANGELES GATEWAY - USA","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-28T05:50:00","location":{"address":{"addressLocality":"LOS ANGELES GATEWAY, CA - USA"}},"description":"Clearance processing complete at LOS ANGELES GATEWAY - USA"},{"timestamp":"2021-12-28T04:47:00","location":{"address":{"addressLocality":"LOS ANGELES GATEWAY, CA - USA"}},"description":"Shipment is on hold","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-28T04:45:00","location":{"address":{"addressLocality":"LOS ANGELES GATEWAY, CA - USA"}},"description":"Arrived at DHL Sort Facility LOS ANGELES GATEWAY - USA","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-28T00:47:00","location":{"address":{"addressLocality":"TOKYO - JAPAN"}},"description":"Shipment has departed from a DHL facility TOKYO - JAPAN","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-27T18:34:00","location":{"address":{"addressLocality":"TOKYO - JAPAN"}},"description":"Processed at TOKYO - JAPAN","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-27T18:23:00","location":{"address":{"addressLocality":"TOKYO - JAPAN"}},"description":"Customs clearance status updated. Note; The Customs clearance process may start while the shipment is in transit to the destination."},{"timestamp":"2021-12-27T16:38:00","location":{"address":{"addressLocality":"TOKYO - JAPAN"}},"description":"Shipment picked up","pieceIds":["JD014600009057819381"]},{"timestamp":"2021-12-27T16:21:00","location":{"address":{"addressLocality":"LOS ANGELES GATEWAY, CA - USA"}},"description":"Customs clearance status updated. Note; The Customs clearance process may start while the shipment is in transit to the destination."}]}],"possibleAdditionalShipmentsUrl":["/track/shipments?trackingNumber=2363770146&service=freight","/track/shipments?trackingNumber=2363770146&service=dgf","/track/shipments?trackingNumber=2363770146&service=ecommerce","/track/shipments?trackingNumber=2363770146&service=parcel-de","/track/shipments?trackingNumber=2363770146&service=parcel-nl","/track/shipments?trackingNumber=2363770146&service=parcel-pl","/track/shipments?trackingNumber=2363770146&service=post-de","/track/shipments?trackingNumber=2363770146&service=sameday","/track/shipments?trackingNumber=2363770146&service=parcel-uk"]}';
    final value = jsonDecode(res.body);

    //print(value["shipments"][0]["status"]["description"]);
    currentObj.deliverStatus = value["shipments"][0]["status"]["description"];

    print(value["shipments"][0]["events"].length);

    //Set trackingNum
    currentObj.tracking = value["shipments"][0]["id"];
    currentObj.setStatusCode = res.statusCode.toString();

    //Set origin
    currentObj.origin = value["shipments"][0]["origin"]["address"]["addressLocality"];

    //set destination
    currentObj.destination = value["shipments"][0]["destination"]["address"]["addressLocality"];

    //set serviceType
    currentObj.serviceType = value["shipments"][0]["service"];

    if (currentObj.event.length != 0) {
      currentObj.event.clear();
      currentObj.eventTime.clear();
    }
    for (var i = 0; i < value["shipments"][0]["events"].length; i++) {
      currentObj.event.add((value["shipments"][0]["events"][i]["description"]));
      currentObj.eventTime.add((value["shipments"][0]["events"][i]["timestamp"]));
    }
  }




