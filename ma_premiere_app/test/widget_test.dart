import 'package:_ma_premiere_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Login persists until logout', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(const MyApp());
    expect(find.text('Connexion'), findsOneWidget);

    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();
    expect(prefs.getBool('connecte'), isTrue);
    expect(find.text("Page d'Accueil"), findsOneWidget);

    await tester.pumpWidget(const MyApp(key: ValueKey('signed-in-restart')));
    await tester.pumpAndSettle();
    expect(find.text("Page d'Accueil"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Déconnexion'));
    await tester.pumpAndSettle();
    expect(prefs.getBool('connecte'), isNull);

    await tester.pumpWidget(const MyApp(key: ValueKey('signed-out-restart')));
    await tester.pumpAndSettle();
    expect(find.text('Connexion'), findsOneWidget);
  });
}
