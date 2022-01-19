import 'package:TrackOn/packageAPI.dart';
import 'package:flutter/material.dart';
import 'package:TrackOn/packageObj.dart';

class PackageDetail extends StatefulWidget {
  //const PackageDetail({Key? key}) : super(key: key);
  // List<Package> detail;
  var detail;
  List<Package> wholeList ;

  PackageDetail(this.detail, this.wholeList);
  @override
  _PackageDetailState createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  String getText(String widgetText) {
    if (widget.detail.deliverStatus == "Delivered") {
      return "\u{2714} Delivered";
    } else if (widget.detail.deliverStatus == "Shipment not found") {
      return "\u{274C} Shipment not found";
    } else {
      return widget.detail.deliverStatus;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.block),
              onPressed: () {
                widget.wholeList.remove(widget.detail);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        body: Container(
          child:
            FutureBuilder(
                future: getAPIDhl(widget.detail.tracking, widget.detail),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text("None");
                    case ConnectionState.waiting:
                      // return Dialog(
                      //     child: new Row(
                      //       //mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         new CircularProgressIndicator(),
                      //         //new Text("Loading..."),
                      //       ],
                      //     ),
                      // );
                      return Center(
                        child: SizedBox(
                            height: 100,
                            width: 100,
                            child: CircularProgressIndicator()
                        ),
                      );
                    case ConnectionState.active:
                      return Text("Active");
                    case ConnectionState.done:
                      return Column(
                        children: [
                          Expanded(
                            flex: 40,
                            child: Image(
                                image: AssetImage('assets/images/DHLlogo.png')
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 0),
                                  child: Text(
                                      getText(widget.detail.deliverStatus),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ),
                              ],
                            )
                          ),
                          Expanded(
                              flex: 7,
                              child: Column(
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 0, bottom: 0),
                                      child: Text(
                                        "From: ${widget.detail.origin}",
                                        //"${widget.wholeList[index].tracking}",
                                        // "Test",
                                        style: TextStyle(
                                            fontSize: 10
                                        ),
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 0, bottom: 0),
                                      child: Text(
                                        "To: ${widget.detail.destination}",
                                        //"${widget.wholeList[index].tracking}",
                                        // "Test",
                                        style: TextStyle(
                                            fontSize: 10
                                        ),
                                      )
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 0, bottom: 0),
                                      child: Text(
                                        "Service: ${widget.detail.serviceType} ",
                                        //"${widget.wholeList[index].tracking}",
                                        // "Test",
                                        style: TextStyle(
                                            fontSize: 10
                                        ),
                                      )
                                  ),
                                ],
                              )
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Tracking #: ${widget.detail.tracking}",
                                    //"${widget.wholeList[index].tracking}",
                                    // "Test",
                                    style: TextStyle(
                                      fontSize: 15
                                    ),
                                  )
                                )
                              ],
                            )
                          ),
                          Expanded(
                            flex: 50,
                            child: ListView.builder(
                              itemCount: widget.detail.event.length,
                              itemBuilder: (BuildContext context, int index) {
                            //     return ListTile(
                            //       title: Container(
                            //         child: Row(
                            //           children: <Widget>[
                            //             Flexible(
                            //               flex: 60,
                            //               child: Text(
                            //                 "${widget.detail.event[index]}",
                            //                   style: TextStyle(
                            //                     fontSize: 15,
                            //                   ),
                            //               ),
                            //             ),
                            //             Spacer(
                            //               flex: 30,
                            //             ),
                            //             Flexible(
                            //               flex: 20,
                            //               child: Text(
                            //                   "${widget.detail.eventTime[index]}",
                            //                   style: TextStyle(
                            //                     fontSize: 7,
                            //                   ),
                            //                 ),
                            //             ),
                            //
                            //
                            //       ],
                            //     ),
                            //   ),
                            // );
                                return ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 280,
                                        child: Flexible(
                                          child: Text(
                                            "${widget.detail.event[index]}",
                                            style: TextStyle(
                                              fontSize: 15,
                                            )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 80,
                                        alignment: Alignment.centerRight,
                                        child: Flexible(
                                          child: Text(
                                            "${widget.detail.eventTime[index]}",
                                              style: TextStyle(
                                                fontSize: 7,
                                              ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                );
                          }
                        )
                      )
                        ]
                      );
                    default:
                      return Text("?");
                  }
                }
            )

        )


    );
//       Column(
//         children: [
//           Expanded(
//             flex: 40,
//             child: Image(
//                 image: NetworkImage('https://www.dpdhl-brands.com/dhl/en/guides/design-basics/logo-and-claim/_jcr_content/parsys/imagetext/imagetextcontainer/image.coreimg.100.1024.png/1591965147742/versions-01.png')
//             ),
//           ),
//
//           Expanded(
//             flex: 9,
//             child: Column(
//               children: [
//                 Container(
//                   margin: EdgeInsets.only(top: 30, bottom: 0),
//                   child: Text(
//                       '${widget.detail.deliverStatus}',
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold
//                       )),
//                 ),
//               ],
//             )
//           ),
//
//           Expanded(
//             flex: 5,
//             child: Column(
//               children: [
//                 Container(
//                   // margin: EdgeInsets.only(top: 10, bottom: 10),
//                   child: Text(
//                     "${widget.detail.tracking}",
//                     //"${widget.wholeList[index].tracking}",
//                     // "Test",
//                     style: TextStyle(
//                       fontSize: 10
//                     ),
//                   )
//                 )
//               ],
//             )
//           ),
//
//           Expanded(
//             flex: 50,
//             child: ListView.builder(
//               itemCount: widget.detail.event.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return ListTile(
//                   title: Container(
//                     child: Row(
//                       children: <Widget>[
//                         // Text("${widget.detail.event[index]}"),
//                         // Spacer(),
//                         // Text(
//                         //   "timestamp",
//                         //   style: TextStyle(
//                         //     fontSize: 9,
//                         //   )
//                         // ),
//                         Flexible(
//                           child: Text(
//                             "${widget.detail.event[index]}",
//                               style: TextStyle(
//                                 fontSize: 14,
//                               ),
//                           ),
//                         ),
//                         Spacer(
//                           flex: 1,
//                         ),
//                         Text(
//                             "${widget.detail.eventTime[index]}",
//                             style: TextStyle(
//                               fontSize: 7,
//                             ),
//                           ),
//
//
//                       ],
//                     ),
//                   ),
//                 );
//               }
//             )
//           )
//
//
//         ],
//       )
//     );
   }
}
