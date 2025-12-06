import 'package:flutter_test/flutter_test.dart';
import 'package:responsi2mobile_paket3_h1d023029/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const ReremartApp());

    // Cek kalau halaman login tampil
    expect(find.text("Login Reremart"), findsOneWidget);
  });
}
