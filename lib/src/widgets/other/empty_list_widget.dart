import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Returned when there are no items in the [BikeListScreen]
Widget listIsEmpty({
  BuildContext context,
}) {
  final String assetName = 'assets/undraw_no_data_qbuo.svg';
  final Widget svgWidget = SvgPicture.asset(
    assetName,
    fit: BoxFit.fitWidth,
    semanticsLabel: 'Empty list',
  );
  return ListView(children: <Widget>[
    Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            svgWidget,
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    'You are seeing this message because this list is empty.',
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    'Use the button below to start populating this list!',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ]);
}
