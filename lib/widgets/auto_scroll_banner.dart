import 'dart:async';
import 'package:flutter/material.dart';

class AutoScrollBanner extends StatefulWidget {
  final List<Widget> children;
  final double height;
  final EdgeInsets padding;
  final Duration scrollDuration;
  final Duration pauseDuration;
  final double scrollOffset;

  const AutoScrollBanner({
    super.key,
    required this.children,
    required this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.scrollDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(seconds: 3),
    this.scrollOffset = 200,
  });

  @override
  State<AutoScrollBanner> createState() => _AutoScrollBannerState();
}

class _AutoScrollBannerState extends State<AutoScrollBanner> {
  late ScrollController _scrollController;
  late Timer _timer;
  bool _isInteracting = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Start scrolling after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    const scrollSpeed = 50.0; // pixels per second
    const tickDuration = Duration(milliseconds: 30);
    const step = scrollSpeed * 0.03; // distance per tick

    _timer = Timer.periodic(tickDuration, (timer) {
      if (_isInteracting) return;

      if (_scrollController.hasClients) {
        final currentScroll = _scrollController.offset;
        double target = currentScroll + step;
        _scrollController.jumpTo(target);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            // User started dragging
            if (notification.dragDetails != null) {
              setState(() {
                _isInteracting = true;
              });
            }
          } else if (notification is ScrollEndNotification) {
            // Drag or momentum finished
            setState(() {
              _isInteracting = false;
            });
          }
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: widget.padding,
          // Infinite item count for continuous loop effect
          itemBuilder: (context, index) {
            // Use modulo to loop through children
            final itemIndex = index % widget.children.length;
            return widget.children[itemIndex];
          },
        ),
      ),
    );
  }
}
