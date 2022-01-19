import 'package:flutter/material.dart';
import 'package:TrackOn/packageObj.dart';

class AddPackagePage extends StatefulWidget {
  //const AddPackagePage({Key? key}) : super(key: key);

  List<Package> detail;

  AddPackagePage(this.detail);

  Package createNew(List<Package> detail, String text, String courrier) {
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch * 1000);
    return new Package("id"+(detail.length+1).toString(), text, "Tap to Update", date.toString(), courrier, [], [], "unknown", "unknown", "unknown");
  }


  @override
  _AddPackagePageState createState() => _AddPackagePageState();
}


class _AddPackagePageState extends State<AddPackagePage> {
  TextEditingController trackingController = new TextEditingController();
  TextEditingController courrierController = new TextEditingController();
  bool isChecked = false;

  showAlert(BuildContext context, String item) {
    Widget okay = TextButton(child: Text("OK"), onPressed: () {
      Navigator.pop(context);
    },);
    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text("The "+item+" is empty"),
      actions: [
        okay,
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Package")
      ),
      body: Column(
        children: [
          Expanded(
            flex: 15,
            child: Image(
              image: AssetImage('assets/images/shippingTruck.png')
            ),
          ),

          Expanded(
            flex: 50,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(
                      'Add a tracking number',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(right: 40, left: 40, bottom: 10),
                  child: TextField(
                    controller: trackingController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tracking number',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 40, left: 40, bottom: 40),
                  child: TextField(
                    controller: courrierController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Courrier',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 40, left: 40, bottom: 10),
                  child: Text("Only supporting DHL package for now, other courrier required payment for API access")
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (trackingController.text.isEmpty) {
                      showAlert(context, "tracking number");
                    } else if (courrierController.text.isEmpty) {
                      showAlert(context, "courrier");
                    } else {
                      var editCourrier = (courrierController.text).toUpperCase();
                      if (editCourrier != "USPS" && editCourrier != "FEDEX" && editCourrier != "UPS" && editCourrier != "DHL") {
                        editCourrier = "Others";
                      }


                      setState(() {
                        Package newItem = widget.createNew(widget.detail, trackingController.text, editCourrier);
                        newItem.setCourrierLogo = editCourrier;
                        widget.detail.add(newItem);
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Icon(Icons.arrow_forward_rounded),
                )
              ],
            )
          ),



        ],
        ),
      );


  }
}
