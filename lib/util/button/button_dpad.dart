import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef VoidBuildContext = void Function(BuildContext context);
typedef VoidTrapKeyEvent = void Function(
    BuildContext context, RawKeyEvent event);

class FuchsiaAppbarButton extends StatefulWidget {
  final String? debugLabel;
  final bool? autoFocus;
  final Widget? focusedchild;
  final Widget? nonFocusedchild;
  final VoidBuildContext? _handleEnterTapAction;
  final VoidTrapKeyEvent? voidTrapKeyEvent;
  final Color? nonFocusedBackgroundColor;
  final Color? focusedBackgroundColor;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final Decoration? nonFocusedBackgroundDecoration;
  final Decoration? focusedBackgroundDecoration;
  final EdgeInsetsGeometry? padding;
  final Decoration? nonFocusedForegroundDecoration;
  final Decoration? focusedForegroundDecoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;

  FuchsiaAppbarButton({
    Key? key,
    VoidBuildContext? handleEnterTapAction,
    this.debugLabel,
    this.autoFocus,
    this.focusedchild,
    this.nonFocusedchild,
    // this.nonFocusedBackgroundColor = const Color(0xff5a5a5a),
    // this.focusedBackgroundColor = const Color(0xffFF0000),
    this.nonFocusedBackgroundColor,
    this.focusedBackgroundColor,
    this.alignment,
    this.constraints,
    this.nonFocusedBackgroundDecoration,
    this.focusedBackgroundDecoration,
    this.padding,
    this.nonFocusedForegroundDecoration,
    this.focusedForegroundDecoration,
    this.width = 200,
    this.height = 100,
    this.margin,
    this.transform,
    this.voidTrapKeyEvent,
  })  : assert(focusedchild != null, nonFocusedchild != null),
        _handleEnterTapAction = handleEnterTapAction,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FocusableEnterTapActionableWidget();
  }
}

class _FocusableEnterTapActionableWidget extends State<FuchsiaAppbarButton> {
  bool _gestureDetectorRequestedFocus = false;

  bool _handleOnKey(FocusNode node, RawKeyEvent event, BuildContext context) {
    if (widget.voidTrapKeyEvent != null) {
      widget.voidTrapKeyEvent!(context, event);
      return true;
    }

    if (event is RawKeyDownEvent) {
      print(
          '_handleKeyPress: Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        TraversalDirection direction = TraversalDirection.down;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        TraversalDirection direction = TraversalDirection.up;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        TraversalDirection direction = TraversalDirection.left;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        TraversalDirection direction = TraversalDirection.right;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.select ||
          event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        return _handleEnterTapAction(context);
      }
    }

    return false;
  }

  bool _handleEnterTapAction(BuildContext context) {
    if (widget._handleEnterTapAction == null) {
      return false;
    }
    widget._handleEnterTapAction!(context);
    return true;
  }

  void _handleOnFocusChange(bool focusGained, BuildContext context) {
    if (focusGained) {
      print("focus gained by " + widget.debugLabel!);
      if (_gestureDetectorRequestedFocus) {
        _gestureDetectorRequestedFocus = false;
        _handleEnterTapAction(context);
      }
      //TODO: need to show the child widget in focused state
    } else {
      //TODO: need to show the child widget in non focused state
      print("focus lossed by " + widget.debugLabel!);
    }
  }

  Widget _getEnabledChild(bool hasFocus) {
    Container container = Container(
      child: hasFocus ? widget.focusedchild : widget.nonFocusedchild,
      color: hasFocus
          ? widget.focusedBackgroundColor
          : widget.nonFocusedBackgroundColor,
      alignment: widget.alignment,
      constraints: widget.constraints,
      decoration: hasFocus
          ? widget.focusedBackgroundDecoration
          : widget.nonFocusedBackgroundDecoration,
      padding: widget.padding,
      foregroundDecoration: hasFocus
          ? widget.focusedForegroundDecoration
          : widget.nonFocusedForegroundDecoration,
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      transform: widget.transform,
    );

    return container;
  }

