import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_selection_store/locator.dart';
import 'business_logic/controller/app_blocs_observer.dart';
import 'business_logic/cubit/dynamiclinks_cubit.dart';
import 'business_logic/cubit/internet_cubit.dart';
import 'firebase_options.dart';
import 'package:path_provider/path_provider.dart';
import 'business_logic/cubit/products_cubit.dart';
import 'helpers/routes.dart';

void main() async {
  //Esperamos el Binding initializing primero para poder llamar métodos nativos como el getApplicationDocumentsDirectory()
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name: 'MiAguila-Store-JobTest');

  HydratedStorage storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  //inicializamos el get_it para la inyección de dependencias
  setupDependenciesInjection();

  //iniciamos la App
  HydratedBlocOverrides.runZoned(
      () => runApp(MyApp(
            connectivity: Connectivity(),
          )),
      blocObserver: AppBlocObserver(),
      storage: storage);
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({Key? key, required this.connectivity}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
            create: (BuildContext context) => ProductsCubit()),
        BlocProvider<InternetCubit>(
            create: (BuildContext context) =>
                InternetCubit(connectivity: connectivity)),
        BlocProvider<DynamiclinksCubit>(
            create: (BuildContext context) => DynamiclinksCubit(
                productsCubit: BlocProvider.of<ProductsCubit>(context))),
      ],
      child: MaterialApp(
        title: 'MiAguilaStore JobTest',
        onGenerateRoute: (RouteSettings settings) =>
            MyRoutes.getRoutes(settings),
        initialRoute: MyRoutes.homePath,
      ),
    );
  }
}
