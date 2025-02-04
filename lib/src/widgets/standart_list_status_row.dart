import 'package:cake_wallet/palette.dart';
import 'package:cake_wallet/src/screens/dashboard/widgets/sync_indicator_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StandartListStatusRow extends StatelessWidget {
  StandartListStatusRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 24, top: 16, bottom: 16, right: 24),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryTextTheme!.overline!.color!),
                  textAlign: TextAlign.left),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentTextTheme!.headline3!.color!,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SyncIndicatorIcon(
                          boolMode: false,
                          value: value,
                          size: 6,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(value,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .primaryTextTheme!
                                    .headline6!
                                    .color!))
                      ],
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
