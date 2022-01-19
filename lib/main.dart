import 'package:TrackOn/main2.dart';
import 'package:TrackOn/packageAPI.dart';
import 'package:TrackOn/packageObj.dart';
import 'package:TrackOn/packageDetail.dart';
import 'package:flutter/material.dart';
import 'package:TrackOn/sideMenu.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  List<Package> packageList = <Package>[];
  _MyHomePageState() {
    packageList = [];
  }

  Widget getTileView() {
    return packageList.isNotEmpty
        ? ListView.builder(
        itemCount: packageList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              //print("Go to package detail");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PackageDetail(packageList[index], packageList)),
              ).then((value) => setState(() {}));
              print(packageList[index].id);
              getAPIDhl((packageList[index].tracking), packageList[index]);
            },
            title: Container(
              height: 50,
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(packageList[index].getCourrierLogo),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${packageList[index].deliverStatus}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text('${packageList[index].tracking}',
                        style: TextStyle(
                            fontSize: 10
                        ),
                      ),
                      Text('${packageList[index].courrier}',
                        style: TextStyle(
                            fontSize: 10
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text('${packageList[index].timestamp}',
                      style: TextStyle(
                          fontSize: 9
                      )
                  )
                ],
              ),
            ),
          );
        })
      : Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Center(
                  child: Text(
                  "NO \u{1F4E6} FOUND!",
                  style: TextStyle(
                    fontSize: 30,
                  )),
                ),
                Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('Tap '),
                        Icon(Icons.add_circle),
                        Text(' to begin tracking a package'),
                      ],
                    )
                ),

              ]
            ),

          )

        ]
        );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.settings),
        //     onPressed: () {
        //
        //     },
        //   ),
        // ],
      ),
      body: getTileView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPackagePage(packageList)),
            ).then((value) => setState(() {}));
        },
        tooltip: 'Add a package tracking number to track',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
