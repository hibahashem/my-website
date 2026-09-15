import 'package:flutter_test/flutter_test.dart';
import 'package:personal_portfolio/main.dart';

void main() {
  testWidgets('Portfolio home renders hero name', (tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Hiba Hashem'), findsOneWidget);
    expect(find.text("I'm"), findsOneWidget);
  });
}