  @override
  Widget build(BuildContext context) {
    Builder builder = Builder(builder: (BuildContext context) {
      final FocusNode focusNode = Focus.of(context);
      final hasFocus = focusNode.hasFocus;

      GestureDetector gestureDetector = GestureDetector(
          onTap: () {
            if (!hasFocus) {
              _gestureDetectorRequestedFocus = true;
              focusNode.requestFocus();
            } else {
              _handleEnterTapAction(context);
            }
          },
          child: _getEnabledChild(hasFocus));

      return gestureDetector;
    });

    void _onFocusChange(bool focusGained) {
      _handleOnFocusChange(focusGained, context);
    }

    bool _onKey(FocusNode node, RawKeyEvent event) {
      return _handleOnKey(node, event, context);
    }

    Focus focusableEnterTapActionableChild = Focus(
      onFocusChange: _onFocusChange,
      autofocus: widget.autoFocus == null ? false : widget.autoFocus!,
      onKey: _onKey,
      debugLabel: widget.debugLabel,
      child: builder,
    );

    return focusableEnterTapActionableChild;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
///===============================================================================================abstract
///////////////////////////////////////////////////////////////////////////////////////////////
///============================================================================abstract
///

class FuchsiaMainButton extends StatefulWidget {
  final String? debugLabel;
  final bool? autoFocus;
  final Widget? focusedchild;
  final Widget? nonFocusedchild;
  final VoidBuildContext? _handleEnterTapAction;
  final VoidTrapKeyEvent? voidTrapKeyEvent;
  final Color? nonFocusedBackgroundColor;
  final Color? focusedBackgroundColor;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final Decoration? nonFocusedBackgroundDecoration;
  final Decoration? focusedBackgroundDecoration;
  final EdgeInsetsGeometry? padding;
  final Decoration? nonFocusedForegroundDecoration;
  final Decoration? focusedForegroundDecoration;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;

  FuchsiaMainButton({
    Key? key,
    VoidBuildContext? handleEnterTapAction,
    this.debugLabel,
    this.autoFocus,
    this.focusedchild,
    this.nonFocusedchild,
    this.nonFocusedBackgroundColor,
    this.focusedBackgroundColor,
    this.alignment,
    this.constraints,
    this.nonFocusedBackgroundDecoration,
    this.focusedBackgroundDecoration,
    this.padding,
    this.nonFocusedForegroundDecoration,
    this.focusedForegroundDecoration,
    this.width = 200,
    this.height = 100,
    this.margin,
    this.transform,
    this.voidTrapKeyEvent,
  })  : assert(focusedchild != null, nonFocusedchild != null),
        _handleEnterTapAction = handleEnterTapAction,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FocusableEnterTapActionableMainWidget();
  }
}

class _FocusableEnterTapActionableMainWidget extends State<FuchsiaMainButton> {
  bool _gestureDetectorRequestedFocus = false;

  bool _handleOnKey(FocusNode node, RawKeyEvent event, BuildContext context) {
    if (widget.voidTrapKeyEvent != null) {
      widget.voidTrapKeyEvent!(context, event);
      return true;
    }

    if (event is RawKeyDownEvent) {
      print(
          '_handleKeyPress: Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        TraversalDirection direction = TraversalDirection.down;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        TraversalDirection direction = TraversalDirection.up;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        TraversalDirection direction = TraversalDirection.left;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        TraversalDirection direction = TraversalDirection.right;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.select ||
          event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        return _handleEnterTapAction(context);
      }
    }

    return false;
  }

  bool _handleEnterTapAction(BuildContext context) {
    if (widget._handleEnterTapAction == null) {
      return false;
    }
    widget._handleEnterTapAction!(context);
    return true;
  }

