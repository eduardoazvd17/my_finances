import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:myfinances/src/core/data/errors/app_error.dart';

import '../../../../core/data/utils/app_themes.dart';

class MyProfilePicturePage extends StatefulWidget {
  const MyProfilePicturePage({super.key});

  @override
  State<MyProfilePicturePage> createState() => _MyProfilePicturePageState();
}

class _MyProfilePicturePageState extends State<MyProfilePicturePage> {
  bool _hideOptions = false;
  bool _disableOptionsUsage = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _interactiveViewerWidget,
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _hideOptions ? 0 : 1,
                duration: const Duration(milliseconds: 100),
                onEnd: () {
                  setState(() {
                    _disableOptionsUsage = _hideOptions;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    if (_hideOptions) {
                      setState(() {
                        _hideOptions = false;
                      });
                    }
                  },
                  child: _appBar,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar get _appBar {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.black,
      ),
      backgroundColor: Colors.black54,
      foregroundColor: Colors.white,
      leading: IconButton(
        onPressed: _disableOptionsUsage ? null : Get.back,
        icon: const Icon(Icons.close),
      ),
      title: Text('profile-picture-text'.i18n()),
    );
  }

  Widget get _interactiveViewerWidget {
    const double margin = 8.0;

    return InteractiveViewer(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: _appBar.preferredSize.height + margin,
          horizontal: margin,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppThemes.commonColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _hideOptions = !_hideOptions;
                            });
                          },
                          child: Image.network(
                            Get.arguments?.toString() ?? '',
                            errorBuilder: (_, __, ___) {
                              return Text(
                                AppError.generic().message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
