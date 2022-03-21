// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_selection_store/business_logic/cubit/products_cubit.dart';

import 'package:my_selection_store/main.dart';
import 'package:my_selection_store/presentation/widgets/generalWidgets/grid_products.dart';

void main() {
  testWidgets('HomePage loads items in the scroll',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BlocProvider(
      create: ((context) => ProductsCubit()),
      child: MyApp(
        connectivity: Connectivity(),
      ),
    ));

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
  });
}
