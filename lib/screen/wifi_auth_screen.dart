import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';

class WifiAuthScreen extends StatefulWidget {
  const WifiAuthScreen({super.key});

  @override
  WifiAuthScreenState createState() => WifiAuthScreenState();
}

class WifiAuthScreenState extends State<WifiAuthScreen> {
  final _storage = const FlutterSecureStorage();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  InAppWebViewController? _webViewController;
  bool isConnectedToInternet = false;
  StreamSubscription? _internetStreamSubscription;

  @override
  void dispose() {
    _internetStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCredentials();
    _internetStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            isConnectedToInternet = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnectedToInternet = false;
          });
          break;
      }
    });
  }

  Future<void> _loadCredentials() async {
    _usernameController.text = await _storage.read(key: 'username') ?? '';
    _passwordController.text = await _storage.read(key: 'password') ?? '';
  }

  Future<void> _saveCredentials() async {
    await _storage.write(key: 'username', value: _usernameController.text);
    await _storage.write(key: 'password', value: _passwordController.text);
  }

  void _autoFillAndLogin() {
    _webViewController?.evaluateJavascript(source: """
        document.getElementById('username').value = '${_usernameController.text}';
        document.getElementById('password').value = '${_passwordController.text}';
        document.getElementById('loginbutton').click();
      """);
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Your Credentials'),
            content: const Text('For Credentials'),
            actions: <Widget>[
              Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _saveCredentials();
                      _autoFillAndLogin();
                      Navigator.pop(context);
                    },
                    child: const Text('Login'),
                  ),
                ],
              )
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int page = 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          _webViewController?.evaluateJavascript(source: """
        document.getElementById('username').value = '${_usernameController.text}';
        document.getElementById('password').value = '${_passwordController.text}';
        document.getElementById('loginbutton').click();
      """);
        },
        label: const Text("AutoLogin"),
        icon: const Icon(Icons.star),
        style: const ButtonStyle(
          elevation: WidgetStatePropertyAll(5),
          minimumSize: WidgetStatePropertyAll(Size(60, 60)),
          backgroundColor: WidgetStatePropertyAll(
            Color.fromARGB(225, 93, 193, 243),
          ),
          iconColor: WidgetStatePropertyAll(Colors.black87),
          foregroundColor: WidgetStatePropertyAll(Colors.black87),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: SafeArea(
        child: CurvedNavigationBar(
          items: const <Widget>[
            Icon(
              Icons.home,
              size: 33,
            ),
            Icon(
              Icons.menu_book,
              size: 33,
            ),
            Icon(
              Icons.wifi,
              size: 33,
            ),
            Icon(
              Icons.person,
              size: 33,
            ),
          ],
          color: const Color.fromARGB(225, 93, 193, 243),
          backgroundColor: const Color.fromARGB(182, 255, 255, 255),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
        ),
      ),
      appBar: AppBar(
        title: const Text('VConnect'),
        actions: [
          IconButton(
            onPressed: () {
              _showAlertDialog();
            },
            icon: const Icon(Icons.person_add),
          )
        ],
        backgroundColor: const Color.fromARGB(225, 93, 193, 243),
      ),
      body: isConnectedToInternet
          ? Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: WebUri.uri(
                            Uri.parse('https://hfw.vitap.ac.in:8090/'))),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        javaScriptEnabled: true,
                      ),
                    ),
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    onReceivedServerTrustAuthRequest:
                        (controller, challenge) async {
                      return ServerTrustAuthResponse(
                          action: ServerTrustAuthResponseAction.PROCEED);
                    },
                  ),
                ),
              ],
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/animation/Animation_wifi.json"),
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(225, 93, 193, 243),
                      ),
                      height: 250,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text(
                          "CONNECT TO THE HOSTEL WIFI \n& ADD YOUR CREDENTIALS",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
