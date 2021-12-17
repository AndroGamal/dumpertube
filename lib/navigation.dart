import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:youtube/history.dart';
import 'package:youtube/main.dart';

class navigation{
  String _textacount = "Example_test@gmail.com";
  late BuildContext _context;
  navigation(BuildContext context){_context=context;}
  Widget create(){
    return Container(
        width: 250,
        color: Colors.white,
        child: Column(children: [
          Container(
            color: Colors.red,
            height: 200,
            child: Center(
                child: Image.asset(
                  "assets/image/youtube.png",
                  width: 250,
                  height: 300,
                )),
          ),
          acount_nav(Icons.account_circle, "your account", _textacount),
          Divider(
            color: Colors.black,
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
                    add_button_nav(Icons.home, "Home", home),
                    add_button_nav(Icons.add_to_photos, "library", () => null),
                    add_button_nav(Icons.add_to_queue_outlined, "History", history_show),
                    add_button_nav(Icons.access_time_filled, "Watch Later", () => null),
                    add_button_nav(Icons.build_circle_sharp, "Setting", () => null),
                    add_button_nav(Icons.help, "Help", help)
                  ])))
        ]));
  }
  void help() {

  }
  void home() {
    Navigator.of(_context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => new StatefulBuilder(
            builder: (BuildContext context, setState) => MyHomePage())));
  }
  void history_show() {
    Navigator.of(_context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => new StatefulBuilder(
            builder: (BuildContext context, setState) =>
                history())));
  }
  Widget add_button_nav(var n, String name, delegate()) {
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(children: [
          Icon(
            n,
            color: Colors.red,
          ),
          Text(name, style: TextStyle(color: Colors.red))
        ]),
      ),
      onPressed: delegate,
    );
  }

  Widget acount_nav(var n, String name, String account) {
    return FlatButton(
      child: Row(children: [
        Icon(
          n,
          color: Colors.red,
          size: 50,
        ),
        Column(
          children: [
            Text(name, style: TextStyle(color: Colors.red, fontSize: 20)),
            Text(account, style: TextStyle(color: Colors.red, fontSize: 12))
          ],
        )
      ]),
      onPressed: null,
    );
  }

}