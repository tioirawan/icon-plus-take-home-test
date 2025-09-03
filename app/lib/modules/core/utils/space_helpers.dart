import 'package:flutter/widgets.dart';

extension SpaceHelpers on num {
  SizedBox get heightBox => SizedBox(height: toDouble());
  SizedBox get widthBox => SizedBox(width: toDouble());
}
