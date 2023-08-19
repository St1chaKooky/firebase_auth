import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MySetting extends StatelessWidget {
  final String _title;
  final Icon _icon;

  const MySetting({Key? key, required String title, required Icon icon})
      : _title = title,
        _icon = icon,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Container(
        child: Row(
          children: [
            _icon,
            SizedBox(width: 10),
            Text(_title),
          ],
        ),
      ),
    );
  }
}
