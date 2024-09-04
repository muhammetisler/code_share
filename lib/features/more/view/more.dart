import 'package:auth_app/common/colors.dart';
import 'package:auth_app/common/paths.dart';
import 'package:auth_app/common/sizes.dart';
import 'package:auth_app/features/more/controller/more_controller.dart';
import 'package:auth_app/models/user_model.dart';
import 'package:auth_app/router/route_names.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class More extends ConsumerWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
          future: ref.read(moreControllerProvider).getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userModel = snapshot.data!;

              return SafeArea(
                child: Padding(
                  padding: scaffoldPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "More",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: whiteColor),
                          ),
                          Padding(
                            padding: vertical10,
                            child: CircleAvatar(
                              backgroundColor: profilePhotoCircleColor,
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider(
                                  userModel.profilePhoto!),
                            ),
                          ),
                        ],
                      ),
                      _title("Create Content"),
                      MenuItem(
                        title: "Write an article!",
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRouteNames.writeArticle,
                              arguments: {"currentUser": userModel});
                        },
                        leadingAsset: articleSvg,
                      ),
                      MenuItem(
                        title: "Let's try the coding page!",
                        onTap: () {
                          Navigator.pushNamed(context, AppRouteNames.writeCode,
                              arguments: {"currentUser": userModel});
                        },
                        leadingAsset: codeSvg,
                      ),
                      MenuItem(
                        title: "Your articles",
                        onTap: () => Navigator.pushNamed(
                            context, AppRouteNames.yourArticles),
                        leadingAsset: articleSvg,
                      ),
                      MenuItem(
                        title: "Your code repos",
                        onTap: () => Navigator.pushNamed(
                            context, AppRouteNames.yourCodeRepos),
                        leadingAsset: codeSvg,
                      ),
                      _title("Profile"),
                      MenuItem(
                        title: "Edit Profile",
                        onTap: () => Navigator.pushNamed(
                            context, AppRouteNames.editProfile,
                            arguments: {
                              "currentUser": userModel,
                            }),
                        leadingAsset: editProfile,
                      ),
                      MenuItem(
                        title: "Sign out",
                        onTap: () {
                          ref
                              .read(moreControllerProvider)
                              .signOut()
                              .whenComplete(
                                  () => Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppRouteNames.signIn,
                                        (route) => false,
                                      ));
                        },
                        leadingAsset: signOutSvg,
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          }),
    );
  }

  Padding _title(String title) {
    return Padding(
      padding: vertical10,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: whiteColor),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    this.onTap,
    required this.title,
    required this.leadingAsset,
  });

  final Function()? onTap;
  final String title;
  final String leadingAsset;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: vertical5,
        child: Card(
          color: activeColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 10,
          child: ListTile(
            leading: SvgPicture.asset(
              leadingAsset,
            ),
            title: Text(
              title,
              style: const TextStyle(color: whiteColor, fontSize: 16),
            ),
            trailing: const Icon(
              Icons.arrow_forward_rounded,
              color: whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
