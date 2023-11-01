import 'dart:io';

import 'package:mock_data/mock_data.dart';
import 'package:mockito/mockito.dart';

class MockHttpOverrides extends HttpOverrides {}

String mockEmail() => '${mockString()}@${mockString()}.${mockString(3)}';

Uri mockUri() => Uri.parse(mockUrl('*', true));
Uri mockFileUri() => Uri.parse(mockUrl('file', true));

class MockVoidCallback extends Mock {
  void call();
}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
