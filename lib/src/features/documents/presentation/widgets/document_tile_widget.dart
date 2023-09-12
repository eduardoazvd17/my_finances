import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/data/utils/date_time_utils.dart';
import '../../../../core/presentation/widgets/icon_button_widget.dart';
import '../../../../core/presentation/widgets/responsive_builder.dart';
import '../../data/enums/document_type.dart';
import '../../data/models/document_model.dart';

import '../../../../core/data/utils/app_themes.dart';
import '../views/document_details_bottom_sheet_modal.dart';

class DocumentTileWidget extends StatelessWidget {
  final DocumentModel documentModel;
  final void Function(DocumentModel) onTap;
  final Future<bool> Function({
    required DocumentModel documentModel,
    bool? newIsFavorite,
    String? newName,
  }) onEdit;
  final void Function(DocumentModel) onDelete;
  const DocumentTileWidget({
    super.key,
    required this.documentModel,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 10, bottom: 10),
      child: InkWell(
        onTap: () => onTap(documentModel),
        onLongPress: () => _openMenu(context),
        borderRadius: BorderRadius.circular(10),
        child: ResponsiveBuilder(
          desktopWidget: _desktopWidget(context),
          mobileWidget: _mobileWidget(context),
        ),
      ),
    );
  }

  Widget _desktopWidget(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Icon(
                        documentModel.type.icon,
                        size: 70 * MediaQuery.of(context).textScaleFactor,
                      ),
                      if (documentModel.isFavorite)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.red[300],
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 5,
                        right: 40,
                      ),
                      child: Text(
                        documentModel.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            documentModel.type.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(color: AppThemes.commonColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            CupertinoIcons.calendar,
                            size: 18,
                            color: AppThemes.commonColor,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateTimeUtils.formatFullDateShorted(
                              documentModel.creationDate,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                const TextStyle(color: AppThemes.commonColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: -5,
            right: -5,
            child: IconButtonWidget(
              icon: Icons.more_vert,
              onTap: () => _openMenu(context),
            ),
          )
        ],
      ),
    );
  }

  Widget _mobileWidget(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Icon(
              documentModel.type.icon,
              size: 40 * MediaQuery.of(context).textScaleFactor,
            ),
            if (documentModel.isFavorite)
              Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  CupertinoIcons.heart_fill,
                  color: Colors.red[300],
                  size: 18,
                ),
              ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 2),
                child: Text(
                  documentModel.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 5),
                    child: Icon(
                      CupertinoIcons.calendar,
                      size: 18,
                      color: AppThemes.commonColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      DateTimeUtils.formatFullDateShorted(
                        documentModel.creationDate,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppThemes.commonColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButtonWidget(
          icon: Icons.more_vert,
          onTap: () => _openMenu(context),
        )
      ],
    );
  }

  void _openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DocumentDetailsBottomSheetModalWidget(
            documentModel: documentModel,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        );
      },
    );
  }
}
