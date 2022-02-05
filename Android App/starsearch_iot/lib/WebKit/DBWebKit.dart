import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Main/Drawer.dart';
import '../Main/TabScreen.dart';

class WebViewContainer extends StatefulWidget {
  final link;

  WebViewContainer(this.link);

  @override
  createState() => _WebViewContainerState(this.link);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _link;
  final _key = UniqueKey();

  _WebViewContainerState(this._link);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Admin Site - WebKit'),
        ),
        drawer: MainDrawer(),
        bottomNavigationBar: TabScreen(4),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _link))
          ],
        ));
  }
}

void handleURLButtonPress(BuildContext context, String url) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => WebViewContainer(url)));
}
