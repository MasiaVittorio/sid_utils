import 'package:flutter_test/flutter_test.dart';

import 'package:sid_utils/sid_utils.dart';

void main() {
  test('separates letters with zeros', () {
    expect(["a","b"].separateWith("0").toString(), ["a","0","b"].toString());
  });
}
