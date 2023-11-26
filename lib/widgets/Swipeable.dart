import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Sweapeble extends StatefulWidget {
  final Widget child;
  final Duration animationDuration;
  final double offsetDx;
  final int swipeSensitivity;
  final GestureDragUpdateCallback? onLeftSwipe;
  final GestureDragUpdateCallback? onRightSwipe;

  const Sweapeble({
    super.key,
    required this.child,
    this.onLeftSwipe,
    this.onRightSwipe,
    this.offsetDx = 0.3,
    this.swipeSensitivity = 20,
    this.animationDuration = const Duration(milliseconds: 150),
  });

  @override
  State<Sweapeble> createState() => _SweapebleState();
}

class _SweapebleState extends State<Sweapeble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late GestureDragUpdateCallback _onSwipeLeft;
  late GestureDragUpdateCallback _onSwipeRight;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _controller),
    );
    _onSwipeLeft = widget.onLeftSwipe ??
        (details) {
          log("Left Swipe Not Provided");
        };

    _onSwipeRight = widget.onRightSwipe ??
        (details) {
          log("Right Swipe Not Provided");
        };

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation({required bool onRight, details}) {
    _animation = Tween(
      begin: const Offset(0.0, 0.0),
      end: Offset(onRight ? widget.offsetDx : -widget.offsetDx, 0.0),
    ).animate(
      CurvedAnimation(curve: Curves.decelerate, parent: _controller),
    );

    _controller.forward().whenComplete(() {
      _controller.reverse().whenComplete(() {
        if (onRight) {
          _onSwipeRight(details);
        } else {
          _onSwipeLeft(details);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > widget.swipeSensitivity &&
            widget.onRightSwipe != null) {
          _runAnimation(onRight: true, details: details);
        }
        if (details.delta.dx < -(widget.swipeSensitivity) &&
            widget.onLeftSwipe != null) {
          _runAnimation(onRight: false, details: details);
        }
      },
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          SlideTransition(
            position: _animation,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
