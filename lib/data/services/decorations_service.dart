import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_album/data/models/decoration_category.dart';

abstract class _DecorationService {
  Future<List<DecorationCategory>> getDecorationCategories();
}

class DecorationService extends _DecorationService {
  DecorationService._();

  static DecorationService get instance => DecorationService._();

  @override
  Future<List<DecorationCategory>> getDecorationCategories() async {
    final decorationElements = await FirebaseFirestore.instance.collection('decoration_categories').get();
    return decorationElements.docs.map<DecorationCategory>((e) => DecorationCategory.fromJson(e.data())).toList();
  }
}
