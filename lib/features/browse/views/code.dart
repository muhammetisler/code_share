import 'package:auth_app/common/colors.dart';
import 'package:auth_app/common/paths.dart';
import 'package:auth_app/common/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../models/code_model.dart';

class Code extends StatefulWidget {
  final CodeModel code;

  const Code({super.key, required this.code});

  @override
  State<Code> createState() => _CodeState();
}

class _CodeState extends State<Code> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundColor: activeColor,
              child: SvgPicture.asset(
                bookmarkSvg,
                colorFilter:
                    const ColorFilter.mode(whiteColor, BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: scaffoldPadding,
        child: Column(
          children: [
            Padding(
              padding: vertical10,
              child: GestureDetector(
                onTap: () {},
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(widget.code.coverImg!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.code.title,
                      style: const TextStyle(
                          fontSize: 20,
                          color: whiteColor,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.code.description,
                      style: const TextStyle(
                        fontSize: 17,
                        color: whiteColor,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  // CodeTheme(data: CodeThemeData(styles: myTheme),
                  // child: SingleChildScrollView(
                  //   child: CodeField(
                  //     controller: controller,
                  //     enabled:false,
                  //     readOnly:true,
                  //   ),
                  // ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
