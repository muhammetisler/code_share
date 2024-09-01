import 'package:auth_app/features/auth/views/sign_in.dart';
import 'package:auth_app/features/auth/views/sign_up.dart';
import 'package:auth_app/features/auth/views/sign_up_info.dart';
import 'package:auth_app/features/browse/views/article.dart';
import 'package:auth_app/features/home/views/home.dart';
import 'package:auth_app/features/more/view/edit_profile.dart';
import 'package:auth_app/features/more/view/write_article.dart';
import 'package:auth_app/features/more/view/your_articles.dart';
import 'package:auth_app/models/article_model.dart';
import 'package:auth_app/models/user_model.dart';
import 'package:auth_app/router/route_names.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteNames.home:
        return MaterialPageRoute(builder: (_) => const Home());

      case AppRouteNames.signIn:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case AppRouteNames.signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case AppRouteNames.signUpContinue:
        final arguments = settings.arguments as Map<String, dynamic>;
        final email = arguments['email'] as String;
        return MaterialPageRoute(builder: (_) => SignUpContinue(email: email));

      case AppRouteNames.writeArticle:
        final arguments = settings.arguments as Map<String, dynamic>;
        final currentUser = arguments['currentUser'] as UserModel;
        return MaterialPageRoute(
          builder: (_) => WriteArticle(currentUser: currentUser),
        );
      case AppRouteNames.article:
        final arguments = settings.arguments as Map<String, dynamic>;
        final article = arguments['article'] as ArticleModel;
        return MaterialPageRoute(
          builder: (context) => Article(article: article),
        );
      case AppRouteNames.editProfile:
        final arguments = settings.arguments as Map<String, dynamic>;
        final currentUser = arguments['currentUser'] as UserModel;
        return MaterialPageRoute(
          builder: (context) => EditProfile(currentUser: currentUser),
        );
      case AppRouteNames.yourArticles:
        return MaterialPageRoute(
          builder: (context) => const YourArticles(),
        );

      default:
        return MaterialPageRoute(builder: (_) => const SignIn());
    }
  }
}
