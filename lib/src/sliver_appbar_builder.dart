import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverAppBarBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, double shrinkOffset, double statusBarHeight, bool overlapsContent) contentBuilder;
  final double collapsedHeight;
  final double expandedHeight;
  final bool pinned;
  final bool floating;
  final FloatingHeaderSnapConfiguration? snapConfiguration;
  const SliverAppBarBuilder({
    super.key,
    required this.contentBuilder,
    this.collapsedHeight = 70,
    this.expandedHeight = 200,
    this.pinned = false,
    this.floating = false,
    this.snapConfiguration,
  });

  @override
  State<SliverAppBarBuilder> createState() => _SliverAppBarBuilderState();
}

class _SliverAppBarBuilderState extends State<SliverAppBarBuilder> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // Delay a setState call so MediaQuery gives the right values.
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverAppBarBuilderDelegate(
        collapsedHeight: widget.collapsedHeight,
        expandedHeight: widget.expandedHeight,
        snapConfig: widget.snapConfiguration,
        vs: this,
        contentBuilder: (BuildContext context, double shrinkOffset, double statusBarHeight, bool overlapsContent) => widget.contentBuilder(context, shrinkOffset, statusBarHeight, overlapsContent),
      ),
      pinned: widget.pinned,
      floating: widget.floating,
    );
  }
}

class SliverAppBarBuilderDelegate extends SliverPersistentHeaderDelegate {
  final Widget Function(BuildContext context, double shrinkOffset, double statusBarHeight, bool overlapsContent) contentBuilder;
  final double collapsedHeight;
  final double expandedHeight;
  final FloatingHeaderSnapConfiguration? snapConfig;
  final TickerProvider? vs;
  SliverAppBarBuilderDelegate({
    required this.contentBuilder,
    this.expandedHeight = 200,
    this.collapsedHeight = 70,
    this.snapConfig,
    this.vs,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return contentBuilder(context, shrinkOffset, _statusBarHeight, overlapsContent);
  }

  @override
  TickerProvider? get vsync => vs;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => snapConfig;

  @override
  double get maxExtent {
    return expandedHeight + _statusBarHeight;
  }

  @override
  double get minExtent {
    return collapsedHeight + _statusBarHeight;
  }

  double get _statusBarHeight {
    final window = WidgetsBinding.instance.window;
    return MediaQueryData.fromWindow(window).padding.top;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
