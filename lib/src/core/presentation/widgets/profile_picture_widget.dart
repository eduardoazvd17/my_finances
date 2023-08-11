import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePictureWidget extends StatelessWidget {
  final double size;
  const ProfilePictureWidget({
    super.key,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: ClipOval(
          child: Container(
            height: size,
            width: size,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: EdgeInsets.all(size / 5),
              child: const FittedBox(
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
