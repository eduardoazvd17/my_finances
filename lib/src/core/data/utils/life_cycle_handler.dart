import 'package:flutter/material.dart';
import 'package:myfinances/src/core/presentation/controllers/app_controller.dart';

class LifeCycleHandler extends StatefulWidget {
  final Widget child;
  const LifeCycleHandler({required this.child, super.key});

  @override
  State<LifeCycleHandler> createState() => _LifeCycleHandlerState();
}

class _LifeCycleHandlerState extends State<LifeCycleHandler>
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
    _requestAuth(state);
    super.didChangeAppLifecycleState(state);
  }

  void _requestAuth(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppController.instance.showAuthOverlay();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
