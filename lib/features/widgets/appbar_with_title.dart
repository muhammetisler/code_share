import 'package:auth_app/common/colors.dart';
import 'package:auth_app/common/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppbarWithTitle extends StatelessWidget {
  const AppbarWithTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
        IconButton(onPressed: () {}, icon: SvgPicture.asset(searchSvg))
      ],
    );
  }
}
