import 'package:app/controllers/common/authentication/authentication_cubit.dart';
import 'package:app/controllers/common/authentication/authentication_state.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/services/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
          decoration: BoxDecoration(
              color: appTheme.scaffoldBackgroundColor,
              // gradient: containerGradient,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 196, 196, 196),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              state is AuthenticatedAsClient
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${'hi'.tr} ${state.client.username.capitalizeFirst}',
                          style: appTheme.textTheme.headlineLarge,
                        ),
                        Text(
                          '${Utils.getGreeting()}!',
                          style: appTheme.textTheme.headlineSmall,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              CircleAvatar(
                backgroundColor: appTheme.scaffoldBackgroundColor,
                radius: 30,
                child: Image.asset('assets/images/logo.png'),
              ),
            ],
          ),
        );
      },
    );
  }
}
