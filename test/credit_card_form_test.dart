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

    testWidgets('clearForm clears the model and notifies parent',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget(
        cardNumber: '',
        expiryDate: '',
        cardHolderName: '',
        cvvCode: '',
      ));

      // Enter some values by typing into the fields
      await tester.enterText(
          find.byType(TextFormField).at(0), '4242424242424242');
      await tester.enterText(find.byType(TextFormField).at(1), '1225');
      await tester.enterText(find.byType(TextFormField).at(2), '123');
      await tester.enterText(find.byType(TextFormField).at(3), 'John Doe');
      await tester.pump();

      // Verify values were entered in the model
      expect(lastModel, isNotNull);
      expect(lastModel!.cardNumber, isNotEmpty);
      expect(lastModel!.expiryDate, isNotEmpty);
      expect(lastModel!.cvvCode, isNotEmpty);
      expect(lastModel!.cardHolderName, 'John Doe');

      // Clear the form
      creditCardFormKey.currentState?.clearForm();
      await tester.pumpAndSettle();

      // Verify the model was cleared and parent was notified
      expect(lastModel, isNotNull);
      expect(lastModel!.cardNumber, isEmpty);
      expect(lastModel!.expiryDate, isEmpty);
      expect(lastModel!.cardHolderName, isEmpty);
      expect(lastModel!.cvvCode, isEmpty);
    });

    testWidgets('clearForm works when form is empty',
        (WidgetTester tester) async {
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

    testWidgets('clearForm resets the model after validation',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Enter invalid data
      final Finder cardNumberField = find.byType(TextFormField).first;
      await tester.enterText(cardNumberField, '1234');
      await tester.pump();

      // Validate - which should fail for invalid card number
      final bool isValid = formKey.currentState?.validate() ?? false;
      expect(isValid, isFalse);

      // Clear the form
      creditCardFormKey.currentState?.clearForm();
      await tester.pumpAndSettle();

      // Verify the model was cleared
      expect(lastModel, isNotNull);
      expect(lastModel!.cardNumber, isEmpty);
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
