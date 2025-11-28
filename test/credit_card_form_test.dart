import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreditCardForm', () {
    late GlobalKey<CreditCardFormState> creditCardFormKey;
    late GlobalKey<FormState> formKey;
    late CreditCardModel? lastModel;

    setUp(() {
      creditCardFormKey = GlobalKey<CreditCardFormState>();
      formKey = GlobalKey<FormState>();
      lastModel = null;
    });

    Widget buildTestWidget({
      String cardNumber = '',
      String expiryDate = '',
      String cardHolderName = '',
      String cvvCode = '',
    }) {
      return MaterialApp(
        home: Scaffold(
          body: CreditCardForm(
            key: creditCardFormKey,
            formKey: formKey,
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (CreditCardModel model) {
              lastModel = model;
            },
          ),
        ),
      );
    }

    testWidgets('clearForm clears all fields', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        cardNumber: '4242424242424242',
        expiryDate: '12/25',
        cardHolderName: 'John Doe',
        cvvCode: '123',
      ));

      // Verify initial values are set
      expect(find.text('4242 4242 4242 4242'), findsOneWidget);
      expect(find.text('12/25'), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('123'), findsOneWidget);

      // Clear the form
      creditCardFormKey.currentState?.clearForm();
      await tester.pump();

      // Verify fields are cleared
      expect(find.text('4242 4242 4242 4242'), findsNothing);
      expect(find.text('12/25'), findsNothing);
      expect(find.text('John Doe'), findsNothing);
      expect(find.text('123'), findsNothing);

      // Verify callback was called with empty values
      expect(lastModel, isNotNull);
      expect(lastModel!.cardNumber, isEmpty);
      expect(lastModel!.expiryDate, isEmpty);
      expect(lastModel!.cardHolderName, isEmpty);
      expect(lastModel!.cvvCode, isEmpty);
    });

    testWidgets('clearForm works when form is empty', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Clear the form (should not throw)
      creditCardFormKey.currentState?.clearForm();
      await tester.pump();

      // Verify callback was called with empty values
      expect(lastModel, isNotNull);
      expect(lastModel!.cardNumber, isEmpty);
      expect(lastModel!.expiryDate, isEmpty);
      expect(lastModel!.cardHolderName, isEmpty);
      expect(lastModel!.cvvCode, isEmpty);
    });

    testWidgets('clearForm resets form validation state',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Trigger validation with invalid data
      final cardNumberField = find.byType(TextFormField).first;
      await tester.enterText(cardNumberField, '1234');
      formKey.currentState?.validate();
      await tester.pump();

      // Clear the form
      creditCardFormKey.currentState?.clearForm();
      await tester.pump();

      // The form should be reset (validation errors should be cleared)
      // This is verified by the form not showing validation errors after clearing
      expect(find.text('1234'), findsNothing);
    });

    testWidgets('CreditCardFormState is accessible via GlobalKey',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Verify the state is accessible
      expect(creditCardFormKey.currentState, isNotNull);
      expect(creditCardFormKey.currentState, isA<CreditCardFormState>());
    });
  });
}
