import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube/navigation.dart';
import 'package:youtube/save_data.dart';

class history extends StatefulWidget {
  static late List<String> list ;
  history() {
    list=save_data().read_all();
  }

  @override
  State<StatefulWidget> createState() {
    return statehistory();
  }
}

class statehistory extends State<history> {
  List<VideoPlayerController> hestorycontrol = [];
  List<Future<void>> ins = [];
  List<Widget> listwidget = [];

  Future<void> add_control(String link) {
    Future<void> return0;
    VideoPlayerController v;
    hestorycontrol.add(v = VideoPlayerController.network(link));
    return0 = v.initialize();
    v.setLooping(true);
    v.setVolume(1.0);
    v.play();
    return return0;
  }

  @override
  void initState() {
    for (String s in history.list) {
      ins.add(add_control(s));
      listwidget.insert(0, add_video("History", ins.length - 1));
    }
    super.initState();
  }

  Widget add_video(String title, int id) {
    return Padding(
        child: Container(
            child: Column(children: [
              Container(
                child: FutureBuilder(
                    future: ins[id],
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: hestorycontrol[id].value.aspectRatio,
                          child: VideoPlayer(hestorycontrol[id]),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
                width: 300,
                height: 200,
              ),
              Padding(
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        if (hestorycontrol[id].value.isPlaying) {
                          hestorycontrol[id].pause();
                        } else {
                          hestorycontrol[id].play();
                        }
                      });
                    },
                    // Display the correct icon depending on the state of the player.
                    child: Icon(
                      hestorycontrol[id].value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                  padding: EdgeInsets.all(5)),
              Text(title, style: TextStyle(fontSize: 30)
                  //padding: EdgeInsets.all(5),
                  )
            ]),
            width: 300,
            height: 320,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1.0,
                color: Colors.black,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ],
            )),
        padding: EdgeInsets.all(10));
  }

  Widget create() {
    return Scaffold(
        drawer: navigation(context).create(),
        appBar: AppBar(
          title: Text("History"),
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: listwidget.length == 0
                ? Icon(
                    Icons.add_to_queue_outlined,
                    color: Colors.grey,
                    size: 150,
                  )
                : Column(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: listwidget,
                        ),
                      ))
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )),
        backgroundColor: Colors.white
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  @override
  Widget build(BuildContext context) {
    return create();
  }
}
