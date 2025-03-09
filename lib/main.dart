import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentify/http/API_implements.dart';
import 'package:rentify/http/log/log.dart';
import 'package:rentify/page/search/search_cubit.dart';
import 'main_cubit.dart';
import 'package:rentify/page/detail/detail_cubit.dart';
import 'package:rentify/page/login/login_page.dart';
import 'package:rentify/page/property/property_cubit.dart';
import 'package:rentify/routers.dart';
import 'http/API.dart';
import 'http/log/log_impl.dart';
import 'page/property/home_page_view.dart';
import 'widget/tabBar_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Định nghĩa SimpleBlocObserver từ base code
class SimpleBlocObserver extends BlocObserver {
  final Log log;
  static const String TAG = "Bloc";

  const SimpleBlocObserver(this.log);

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    log.i(TAG, 'onCreate: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    log.i(TAG, 'onEvent: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log.i(TAG, 'onChange: ${bloc.runtimeType}, change: ${change.nextState}');
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc,
      Transition<dynamic, dynamic> transition,) {
    super.onTransition(bloc, transition);
    log.i(TAG, 'onTransition: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log.i(TAG, 'onError: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    log.i(TAG, 'onClose: ${bloc.runtimeType}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Log log = LogImplement();
  Bloc.observer = SimpleBlocObserver(log);
  runApp(
    RepositoryProvider<Log>.value(
      value: log,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<API>(
      create: (context) => API_implements(context.read<Log>()),
      // Cung cấp API_implements
      child: Provider(),
    );
  }
}

class Provider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainCubit(), // Cung cấp MainCubit
        ),
        BlocProvider(
          create: (context) => PropertyCubit(context.read<API>(),)
        ),
        BlocProvider(
          create: (context) => DetailCubit(context.read<API>()),),
        BlocProvider(create: (context) => SearchCubit(context.read<API>()),
        ),
      ],
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return MaterialApp(
            darkTheme: ThemeData.dark(),
            theme: ThemeData.light(),
            themeMode: state.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: mainRoute,
            initialRoute: LoginScreen
                .route, // Chỉ dùng initialRoute và onGenerateRoute
          );
        },
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


