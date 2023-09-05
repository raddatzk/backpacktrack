extension DoubleExtension on double {

  String stringify() {
    if (this == roundToDouble()) {
      return toInt().toString();
    }

    return toString();
  }
}