import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../collection/domain/entities/card.dart';
import '../../../collection/presentation/providers/card_providers.dart';

final imagePickerServiceProvider =
    Provider<ImagePickerService>((ref) => ImagePickerService());

/// Drives the Add/Edit Card form submission and image capture.
class AddCardController extends AutoDisposeAsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// Capture from camera, compress + thumbnail into app storage, return the
  /// stored full-image path.
  Future<String?> captureFromCamera() async {
    final temp = await ref.read(imagePickerServiceProvider).pickFromCamera();
    if (temp == null) return null;
    final stored = await ref.read(imageStorageServiceProvider).persist(temp);
    return stored.filePath;
  }

  Future<String?> pickFromGallery() async {
    final temp = await ref.read(imagePickerServiceProvider).pickFromGallery();
    if (temp == null) return null;
    final stored = await ref.read(imageStorageServiceProvider).persist(temp);
    return stored.filePath;
  }

  /// Returns the new card id, or throws with a user-facing message.
  Future<int> submit(CardEntity card) async {
    state = const AsyncLoading();
    final result = await ref.read(addCardProvider).call(card);
    return result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
        throw Exception(failure.message);
      },
      (id) {
        state = const AsyncData(null);
        return id;
      },
    );
  }

  Future<void> updateExisting(CardEntity card) async {
    state = const AsyncLoading();
    final result = await ref.read(updateCardProvider).call(card);
    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
  }
}

final addCardControllerProvider =
    AutoDisposeAsyncNotifierProvider<AddCardController, void>(
  AddCardController.new,
);
