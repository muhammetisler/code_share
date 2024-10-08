import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../common/colors.dart';
import '../../common/sizes.dart';
import '../../models/code_model.dart';
import '../../router/route_names.dart';
import '../browse/controller/browse_controller.dart';

class CodeListView extends ConsumerWidget {
  const CodeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<CodeModel>>(
        stream: ref.watch(browseControllerProvider).getCodes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            List<CodeModel> codes = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: codes.length,
              itemBuilder: (BuildContext context, int index) {
                final code = codes[index];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRouteNames.code,
                      arguments: {'code': code}),
                  child: Padding(
                    padding: right5,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(code.coverImg!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: all15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      code.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Text(
                                      code.author,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Text(
                                      "${code.views.toString()} views",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: whiteColor,
                                      ),
                                    ),
                                    Text(
                                      DateFormat("dd.MM.y")
                                          .format(code.createdAt),
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: all10,
                                child: AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            code.authorImg),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const Center(
              child: Text("No Data"),
            );
          }
        });
  }
}
