import 'package:auth_app/features/browse/repository/browse_repository.dart';
import 'package:auth_app/models/article_model.dart';
import 'package:auth_app/models/code_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final browseControllerProvider = Provider(
  (ref) =>
      BrowseController(browseRepository: ref.watch(browseRepositoryProvider)),
);

class BrowseController {
  final BrowseRepository browseRepository;

  BrowseController({required this.browseRepository});

  Stream<List<ArticleModel>> getArticles() {
    return browseRepository.getArticles();
  }

  Stream<List<CodeModel>> getCodes() {
    return browseRepository.getCodes();
  }
}
