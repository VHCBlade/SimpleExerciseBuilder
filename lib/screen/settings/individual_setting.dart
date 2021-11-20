import 'package:flutter/material.dart';

class IndividualSetting extends StatefulWidget {
  final String name;
  final String status;
  final Function(BuildContext)? onPressed;

  const IndividualSetting(
      {Key? key, required this.name, this.status = "", this.onPressed})
      : super(key: key);

  @override
  State<IndividualSetting> createState() => _IndividualSettingState();
}

class _IndividualSettingState extends State<IndividualSetting> {
  bool selected = false;

  void select() {
    setState(() => selected = true);
  }

  void unselect() async {
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() => selected = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed == null
            ? null
            : () {
                select();
                unselect();
                widget.onPressed!(context);
              },
        onTapDown: (_) => select(),
        onTapUp: (_) => unselect(),
        onTapCancel: () => unselect(),
        child: Container(
            color: selected ? Theme.of(context).dividerColor : null,
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              Text(
                widget.name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Expanded(child: Container()),
              Text(
                widget.status,
                style: Theme.of(context).textTheme.caption,
              )
            ])));
  }
}
