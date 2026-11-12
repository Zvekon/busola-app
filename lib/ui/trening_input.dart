import 'package:flutter/material.dart';

class TreningInput extends StatefulWidget {
  final String title;
  final Function(double) onChanged;

  const TreningInput(
      {super.key, required this.title, required this.onChanged(double value)});

  @override
  State<TreningInput> createState() => _TreningInputState();
}

class _TreningInputState extends State<TreningInput> with AutomaticKeepAliveClientMixin {
  double _value = 0;

  void _sliderChange(double value) {
    setState(() {
      _value = value;
    });
    widget.onChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 96, child: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w500))),
          Slider(
            value: _value,
            onChanged: _sliderChange,
            min: 0,
            max: 50,
            divisions: 10,
          ),
          SizedBox(
              width: 20,
              child: Text(_value.ceil().toString(), style: const TextStyle(fontWeight: FontWeight.w500),)
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}