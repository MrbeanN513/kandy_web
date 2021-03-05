part of kandy;


class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  FocusNode? incnode;
  FocusNode? decnode;
  @override
  void initState() {
    super.initState();
    incnode = new FocusNode();
    decnode = new FocusNode();
  }

  void _incrementCounter() {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('increment'),
          duration: const Duration(milliseconds: 400),
        ),
      );
      FocusScope.of(context).requestFocus(incnode);

      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('decrement'),
          duration: const Duration(milliseconds: 400),
        ),
      );
      FocusScope.of(context).requestFocus(decnode);

      _counter--;
    });
  }

  @override
  void dispose() {
    incnode!.dispose();
    decnode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ButtonShortcuts(
      // onIncrementDetected: _incrementCounter,
      // onDecrementDetected: _decrementCounter,
      child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                focusNode: decnode,
                focusColor: Colors.black,
                onPressed: _decrementCounter,
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                focusNode: incnode,
                focusColor: Colors.black,
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          )),
    );
  }
}

final skipBackward_10KeySet = LogicalKeySet(
  LogicalKeyboardKey.arrowLeft,
);
final skipForward_10KeySet = LogicalKeySet(
  LogicalKeyboardKey.arrowRight,
);
final playPauseKeySet = LogicalKeySet(
  LogicalKeyboardKey.arrowDown,
);
final spaceBarplayPauseKeySet = LogicalKeySet(
  LogicalKeyboardKey.space,
);
final pressedMuteKeySet = LogicalKeySet(
  LogicalKeyboardKey.keyM,
);
final playbackSpeedIncKeySet = LogicalKeySet(
  LogicalKeyboardKey.numpadAdd,
);
final playbackSpeedDecKeySet = LogicalKeySet(
  LogicalKeyboardKey.numpadSubtract,
);
final escKeySet = LogicalKeySet(
  LogicalKeyboardKey.escape,
);

class SkipBackward10Intent extends Intent {}

class SkipForward10Intent extends Intent {}

class PlayPauseIntent extends Intent {}

class SpaceBarPlayPauseIntent extends Intent {}

class PressedMuteIntent extends Intent {}

class PlaybackSpeedIncIntent extends Intent {}

class PlaybackSpeedDecIntent extends Intent {}

class EscIntent extends Intent {}

class ButtonShortcuts extends StatelessWidget {
  const ButtonShortcuts({
    Key? key,
    @required this.child,
    this.skipForward_10,
    this.skipBackward_10,
    this.playPause,
    this.spaceBarplayPause,
    this.pressedMute,
    this.playbackSpeedInc,
    this.playbackSpeedDec,
    this.esc,
  }) : super(key: key);
  final Widget? child;

  final VoidCallback? skipForward_10;
  final VoidCallback? skipBackward_10;
  final VoidCallback? playPause;
  final VoidCallback? spaceBarplayPause;
  final VoidCallback? pressedMute;
  final VoidCallback? playbackSpeedInc;
  final VoidCallback? playbackSpeedDec;
  final VoidCallback? esc;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        skipBackward_10KeySet: SkipBackward10Intent(),
        skipForward_10KeySet: SkipForward10Intent(),
        playPauseKeySet: PlayPauseIntent(),
        spaceBarplayPauseKeySet: SpaceBarPlayPauseIntent(),
        pressedMuteKeySet: PressedMuteIntent(),
        playbackSpeedIncKeySet: PlaybackSpeedIncIntent(),
        playbackSpeedDecKeySet: PlaybackSpeedDecIntent(),
        escKeySet: EscIntent(),
      },
      actions: {
        SkipBackward10Intent:
            CallbackAction(onInvoke: (e) => skipBackward_10?.call()),
        SkipForward10Intent:
            CallbackAction(onInvoke: (e) => skipForward_10?.call()),
        PlayPauseIntent: CallbackAction(onInvoke: (e) => playPause?.call()),
        SpaceBarPlayPauseIntent:
            CallbackAction(onInvoke: (e) => spaceBarplayPause?.call()),
        PressedMuteIntent: CallbackAction(onInvoke: (e) => pressedMute?.call()),
        PlaybackSpeedIncIntent:
            CallbackAction(onInvoke: (e) => playbackSpeedInc?.call()),
        PlaybackSpeedDecIntent:
            CallbackAction(onInvoke: (e) => playbackSpeedDec?.call()),
        EscIntent: CallbackAction(onInvoke: (e) => esc?.call()),
      },
      child: child!,
    );
  }
}
