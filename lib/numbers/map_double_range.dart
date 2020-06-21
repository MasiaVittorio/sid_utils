
extension DoubleSidMapToRange on num {

  double mapToRange(double toMin, double toMax, {
    num fromMin = 0.0,
    num fromMax = 1.0,
  }) => toMin + ((this - fromMin) / (fromMax - fromMin)).clamp(0.0, 1.0) * (toMax - toMin);
  

  //Much much faster, but you can get numbers out of the range of [toMin,toMax];
  double mapToRangeLoose(double toMin, double toMax, {
    num fromMin = 0.0,
    num fromMax = 1.0,
  }) => toMin + ((this - fromMin) / (fromMax - fromMin)) * (toMax - toMin);

}


class DoubleExt {
  static mapToRangeLoose(
    double val, 
    double toMin,
    double toMax, {
    double fromMin = 0.0,
    double fromMax = 1.0,
  }) => toMin + ((val - fromMin) / (fromMax - fromMin)) * (toMax - toMin);

  static mapToRange(
    double val, 
    double toMin,
    double toMax, {
    double fromMin = 0.0,
    double fromMax = 1.0,
  }) => toMin + ((val - fromMin) / (fromMax - fromMin)).clamp(0.0, 1.0) * (toMax - toMin);

}

