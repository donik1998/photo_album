import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

// ignore: must_be_immutable
class BlurSelectorBottomSheet extends StatefulWidget {
  static String tag = '/BlurSelectorBottomSheet';
  final Function(double)? onColorSelected;

  double? sliderValue;

  BlurSelectorBottomSheet({this.sliderValue, this.onColorSelected});

  @override
  BlurSelectorBottomSheetState createState() => BlurSelectorBottomSheetState();
}

class BlurSelectorBottomSheetState extends State<BlurSelectorBottomSheet> {
  double sliderValue = 2.0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        8.width,
        Text('Blur'),
        8.width,
        Slider(
          value: widget.sliderValue!,
          min: 0.0,
          max: 10.0,
          divisions: 100,
          label: '${widget.sliderValue!.round()}',
          onChanged: (double value) {
            widget.sliderValue = value;
            widget.onColorSelected!.call(value);

            setState(() {});
          },
        ).expand(),
      ],
    );
  }
}
