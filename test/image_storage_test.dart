import 'package:card_vault/core/services/image_storage_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ImageStorageService.thumbPathFor', () {
    test('maps a /full/ path to the sibling /thumb/ path', () {
      const full = '/data/app/card_images/full/abc-123.jpg';
      expect(
        ImageStorageService.thumbPathFor(full),
        '/data/app/card_images/thumb/abc-123.jpg',
      );
    });

    test('keeps the same file name', () {
      final thumb =
          ImageStorageService.thumbPathFor('/x/y/full/myimage.jpg');
      expect(thumb.endsWith('myimage.jpg'), isTrue);
      expect(thumb.contains('/thumb/'), isTrue);
    });
  });
}
