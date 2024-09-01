import 'package:auth_app/common/paths.dart';
import 'package:auth_app/common/sizes.dart';
import 'package:auth_app/features/widgets/appbar_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/colors.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: scaffoldPadding,
          child: Column(
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppbarWithTitle(title: "Bookmark"),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: vertical10,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                          bookmarkImage,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: horizontal10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "For My Project Need Something",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: whiteColor,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Muhammet Fatih İşler",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: greyColor,
                                        ),
                                      ),
                                      Text(
                                        "125,908 views  -  2 day ago",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: greyColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: horizontal10,
                                    child: CircleAvatar(
                                      backgroundColor: activeColor,
                                      child: SvgPicture.asset(
                                        bookmarkSvg,
                                        colorFilter: const ColorFilter.mode(
                                            whiteColor, BlendMode.srcIn),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
