import 'package:barber_app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('shows role selection when logged out', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const BarberApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.text('اختر نوع الدخول'), findsOneWidget);
    expect(find.text('متابعة كعميل'), findsOneWidget);
    expect(find.text('متابعة كأدمن'), findsOneWidget);
  });
}
