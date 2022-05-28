// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:mes_ams_lab7/bootstrap.dart';
import 'package:posts_api/posts_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dio = Dio();
  final postsApi = PostsApi(dio);

  bootstrap(postsApi: postsApi);
}
