import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube/navigation.dart';
import 'package:youtube/save_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<Future<void>> ins = [];
  static List<VideoPlayerController> videoviewcontrol = [];

  Future<void> ini(String link) {
    Future<void> return0;
    VideoPlayerController v;
    videoviewcontrol.add(
        //VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");
        v = VideoPlayerController.network(link));
    return0 = v.initialize();
    v.setLooping(true);
    v.setVolume(1.0);
    v.play();
    return return0;
  }

  save_data save = save_data();

  @override
  void initState() {
    super.initState();
  }

  final myController = TextEditingController();
  static List<Widget> lastwidget = [];

  void search() {
/*    String linksearch =
        "https://www.youtube.com/results?search_query=" + myController.text;   */
    ins.add(ini(myController.text));
    save.save(myController.text);
    setState(() {
      foc.unfocus();
      lastwidget.insert(0, add_video("search", lastwidget.length));
    });
  }

  FocusNode foc = FocusNode();
  late TextField textsearch = TextField(
      controller: myController,
      showCursor: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          isDense: true,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          hintStyle: TextStyle(height: .8),
          hintText: 'Search'),
      keyboardType: TextInputType.url,
      focusNode: foc);

  late PreferredSizeWidget appbar = AppBar(
    leadingWidth: 30,
    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
    title: SizedBox(
      child: textsearch,
      width: 500,
      height: 40,
    ),
    centerTitle: true,
    actions: [
      SizedBox(
        child: FlatButton(
            onPressed: search,
            child: Icon(
              Icons.search,
              color: Colors.black,
            )),
        width: 50,
      )
    ],
  );

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
                          aspectRatio: videoviewcontrol[id].value.aspectRatio,
                          child: VideoPlayer(videoviewcontrol[id]),
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
                        if (videoviewcontrol[id].value.isPlaying) {
                          videoviewcontrol[id].pause();
                        } else {
                          videoviewcontrol[id].play();
                        }
                      });
                    },
                    // Display the correct icon depending on the state of the player.
                    child: Icon(
                      videoviewcontrol[id].value.isPlaying
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: navigation(this.context).create(),
        appBar: appbar,
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: lastwidget.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Icon(
                          Icons.home,
                          color: Colors.grey,
                          size: 150,
                        ),
                        Container(
                          child: Divider(color: Colors.grey),
                          width: 200,
                          height: 10,
                        )
                      ])
                : Column(
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: lastwidget,
                        ),
                      ))
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )),
        backgroundColor: Colors.white
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
