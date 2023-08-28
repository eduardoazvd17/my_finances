import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'elevation_widget.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String? url;
  final double size;
  final void Function()? onTap;
  const ProfilePictureWidget({
    super.key,
    required this.url,
    this.size = 150,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevationWidget(
      borderRadius: 100,
      child: Tooltip(
        message: 'profile-picture-text'.i18n(),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: url != null
              ? ClipOval(
                  child: Image.network(
                    url!,
                    height: size,
                    width: size,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (_, __, ___) {
                      return SizedBox(
                        height: size,
                        width: size,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: FittedBox(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.red[300],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : _defaultImage(context),
        ),
      ),
    );
  }

  Widget _defaultImage(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(size / 5),
        child: const FittedBox(
          child: Center(
            child: Icon(
              CupertinoIcons.person,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