  void _handleOnFocusChange(bool focusGained, BuildContext context) {
    if (focusGained) {
      print("focus gained by " + widget.debugLabel!);
      if (_gestureDetectorRequestedFocus) {
        _gestureDetectorRequestedFocus = false;
        _handleEnterTapAction(context);
      }
      //TODO: need to show the child widget in focused state
    } else {
      //TODO: need to show the child widget in non focused state
      print("focus lossed by " + widget.debugLabel!);
    }
  }

  Widget _getEnabledChild(bool hasFocus) {
    Container container = Container(
      child: hasFocus ? widget.focusedchild : widget.nonFocusedchild,
      color: hasFocus
          ? widget.focusedBackgroundColor
          : widget.nonFocusedBackgroundColor,
      alignment: widget.alignment,
      constraints: widget.constraints,
      decoration: hasFocus
          ? widget.focusedBackgroundDecoration
          : widget.nonFocusedBackgroundDecoration,
      padding: widget.padding,
      foregroundDecoration: hasFocus
          ? widget.focusedForegroundDecoration
          : widget.nonFocusedForegroundDecoration,
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      transform: widget.transform,
    );

    return container;
  }

  @override
  Widget build(BuildContext context) {
    Builder builder = Builder(builder: (BuildContext context) {
      final FocusNode focusNode = Focus.of(context);
      final hasFocus = focusNode.hasFocus;

      GestureDetector gestureDetector = GestureDetector(
          onTap: () {
            if (!hasFocus) {
              _gestureDetectorRequestedFocus = true;
              focusNode.requestFocus();
            } else {
              _handleEnterTapAction(context);
            }
          },
          child: _getEnabledChild(hasFocus));

      return gestureDetector;
    });

    void _onFocusChange(bool focusGained) {
      _handleOnFocusChange(focusGained, context);
    }

    bool _onKey(FocusNode node, RawKeyEvent event) {
      return _handleOnKey(node, event, context);
    }

    Focus focusableEnterTapActionableChild = Focus(
      onFocusChange: _onFocusChange,
      autofocus: widget.autoFocus == null ? false : widget.autoFocus!,
      onKey: _onKey,
      debugLabel: widget.debugLabel,
      child: builder,
    );

    return focusableEnterTapActionableChild;
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///=============================================================================================
////////////////////////////////////////////////////////////////////////////////////////////////////////
///===================================================================================================
//////////////////////////////////////////////////////////
class FuchsiaSidebarButton extends StatefulWidget {
  final String? debugLabel;
  final bool? autoFocus;
  final Widget? child;

  final VoidBuildContext? _handleEnterTapAction;
  final VoidTrapKeyEvent? voidTrapKeyEvent;
  final Color? nonFocusedBackgroundColor;
  final Color? focusedBackgroundColor;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final Decoration? nonFocusedBackgroundDecoration;
  final Decoration? focusedBackgroundDecoration;
  final EdgeInsetsGeometry? padding;
  final Decoration? nonFocusedForegroundDecoration;
  final Decoration? focusedForegroundDecoration;
  // final double? width;
  final double? focussedwidth;
  final double? nonfocussedwidth;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final Function? onFocus;
  final Duration? duration;
  final Curve? curve;

  FuchsiaSidebarButton({
    Key? key,
    VoidBuildContext? handleEnterTapAction,
    this.debugLabel,
    this.autoFocus,
    this.child,
    this.nonFocusedBackgroundColor,
    this.focusedBackgroundColor,
    this.alignment,
    this.constraints,
    this.nonFocusedBackgroundDecoration,
    this.focusedBackgroundDecoration,
    this.padding,
    this.nonFocusedForegroundDecoration,
    this.focusedForegroundDecoration,
    // this.width = 200,
    this.focussedwidth = 200,
    this.nonfocussedwidth = 200,
    this.height = 100,
    this.margin,
    this.transform,
    this.onFocus,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.decelerate,
    this.voidTrapKeyEvent,
  })  : assert(
          child != null,
        ),
        _handleEnterTapAction = handleEnterTapAction,
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FocusableEnterTapActionableSidebarWidget();
  }
}

class _FocusableEnterTapActionableSidebarWidget
    extends State<FuchsiaSidebarButton> {
  bool _gestureDetectorRequestedFocus = false;

  bool _handleOnKey(FocusNode node, RawKeyEvent event, BuildContext context) {
    if (widget.voidTrapKeyEvent != null) {
      widget.voidTrapKeyEvent!(context, event);
      return true;
    }

    if (event is RawKeyDownEvent) {
      print(
          '_handleKeyPress: Focus node ${node.debugLabel} got key event: ${event.logicalKey}');
      if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        TraversalDirection direction = TraversalDirection.down;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        TraversalDirection direction = TraversalDirection.up;
        node.focusInDirection(direction);
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        TraversalDirection direction = TraversalDirection.left;
        node.focusInDirection(direction);
        if (widget.onFocus != null || node.hasFocus) {
          widget.onFocus!();
        }
        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        TraversalDirection direction = TraversalDirection.right;
        node.focusInDirection(direction);

        return true;
      } else if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.select ||
          event.logicalKey == LogicalKeyboardKey.numpadEnter) {
        return _handleEnterTapAction(context);
      }
    }

