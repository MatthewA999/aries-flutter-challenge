import 'package:flutter_challenge/utils/enums.dart';

extension CallOptionExtension on CallOption {
  String getOption() {
    switch (this) {
      case CallOption.long:
        return 'long';
      case CallOption.short:
        return 'Short';
      default:
        return 'undefined';
    }
  }
}

extension CallTypeExtension on CallType {
  String getType() {
    switch (this) {
      case CallType.call:
        return 'Call';
      case CallType.put:
        return 'Put';
      default:
        return 'undefined';
    }
  }
}
