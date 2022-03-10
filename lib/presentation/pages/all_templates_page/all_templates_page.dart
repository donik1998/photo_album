import 'package:flutter/material.dart';
import 'package:photo_album/presentation/utils/routes.dart';

class AllTemplatesPage extends StatelessWidget {
  const AllTemplatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AllTemplatesPageArgs;
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: args.templates.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(args.templates.elementAt(index).title),
          ),
        ),
      ),
    );
  }
}
