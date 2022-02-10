import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_album/data/models/decoration_element.dart';

abstract class _DecorationService {
  Future<List<DecorationElement>> getDecorationElements(String type);
}

class DecorationService extends _DecorationService {
  DecorationService._();

  static DecorationService get instance => DecorationService._();

  @override
  Future<List<DecorationElement>> getDecorationElements(String type) async {
    final decorationElements = await FirebaseFirestore.instance.collection('decorations').where('type', isEqualTo: type).get();
    return decorationElements.docs.map<DecorationElement>((e) => DecorationElement.fromDoc(e)).toList();
  }
}
