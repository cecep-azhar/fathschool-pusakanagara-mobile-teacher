import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/colors.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  const MenuButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final Size screenSize = MediaQuery.of(context).size;
    // Calculate the responsive size for padding and icon dimensions
    final double padding = screenSize.width * 0.025; // 2.5% of screen width
    final double iconSize = screenSize.width * 0.09; // 9% of screen width
    final double fontSize = screenSize.width * 0.025; // 2.5% of screen width

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(
            color: AppColors.stroke,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: iconSize,
              height: iconSize,
            ),
            const SizedBox(
                height:
                    4.0), // Responsive spacing can also be adjusted if needed
            Text(
              label,
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
