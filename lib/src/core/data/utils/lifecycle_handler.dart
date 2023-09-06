import 'package:flutter/material.dart';
import '../../presentation/controllers/app_controller.dart';

class LifecycleHandler extends StatefulWidget {
  final Widget child;
  const LifecycleHandler({required this.child, super.key});

  @override
  State<LifecycleHandler> createState() => _LifecycleHandlerState();
}

class _LifecycleHandlerState extends State<LifecycleHandler>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _auth(state);
    super.didChangeAppLifecycleState(state);
  }

  void _auth(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AppController.instance.showAuthOverlay();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
