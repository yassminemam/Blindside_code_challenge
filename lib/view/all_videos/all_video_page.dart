import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:provider/provider.dart';
import '../../view_model/user_provider.dart';

class AllVideosPage extends StatefulWidget {
  const AllVideosPage({Key? key}) : super(key: key);

  @override
  State<AllVideosPage> createState() => _AllVideosPageState();
}

class _AllVideosPageState extends State<AllVideosPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'tcodrIK2P_I',
      params: const YoutubePlayerParams(
        playlist: [
          'nPt8bK2gbaU',
          'K18cpp_-gP8',
          'iLnmTe5Q2Qw',
          '_WoCV4c6XOE',
          'KmzdUe0RSJo',
          '6jZDSSZZxjQ',
          'p2lYr3vM_1w',
          '7QUtEmBT_-w',
          '34_PXCzGw1M',
        ],
        startAt: const Duration(minutes: 1, seconds: 36),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        player,
                        Positioned.fill(
                          child: YoutubeValueBuilder(
                            controller: _controller,
                            builder: (context, value) {
                              return AnimatedCrossFade(
                                firstChild: const SizedBox.shrink(),
                                secondChild: Material(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          YoutubePlayerController.getThumbnail(
                                            videoId: _controller
                                                .params.playlist.first,
                                            quality: ThumbnailQuality.medium,
                                          ),
                                        ),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                                crossFadeState: value.isReady
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 300),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Text("comments:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            decoration: TextDecoration.none))
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.comment,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          )),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "Add Comment",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.comment),
                labelText: 'Comment',
              ),
              onChanged: (value) {
                Provider.of<UserProvider>(context, listen: false)
                    .addNewCommentToList(value);
              },
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false)
                  .addNewComment()
                  .then((value) => Navigator.pop(context));
            },
            child: Text(
              "Comment",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
