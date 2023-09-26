import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'scroll_view_widget.dart';

import '../../data/utils/app_themes.dart';

class FloatingBottomMenuWidget extends StatelessWidget {
  final String? selectedName;
  final void Function() onRemoveSelected;
  final ScrollController? scrollController;
  final List<FloatingBottomMenuItem> items;
  const FloatingBottomMenuWidget({
    super.key,
    required this.selectedName,
    required this.onRemoveSelected,
    required this.items,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          border: Border.all(
            width: 1,
            color: AppThemes.commonColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 8,
          color: Theme.of(context).dialogBackgroundColor,
          child: AnimatedSize(
            curve: Curves.ease,
            duration: const Duration(milliseconds: 350),
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (selectedName != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 4.5,
                        left: 8,
                        right: 8,
                        top: 4.5,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              'selected-label'.i18n(),
                              style: const TextStyle(
                                color: AppThemes.commonColor,
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              selectedName!,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: InkWell(
                              onTap: onRemoveSelected,
                              borderRadius: BorderRadius.circular(12),
                              child: const Icon(
                                Icons.close,
                                color: AppThemes.commonColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  ScrollViewWidget(
                    showBar: true,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: items.map((item) {
                          if (items.indexOf(item) > 0) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                  ),
                                  child: Container(
                                    width: 0.5,
                                    height: 25,
                                    color: AppThemes.commonColor,
                                  ),
                                ),
                                item,
                              ],
                            );
                          }
                          return item;
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FloatingBottomMenuItem extends StatelessWidget {
  final IconData icon;
  final void Function() onTap;
  final String tooltip;
  final bool showTooltip;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  const FloatingBottomMenuItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.showTooltip = false,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: showTooltip ? '' : tooltip,
      preferBelow: false,
      verticalOffset: 35,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: foregroundColor),
                ),
              ),
              if (showTooltip)
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    tooltip,
                    style: TextStyle(color: foregroundColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
