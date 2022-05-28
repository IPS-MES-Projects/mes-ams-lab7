// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mes_ams_lab7/app/app.dart';
import 'package:posts_api/posts_api.dart';
import 'package:posts_repository/posts_repository.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap({required PostsApi postsApi}) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  final postsRepository = PostsRepository(postsApi: postsApi);

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          App(
            postsRepository: postsRepository,
          ),
        ),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
