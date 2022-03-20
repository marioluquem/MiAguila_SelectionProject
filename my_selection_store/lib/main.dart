import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_selection_store/business_logic/controller/app_blocs_observer.dart';
import 'package:path_provider/path_provider.dart';
import 'business_logic/cubit/products_cubit.dart';
import 'helpers/routes.dart';

void main() async {
  //Esperamos el Binding initializing primero para poder llamar métodos nativos como el getApplicationDocumentsDirectory()
  WidgetsFlutterBinding.ensureInitialized();

  HydratedStorage storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  HydratedBlocOverrides.runZoned(() => runApp(MyApp()),
      blocObserver: AppBlocObserver(), storage: storage);
}

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
