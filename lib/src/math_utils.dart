double inverseLerp(double a, double b, double v) {
  return ((v - a) / (b - a));
}

double lerp(double a, double b, double t) {
  return (1.0 - t) * a + b * t;
}

double remap(double iMin, double iMax, double oMin, double oMax, double v) {
  double t = inverseLerp(iMin, iMax, v);
  return lerp(oMin, oMax, t);
}
