// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mes_ams_lab7/home/home.dart';
import 'package:mes_ams_lab7/l10n/l10n.dart';
import 'package:posts_repository/posts_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.postsRepository,
  });

  final PostsRepository postsRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: postsRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.amber.shade700),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.amberAccent.shade700,
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
