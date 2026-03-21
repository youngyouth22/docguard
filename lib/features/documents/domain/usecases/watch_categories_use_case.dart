import 'package:docguard/features/documents/domain/entities/category_entity.dart';
import 'package:docguard/features/documents/domain/repositories/i_document_repository.dart';

class WatchCategoriesUseCase {
  final IDocumentRepository _repository;

  WatchCategoriesUseCase(this._repository);

  Stream<List<CategoryEntity>> call() {
    return _repository.watchCategories();
  }
}
