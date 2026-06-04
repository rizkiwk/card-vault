import 'package:card_vault/core/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EmptyState renders title, message and action', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EmptyState(
            icon: Icons.style_outlined,
            title: 'No cards yet',
            message: 'Tap + to add your first card.',
            action: FilledButton(
              onPressed: () => tapped = true,
              child: const Text('Add Card'),
            ),
          ),
        ),
      ),
    );

    expect(find.text('No cards yet'), findsOneWidget);
    expect(find.text('Tap + to add your first card.'), findsOneWidget);

    await tester.tap(find.text('Add Card'));
    expect(tapped, isTrue);
  });
}
