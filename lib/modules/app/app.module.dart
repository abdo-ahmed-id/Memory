import 'package:flutter_modular/flutter_modular.dart';
import 'package:memories/data/providers/memories_data_provider.dart';
import 'package:memories/helpers/routes.dart';
import 'package:memories/modules/app/bloc/app.bloc.dart';
import 'package:memories/modules/app/service/memory_service.dart';
import 'package:memories/modules/details/details.page.dart';
import 'package:memories/modules/home/home.page.dart';
import 'package:memories/modules/login/login.page.dart';
import 'package:memories/modules/splash/splash.page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => MemoriesDataProvider()),
    Bind((i) => MemoryService(i.get<MemoriesDataProvider>())),
    Bind((i) => AppBloc(i.get<MemoryService>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.splash, child: (_, args) => SplashPage()),
    ChildRoute(AppRoutes.home, child: (_, args) => HomePage()),
    ChildRoute(AppRoutes.details,
        child: (_, args) => DetailsPage(
              memories: args.data,
            )),
    ChildRoute(AppRoutes.login, child: (_, args) => LoginPage()),
  ];
}
