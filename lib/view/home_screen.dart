import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sizer/sizer.dart';

class Home_Screem extends StatefulWidget {
  const Home_Screem({Key? key}) : super(key: key);

  @override
  _Home_ScreemState createState() => _Home_ScreemState();
}

class _Home_ScreemState extends State<Home_Screem> {
  TextEditingController txtsarch = TextEditingController();
  InAppWebViewController? webcontroller;
  PullToRefreshController? pullToRefreshController;

  @override
  void initState() {
    pullToRefreshController = PullToRefreshController(
      onRefresh: () {
        webcontroller!.reload();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5.h,
                  width: 97.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: txtsarch,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search here",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.arrow_forward, color: Colors.black),
                        onPressed: () {
                          webcontroller!.loadUrl(
                            urlRequest: URLRequest(
                              url: Uri.parse(
                                  "https://www.google.com/search?q=${txtsarch.text}"),
                            ),
                          );
                            },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest:
                    URLRequest(url: Uri.parse("https://www.google.com/")),
                onLoadStart: (controller, url) {
                  webcontroller = controller;
                  pullToRefreshController!.endRefreshing();
                },
                onLoadStop: (controller, url) {
                  webcontroller = controller;
                  pullToRefreshController!.endRefreshing();
                },
                onLoadError: (controller, url, code, message) {},
                onProgressChanged: (controller, progress) {
                  webcontroller = controller;
                  pullToRefreshController!.endRefreshing();
                },
                pullToRefreshController: pullToRefreshController,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => webcontroller!.goBack(),
                  icon: Icon(Icons.arrow_back_rounded),
                  iconSize: 27,
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () => webcontroller!.reload(),
                  icon: Icon(Icons.refresh_rounded),
                  iconSize: 27,
                  color: Colors.black,
                ),
                IconButton(
                  onPressed: () => webcontroller!.goForward(),
                  icon: Icon(Icons.arrow_forward_rounded),
                  iconSize: 27,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
