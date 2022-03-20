import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_selection_store/business_logic/cubit/products_cubit.dart';
import 'package:my_selection_store/helpers/routes.dart';
import 'package:my_selection_store/presentation/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
            create: (BuildContext context) => ProductsCubit()),
      ],
      child: MaterialApp(
        title: 'Material App',
        onGenerateRoute: (RouteSettings settings) =>
            MyRoutes.getRoutes(settings),
        initialRoute: MyRoutes.homePath,
      ),
    );
  }
}
