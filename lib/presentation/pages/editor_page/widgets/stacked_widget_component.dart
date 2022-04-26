import 'package:flutter/material.dart';
import 'package:photo_album/data/models/stacked_widget.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/positioned_neon_text.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/positioned_ordinary_text.dart';
import 'package:photo_album/presentation/pages/editor_page/widgets/stacked_widget_config.dart';
import 'package:photo_album/presentation/utils/consts.dart';

class StackedWidgetComponent extends StatefulWidget {
  static String tag = '/StackedWidgetComponent';
  final List<StackedWidgetModel> multiWidget;

  StackedWidgetComponent(this.multiWidget);

  @override
  StackedWidgetComponentState createState() => StackedWidgetComponentState();
}

class StackedWidgetComponentState extends State<StackedWidgetComponent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: widget.multiWidget.map<Widget>((item) {
          if (item.widgetType == WidgetTypeText) {
            return PositionedTextViewWidget(
              value: item.value,
              left: item.offset!.dx,
              top: item.offset!.dy,
              align: TextAlign.center,
              fontSize: item.size,
              stackedWidgetModel: item,
              onTap: () async {
                var data = await showModalBottomSheet(
                  context: context,
                  builder: (_) => StackedItemConfigWidget(stackedWidgetModel: item, voidCallback: () => setState(() {})),
                  backgroundColor: Colors.transparent,
                );

                if (data != null) {
                  widget.multiWidget.remove(data);
                }
                setState(() {});
              },
              onPanUpdate: (details) {
                item.offset = Offset(item.offset!.dx + details.delta.dx, item.offset!.dy + details.delta.dy);

                setState(() {});
              },
            );
          } else if (item.widgetType == WidgetTypeEmoji) {
            return PositionedTextViewWidget(
              value: item.value,
              left: item.offset!.dx,
              top: item.offset!.dy,
              align: TextAlign.center,
              fontSize: item.size,
              stackedWidgetModel: item,
              onTap: () async {
                var data = await showModalBottomSheet(
                  context: context,
                  builder: (_) => StackedItemConfigWidget(stackedWidgetModel: item, voidCallback: () => setState(() {})),
                  backgroundColor: Colors.transparent,
                );

                if (data != null) {
                  widget.multiWidget.remove(data);
                }
                setState(() {});
              },
              onPanUpdate: (details) {
                item.offset = Offset(item.offset!.dx + details.delta.dx, item.offset!.dy + details.delta.dy);

                setState(() {});
              },
            );
          } else if (item.widgetType == WidgetTypeNeon) {
            return PositionedNeonTextWidget(
              value: item.value,
              left: item.offset!.dx,
              top: item.offset!.dy,
              align: TextAlign.center,
              fontSize: item.size,
              stackedWidgetModel: item,
              onTap: () async {
                var data = await showModalBottomSheet(
                  context: context,
                  builder: (_) => StackedItemConfigWidget(stackedWidgetModel: item, voidCallback: () => setState(() {})),
                  backgroundColor: Colors.transparent,
                );

                if (data != null) {
                  widget.multiWidget.remove(data);
                }
                setState(() {});
              },
              onPanUpdate: (details) {
                item.offset = Offset(item.offset!.dx + details.delta.dx, item.offset!.dy + details.delta.dy);

                setState(() {});
              },
            );
          } else if (item.widgetType == WidgetTypeSticker) {
            return Positioned(
              left: item.offset!.dx,
              top: item.offset!.dy,
              child: GestureDetector(
                onTap: () async {
                  var data = await showModalBottomSheet(
                    context: context,
                    builder: (_) => StackedItemConfigWidget(stackedWidgetModel: item, voidCallback: () => setState(() {})),
                    backgroundColor: Colors.transparent,
                  );

                  if (data != null) {
                    widget.multiWidget.remove(data);
                  }
                  setState(() {});
                },
                onPanUpdate: (details) {
                  item.offset = Offset(item.offset!.dx + details.delta.dx, item.offset!.dy + details.delta.dy);

                  setState(() {});
                },
                child: Image.asset(item.value!, height: item.size),
              ),
            );
          }
          return Container();
        }).toList(),
      ),
    );
  }
}
