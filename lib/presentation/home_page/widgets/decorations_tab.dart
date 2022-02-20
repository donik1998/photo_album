import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/data/models/decoration_element.dart';
import 'package:photo_album/presentation/custom_widgets/empty_list_widget.dart';
import 'package:photo_album/presentation/custom_widgets/loader.dart';
import 'package:photo_album/presentation/home_page/widgets/decoration_element_card.dart';
import 'package:photo_album/presentation/home_page/widgets/decoration_element_editor_dialog.dart';
import 'package:photo_album/presentation/theme/app_instets.dart';

class DecorationsTab extends StatelessWidget {
  final String type;
  final ValueChanged<String> onMessageGenerated;

  const DecorationsTab({
    Key? key,
    required this.type,
    required this.onMessageGenerated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('decorations').where('type', isEqualTo: type).snapshots(),
      builder: (context, ordersSnapshot) {
        if (ordersSnapshot.connectionState == ConnectionState.waiting)
          return Loader();
        else if (!ordersSnapshot.hasData || (ordersSnapshot.data?.docs.isEmpty ?? false))
          return EmptyListWidget();
        else
          return GridView.builder(
            padding: AppInsets.horizontalInsets36.copyWith(top: 16),
            itemCount: ordersSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final decorationElement = DecorationElement.fromMap(
                ordersSnapshot.data!.docs.elementAt(index).data()..addAll({'id': ordersSnapshot.data!.docs.elementAt(index).id}),
              );
              return DecorationElementCard(
                element: decorationElement,
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (_) => DecorationElementEditorDialog(element: decorationElement),
                ).then((value) {
                  if (value is String) onMessageGenerated(value);
                }),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
          );
      },
    );
  }
}
