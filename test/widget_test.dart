import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:highlevel/gamification/gamification_di.dart';
import 'package:highlevel/gamification/presentation/ui/gamification_dashboard_page.dart';
import 'package:highlevel/init.dart';
import 'package:highlevel/main.dart';

void main() {
  final getIt = GetIt.instance;

  setUp(() async {
    await getIt.reset();
    await configureDependencies();
    await GamificationDi.initialize();
  });

  testWidgets('Gamification dashboard renders after load', (tester) async {
    await tester.pumpWidget(const HighlevelApp());
    await tester.pumpAndSettle();
    expect(find.byType(GamificationDashboardPage), findsOneWidget);
  });
}
