import 'package:admin/common_widgets/button_widget.dart';
import 'package:admin/common_widgets/input_widget.dart';
import 'package:admin/constants.dart';
import 'package:admin/di/injector.dart';
import 'package:admin/screens/auth/bloc/auth_bloc.dart';
import 'package:admin/utils/print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(injector()),
      child: BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
        var bloc = context.read<AuthBloc>();
        return Container(
          color: primaryColor,
          child: Column(
            children: [
              Spacer(),
              Container(
                child: Input(
                  controller: bloc.emailController,
                  hint: 'Email',
                  margin: EdgeInsets.all(12),
                ),
                width: 400,
              ),
              Container(
                child: Input(
                  controller: bloc.passwordController,
                  hint: 'Password',
                  margin: EdgeInsets.all(12),
                ),
                width: 400,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Button(
                  disabled: state.authStatus == AuthStatus.loading,
                  width: 152,
                  height: 52,
                  title: 'Login',
                  onClick: () {
                    bloc.add(TryLogin());
                  },
                ),
                width: 420,
              ),
              Spacer(),
            ],
          ),
        );
      }, listener: (context, state) {
        if (state.authStatus == AuthStatus.fail) {
          context.showSnackBar(state.message, status: MessageStatus.fail);
        }
      }),
    );
  }
}
