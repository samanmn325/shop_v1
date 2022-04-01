import 'package:flutter/material.dart';

/// the TryAgain is create to show TryAgain button when device disconnected
class TryAgain extends StatelessWidget {
  TryAgain({required this.callBack});
  final VoidCallback callBack;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Text('تلاش مجدد'),
          IconButton(
            icon: Icon(
              Icons.refresh,
              size: 40.0,
            ),
            onPressed: callBack,
          ),
        ],
      ),
      onTap: callBack,
    );
  }
}
