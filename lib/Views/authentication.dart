// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:iskaanowner/Blocs/Authentication/authentication_cubit.dart';
import 'package:iskaanowner/Utils/utils.dart';
import 'package:lottie/lottie.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Authentication",
          appBar: AppBar(),
          widgets: [
            IconButton(
                onPressed: () async {
                  Global.storageService.removeUser().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.login, (route) => false));
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: primaryColor,
                ))
          ],
          appBarHeight: 50),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LottieBuilder.asset(
            "assets/auth.json",
          ),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return CustomButton(
                  buttonColor: primaryColor,
                  textColor: kWhite,
                  text: state.isAuthenticating
                      ? "Authenticating"
                      : "Authenticate",
                  width: MediaQuery.of(context).size.width / 2,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  function: () {
                    context.read<AuthenticationCubit>().authenticate(context);
                  });
            },
          )
        ],
      ),
    );
  }
}
