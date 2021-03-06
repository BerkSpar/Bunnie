import 'modules/main/presenter/widgets/simple_card/simple_card_controller.dart';
import 'package:rabbited/app/modules/login/presenter/page/login/login_page.dart';
import 'package:rabbited/app/modules/main/presenter/page/home/home_page.dart';
import 'modules/login/presenter/page/login/login_controller.dart';
import 'package:dio/dio.dart';
import 'package:rabbited/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:rabbited/app/app_widget.dart';
import 'package:rabbited/app/modules/main/domain/usecases/search_by_id.dart';
import 'package:rabbited/app/modules/main/domain/usecases/search_by_text.dart';
import 'package:rabbited/app/modules/main/external/datasources/jikan_datasource.dart';
import 'package:rabbited/app/modules/main/infra/repositories/search_repository_impl.dart';
import 'package:rabbited/app/modules/main/presenter/page/anime/anime_page.dart';
import 'package:rabbited/app/modules/main/presenter/page/home/home_controller.dart';
import 'package:rabbited/app/modules/main/presenter/widgets/search_anime_delegate/search_anime_delegate_controller.dart';

import 'modules/main/presenter/page/anime/anime_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => SimpleCardController()),
        Bind((i) => LoginController()),
        Bind((i) => AnimeController()),
        Bind((i) => SearchAnimeDelegateController(), singleton: false),
        Bind((i) => HomeController()),
        Bind((i) => AppController()),
        Bind((i) => Dio()),
        Bind((i) => JikanDatasource(i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchByIdImpl(i())),
        Bind((i) => SearchRepositoryImpl(i())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (context, args) => LoginPage()),
        Router('/home', child: (context, args) => HomePage()),
        Router('/anime/:id',
            child: (context, args) =>
                AnimePage(animeId: int.parse(args.params['id']))),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
