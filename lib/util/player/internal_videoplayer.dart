part of kandy;

class VideoApp extends StatefulWidget {
  final String? url;
  VideoApp({this.url});
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController? _controller;
  Duration? videoLength;
  Duration? videoPosition;
  double volume = 0.5;
  var now = new DateTime.now();
  bool isPressedForward = false;
  bool isPressedBackward = false;
  double playbackSpeed = 1.0;
  bool normalSpeed = true;
  bool normalFastSpeed = true;
  Timer? timer;
  Timer? timer2;
  bool isControlHidden = false;
  String? timeString;
  String? timeeString;

  void _getTime() {
    final String formattedDateTime = DateFormat.jm().format(now).toString();
    setState(() {
      timeString = formattedDateTime;
    });
  }

  void getTimecu() {
    final String forDateTime = (DateFormat.jm()
        .format(now.add((videoLength! - videoPosition!)))
        .toString());
    setState(() {
      timeeString = forDateTime;
    });
  }

  @override
  void initState() {
    String? videoUrl = widget.url;
    super.initState();
    print(timeString);
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(seconds: 1), (Timer t) => getTimecu());
    _controller = VideoPlayerController.network(videoUrl!)
      ..addListener(() => setState(() {
            videoPosition = _controller!.value.position;
          }))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          Wakelock.enable();
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ]);
          _controller!.setVolume(1.0);
          _controller!.setPlaybackSpeed(1.0);
          _controller!.play();
          _hideTimer();
          videoLength = _controller!.value.duration;
        });
      });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 3.0, color: Colors.white),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
    );
  }

  void _handleSpeedSlow() {
    setState(() {
      normalSpeed = false;
      normalFastSpeed = true;
      playbackSpeed -= 0.25;
    });
    if (_controller!.value.playbackSpeed <= 0.25) {
      _controller!.setPlaybackSpeed(playbackSpeed);
      _hideTimer();
    } else {
      print(playbackSpeed);
    }

    print(playbackSpeed);
  }

  void _handleSpeedFast() {
    setState(() {
      normalFastSpeed = false;
      normalSpeed = true;
      playbackSpeed += 0.5;
    });

    _controller!.setPlaybackSpeed(playbackSpeed);
    _hideTimer();
    print(playbackSpeed);
  }

  void _handleplaypauseTapAction() {
    if (_controller!.value.isPlaying) {
      _controller!.pause();

      _controller!.setPlaybackSpeed(playbackSpeed = 1.0);
      _hideTimer();
      print(playbackSpeed);
      setState(() {
        isControlHidden = false;
      });
    } else {
      _controller!.play();
      _controller!.setPlaybackSpeed(playbackSpeed = 1.0);
      print(playbackSpeed);
      _hideTimer();
    }
  }

  void _handlebackwardTapAction() {
    _controller!.seekTo(videoPosition! - Duration(seconds: 10));

    setState(() {
      // isControlHidden = false;
      isPressedBackward = true;

      hideTimerForwardBackward();
    });
  }

  void _handleforwardTapAction() {
    _controller!.seekTo(videoPosition! + Duration(seconds: 10));

    setState(() {
      // isControlHidden = false;
      isPressedForward = true;

      hideTimerForwardBackward();
    });
  }

  void _hideTimer() {
    timer = new Timer(const Duration(seconds: 5), () {
      setState(() {
        isPressedForward = false;
        isControlHidden = true;
      });
    });
  }

  void hideTimerForwardBackward() {
    timer2 = new Timer(const Duration(seconds: 1), () {
      setState(() {
        isPressedForward = false;
        isPressedBackward = false;
      });
    });
  }

  void _handleMute() {
    if (_controller!.value.volume == 1.0) {
      _controller!.setVolume(0.0);
      setState(() {
        isControlHidden = false;
      });
    } else {
      _controller!.setVolume(1.0);
      _hideTimer();
    }
  }

  void _handlebackTapAction() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller!.value.isInitialized) {
      return ConnectivityBuilder(
        builder: (context, isConnected, status) => Stack(
          children: [
            ButtonShortcuts(
              playbackSpeedInc: _handleSpeedFast,
              playbackSpeedDec: _handleSpeedSlow,
              spaceBarplayPause: _handleplaypauseTapAction,
              skipForward_10: _handleforwardTapAction,
              skipBackward_10: _handlebackwardTapAction,
              pressedMute: _handleMute,
              playPause: _handleplaypauseTapAction,
              esc: _handlebackTapAction,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.black,
                body: Stack(children: [
                  videoView(),
                  Visibility(
                    maintainInteractivity: true,
                    child: control(),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: isControlHidden ? false : true,
                  ),
                  normalplaybackfastSpeed(),
                  normalplaybackSpeed(),
                  hitSkipButton(),
                  hitpauseButton(),
                  hitforwardButton(),
                  hitbackwardButton(),
                  hitMuteButton(),
                ]),
              ),
            ),
            Visibility(
              visible: isConnected == false ? true : false,
              child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.black54,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 50,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Icon(
                            Icons.cloud_off,
                            size: 150,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        color: Color(0xffFF0000),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Please Connect to Internet",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
    } else if (_controller!.value.hasError) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          body: Center(
              child: Text(
            _controller!.value.errorDescription!,
            style: TextStyle(color: Colors.white, fontSize: 25),
          )));
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Center(
          child: SpinKitCircle(
            color: Color(0xffFF0000),
            size: 50.0,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
    Wakelock.disable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Widget normalplaybackSpeed() {
    return normalSpeed ? Container() : hitPlaybackspeedslowButton();
  }

  Widget normalplaybackfastSpeed() {
    return normalFastSpeed ? Container() : hitPlaybackspeedfastButton();
  }

  String formatDuration(Duration videoPosition) {
    final ms = videoPosition.inMilliseconds;

    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    final minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';

    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';

    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';

    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';

    return formattedTime;
  }

  Widget hitSkipButton() {
    return Align(
        alignment: Alignment.topLeft,
        child: isPressedForward
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: Colors.black38,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                      formatDuration(videoPosition!) +
                          "/" +
                          formatDuration(videoLength!),
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                ))
            : null);
  }

  Widget hitPlaybackspeedfastButton() {
    return Align(
        alignment: Alignment.topLeft,
        child: _controller!.value.playbackSpeed <= 1.25
            ? null
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black38,
                child: Icon(
                  Icons.fast_forward,
                  size: 100,
                  color: Colors.white,
                ),
              ));
  }

  Widget hitPlaybackspeedslowButton() {
    return Align(
        alignment: Alignment.topLeft,
        child: playbackSpeed >= 0.99
            ? null
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black38,
                child: Icon(
                  Icons.fast_rewind,
                  size: 100,
                  color: Colors.white,
                ),
              ));
  }

  Widget hitMuteButton() {
    return Center(
        child: _controller!.value.volume == 1.0
            ? null
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black38,
                child: Icon(
                  Icons.volume_off,
                  size: 100,
                  color: Colors.white,
                ),
              ));
  }

  Widget hitforwardButton() {
    return Center(
        child: isPressedForward
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black38,
                child: Icon(
                  Icons.forward_10,
                  size: 100,
                  color: Colors.white,
                ))
            : null);
  }

  Widget hitbackwardButton() {
    return Center(
        child: isPressedBackward
            ? Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.black38,
                child: Icon(
                  Icons.replay_10,
                  size: 100,
                  color: Colors.white,
                ))
            : null);
  }

  Widget hitpauseButton() {
    return Center(
      child: _controller!.value.isPlaying
          ? null
          : InkWell(
              onTap: () {
                _handleplaypauseTapAction();
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.black38,
                  child: Icon(
                    Icons.pause,
                    size: 100,
                    color: Colors.white,
                  )),
            ),
    );
  }

  Widget videoView() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: _controller!.value.isInitialized
            ? Center(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              )
            : Container());
  }

  Widget control() {
    return Column(children: [
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: timeString,
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                TextSpan(
                    text: "\n  end by:" + timeeString!,
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ]),
            ),
          ],
        ),
        height: isControlHidden ? 0 : 60,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
      ),
      InkWell(
        onDoubleTap: () {
          _handleplaypauseTapAction();
          _hideTimer();
        },
        onTap: () {
          setState(() {
            isControlHidden = false;
          });

          _hideTimer();
        },
        child: Container(
          // color: Colors.orange,
          height: isControlHidden
              ? MediaQuery.of(context).size.height
              : MediaQuery.of(context).size.height - 140,
          width: MediaQuery.of(context).size.width,
        ),
      ),
      Container(
        // color: Colors.orange,
        height: isControlHidden ? 0 : 20,
        width: MediaQuery.of(context).size.width,
        child: VideoProgressIndicator(
          _controller!,
          allowScrubbing: true,
          padding: EdgeInsets.all(5),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black26,
        height: isControlHidden ? 0 : 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                icon: Icon(
                  Icons.replay_10,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  _handlebackwardTapAction();
                },
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 60,
              width: 60,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                  icon: _controller!.value.isPlaying
                      ? Icon(
                          Icons.pause,
                          size: 40,
                          color: Colors.white,
                        )
                      : Icon(Icons.play_arrow, size: 40, color: Colors.white),
                  onPressed: () {
                    _handleplaypauseTapAction();
                  },
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 50,
              width: 50,
              child: IconButton(
                icon: Icon(
                  Icons.forward_10,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  _handleforwardTapAction();
                },
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
