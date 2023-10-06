import 'dart:typed_data';

class ImageSourceConverter {
  ImageSourceConverter._();

  static Uint8List? converter(String base) {
    return Uri.parse(base).data?.contentAsBytes();
  }
}
