import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sliver_appbar_builder/sliver_appbar_builder.dart';

void main() {
  test('adds one to input values', () {});
}

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBarBuilder(
          contentBuilder: (context, shrinkOffset, statusBarHeight, overlapsContent) {
            return Container(
              color: Color.lerp(Colors.amber, Colors.red, shrinkOffset),
              child: Padding(
                padding: EdgeInsets.only(top: statusBarHeight),
                child: const Center(
                  child: Text("Home Page"),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
