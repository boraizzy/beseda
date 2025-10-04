import 'package:flutter/widgets.dart';

/// Observes the window changes and provides a [MediaQuery]
/// always up to date.
class MediaQueryObserver extends StatefulWidget {
  final Widget child;

  const MediaQueryObserver({super.key,
    required this.child,
  });

  @override
  MediaQueryObserverState createState() => MediaQueryObserverState();
}

class MediaQueryObserverState extends State<MediaQueryObserver>
    with WidgetsBindingObserver {

  T? _ambiguate<T>(T? value) => value;

  @override
  void didChangeMetrics() {
    setState(() {});
    super.didChangeMetrics();
  }

  @override
  void initState() {
    _ambiguate(WidgetsBinding.instance)!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      // ignore: deprecated_member_use
      data: MediaQueryData.fromWindow(_ambiguate(WidgetsBinding.instance)!.window),
      child: widget.child,
    );
  }
}
