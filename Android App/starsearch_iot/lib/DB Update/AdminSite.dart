import 'package:flutter/material.dart';
import '../Main/TabScreen.dart';
import '../Main/Drawer.dart';
import '../../WebKit/DBWebKit.dart';

class DBUpdate extends StatelessWidget {
  static const routeName = '/siteupdate';
  final link = 'http://starsearch.lohseng.tech:5000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Database Update')),
        drawer: MainDrawer(),
        bottomNavigationBar: TabScreen(3),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            InkWell(
              onTap: () {
                handleURLButtonPress(context, link);
              },
              borderRadius: BorderRadius.circular(15),
              splashColor: Theme.of(context).primaryColor,
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Text(
                  'Warning:\nAdmin Access Only!',
                  style: Theme.of(context).textTheme.headline4,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrangeAccent.withOpacity(0.8),
                      Colors.orange,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
          ]),
        )));
  }
}

void handleURLButtonPress(BuildContext context, String url) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WebViewContainer(url)));
}
