import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sliver_appbar_builder/src/math_utils.dart';

class SliverAppBarBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, double shrinkOffset, double statusBarHeight, bool overlapsContent) contentBuilder;
  final double collapsedHeight;
  final double expandedHeight;
  final bool pinned;
  final bool floating;
  final FloatingHeaderSnapConfiguration? snapConfiguration;
  final OverScrollHeaderStretchConfiguration? stretchConfiguration;
  final PersistentHeaderShowOnScreenConfiguration? onScreenConfiguration;
  const SliverAppBarBuilder({
    super.key,
    required this.contentBuilder,
    this.collapsedHeight = 70,
    this.expandedHeight = 200,
    this.pinned = false,
    this.floating = false,
    this.snapConfiguration,
    this.stretchConfiguration,
    this.onScreenConfiguration,
  });

  @override
  State<SliverAppBarBuilder> createState() => _SliverAppBarBuilderState();
}

class _SliverAppBarBuilderState extends State<SliverAppBarBuilder> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: SliverAppBarBuilderDelegate(
        collapsedHeight: widget.collapsedHeight,
        expandedHeight: widget.expandedHeight,
        snapConfig: widget.snapConfiguration,
        stretchConfig: widget.stretchConfiguration,
        onScreenConfig: widget.onScreenConfiguration,
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
  final OverScrollHeaderStretchConfiguration? stretchConfig;
  final PersistentHeaderShowOnScreenConfiguration? onScreenConfig;
  final TickerProvider? vs;
  SliverAppBarBuilderDelegate({
    required this.contentBuilder,
    this.expandedHeight = 200,
    this.collapsedHeight = 70,
    this.snapConfig,
    this.vs,
    this.stretchConfig,
    this.onScreenConfig,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return contentBuilder(context, (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1), _statusBarHeight, overlapsContent);
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
    return MediaQueryData.fromWindow(window).padding.top;
  }

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => stretchConfig;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration => onScreenConfig;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
