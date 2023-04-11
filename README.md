# Sliver_appbar_builder

<img src="https://forthebadge.com/images/badges/built-with-love.svg" height="28px" />

Adds a new widget that allows to use a builder to make custom appbars.

## Getting Started

First, add the `sliver_appbar_builder` package to your pubspec.yaml.
```yaml
dependencies:
  sliver_appbar_builder: <Package version>
```
or
```yaml
dependencies:
  sliver_appbar_builder:
    git: 
      url: https://github.com/AxonDesigns/sliver_appbar_builder.git
```
then, use `flutter pub get`.

Now, import the package in your Dart code, use:
```Dart
import 'package:sliver_appbar_builder/sliver_appbar_builder.dart';
```

## Usage

```Dart
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
);
```
