import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinances/src/core/presentation/widgets/elevation_widget.dart';

class ProfilePictureWidget extends StatelessWidget {
  final double size;
  final void Function()? onTap;
  const ProfilePictureWidget({
    super.key,
    this.size = 150,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevationWidget(
      borderRadius: 100,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
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
        ),
      ),
    );
  }
}
