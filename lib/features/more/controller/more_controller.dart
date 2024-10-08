import 'package:auth_app/features/more/repository/more_repository.dart';
import 'package:auth_app/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/article_model.dart';
import '../../../models/code_model.dart';

final moreControllerProvider = Provider(
  (ref) {
    final moreRepository = ref.watch(moreRepositoryProvider);
    return MoreController(moreRepository: moreRepository, ref: ref);
  },
);

class MoreController {
  final MoreRepository moreRepository;
  final ProviderRef ref;

  MoreController({required this.moreRepository, required this.ref});

  Future<void> signOut() async {
    await moreRepository.signOut();
  }

  Future<void> writeArticle(ArticleModel model) async {
    await moreRepository.writeArticle(model);
  }

  Stream<List<ArticleModel>> getArticles() {
    return moreRepository.getArticles();
  }

  Stream<List<CodeModel>> getCodes() {
    return moreRepository.getCodes();
  }

  Future<UserModel> getUser() async {
    return await moreRepository.getUser();
  }

  Future<void> updateProfile(UserModel model) async {
    await moreRepository.updateProfile(model);
    ref.refresh(moreControllerProvider).getUser();
  }

  Future<void> writeCode(CodeModel model) async {
    await moreRepository.writeCode(model);
  }
}
