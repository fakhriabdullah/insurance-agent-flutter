import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  final String? title;
  final String? desc;
  final double? bottomMargin;
  const ItemDetail({this.title, this.desc, this.bottomMargin, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 2, bottom: bottomMargin ?? 6),
          child: Text(
            desc ?? "",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
