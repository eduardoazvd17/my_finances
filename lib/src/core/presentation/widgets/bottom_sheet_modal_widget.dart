import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../data/utils/app_themes.dart';
import 'icon_button_widget.dart';
import 'scroll_view_widget.dart';

class BottomSheetModalWidget extends StatelessWidget {
  final Widget child;
  final String? title;
  final IconData? icon;
  const BottomSheetModalWidget({
    super.key,
    required this.child,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: false,
                    maintainAnimation: true,
                    maintainSize: true,
                    maintainState: true,
                    child: _closeButton,
                  ),
                  Container(
                    height: 5,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppThemes.commonColor,
                    ),
                  ),
                  _closeButton,
                ],
              ),
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) _headerIcon,
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            title!,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (icon != null)
                        Visibility(
                          visible: false,
                          maintainAnimation: true,
                          maintainSize: true,
                          maintainState: true,
                          child: _headerIcon,
                        ),
                    ],
                  ),
                ),
              if (title != null) const Divider(),
              Flexible(
                child: ScrollViewWidget(
                  showBar: true,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _headerIcon => Icon(icon, size: 30);

  Widget get _closeButton => Padding(
        padding: const EdgeInsets.only(right: 2.5, top: 2.5),
        child: IconButtonWidget(
          icon: Icons.close,
          iconColor: Colors.red,
          tooltip: 'close-button'.i18n(),
          onTap: Get.back,
        ),
      );
}
