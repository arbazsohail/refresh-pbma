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
  Timer? _timer;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.pauseDuration, (timer) {
      if (!_isScrolling && _scrollController.hasClients) {
        _autoScroll();
      }
    });
  }

  Future<void> _autoScroll() async {
    if (!_scrollController.hasClients) return;

    _isScrolling = true;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    // If we're at or near the end, scroll back to start
    if (currentScroll >= maxScroll - 10) {
      await _scrollController.animateTo(
        0,
        duration: widget.scrollDuration,
        curve: Curves.easeInOut,
      );
    } else {
      // Otherwise, scroll forward by the offset amount
      final nextScroll = (currentScroll + widget.scrollOffset).clamp(0.0, maxScroll);
      await _scrollController.animateTo(
        nextScroll,
        duration: widget.scrollDuration,
        curve: Curves.easeInOut,
      );
    }

    _isScrolling = false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: widget.padding,
        itemCount: widget.children.length,
        itemBuilder: (context, index) {
          return widget.children[index];
        },
      ),
    );
  }
}
