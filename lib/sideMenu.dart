import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class NavDrawer extends StatefulWidget {
  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Options',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          //   child: Column(
          //     children: [
          //       Text("Options"),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 15, right: 10),
          //   child:
          //   Row(
          //     children: <Widget>[
          //       Text("Dark Mode"),
          //       Spacer(),
          //       Switch(
          //         value: isSwitched,
          //         onChanged: (value) {
          //           setState(() {
          //             isSwitched = value;
          //             print(value);
          //           }
          //           );
          //         },
          //       )
          //     ],
          //   ),
          // ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('DHL Official Site'),
            onTap: () {
              const url = "https://dhl.com";
              launch(url);
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.verified_user),
          //   title: Text('Profile'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.border_color),
          //   title: Text('Feedback'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Logout'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
        ],
      ),
    );
  }

}