    return false;
  }

  bool _handleEnterTapAction(BuildContext context) {
    if (widget._handleEnterTapAction == null) {
      return false;
    }
    widget._handleEnterTapAction!(context);
    return true;
  }

  void _handleOnFocusChange(bool focusGained, BuildContext context) {
    if (focusGained) {
      print("focus gained by " + widget.debugLabel!);
      if (_gestureDetectorRequestedFocus) {
        _gestureDetectorRequestedFocus = false;
        _handleEnterTapAction(context);
      }
      //TODO: need to show the child widget in focused state
    } else {
      //TODO: need to show the child widget in non focused state
      print("focus lossed by " + widget.debugLabel!);
    }
  }

  Widget _getEnabledChild(bool hasFocus) {
    return AnimatedContainer(
      duration: widget.duration!,
      curve: widget.curve!,
      child: widget.child,
      color: hasFocus
          ? widget.focusedBackgroundColor
          : widget.nonFocusedBackgroundColor,
      alignment: widget.alignment,
      constraints: widget.constraints,
      decoration: hasFocus
          ? widget.focusedBackgroundDecoration
          : widget.nonFocusedBackgroundDecoration,
      padding: widget.padding,
      foregroundDecoration: hasFocus
          ? widget.focusedForegroundDecoration
          : widget.nonFocusedForegroundDecoration,
      width: hasFocus ? widget.focussedwidth : widget.nonfocussedwidth,
      height: widget.height,
      margin: widget.margin,
      transform: widget.transform,
    );
  }

  @override
  Widget build(BuildContext context) {
    Builder builder = Builder(builder: (BuildContext context) {
      final FocusNode focusNode = Focus.of(context);
      final hasFocus = focusNode.hasFocus;

      GestureDetector gestureDetector = GestureDetector(
          onTap: () {
            if (!hasFocus) {
              _gestureDetectorRequestedFocus = true;
              focusNode.requestFocus();
            } else {
              _handleEnterTapAction(context);
            }
          },
          child: _getEnabledChild(hasFocus));

      return gestureDetector;
    });

    void _onFocusChange(bool focusGained) {
      _handleOnFocusChange(focusGained, context);
    }

    bool _onKey(FocusNode node, RawKeyEvent event) {
      return _handleOnKey(node, event, context);
    }

    Focus focusableEnterTapActionableChild = Focus(
      onFocusChange: _onFocusChange,
      autofocus: widget.autoFocus == null ? false : widget.autoFocus!,
      onKey: _onKey,
      debugLabel: widget.debugLabel,
      child: builder,
    );

    return focusableEnterTapActionableChild;
  }
}
