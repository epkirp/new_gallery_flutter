import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gallery/inputs/input_fields.dart';
import 'package:new_gallery/resources/app_assets.dart';
import 'package:new_gallery/resources/app_colors.dart';
import 'package:new_gallery/resources/app_strings.dart';
import 'package:new_gallery/scenes/sign_in/sign_in_bloc.dart';
import 'package:new_gallery/widgets/custom_text_form_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: BlocConsumer<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInFinishLoading) {
              Navigator.pop(context);
            }

            //todo
            //if (state is OpenSignUpScreen) {
            //
            //}

            if (state is SignInLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return WillPopScope(
                    child: SimpleDialog(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.gray),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onWillPop: () async => true,
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return _buildMainScreenWidget(state, context);
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Center(
        child: GestureDetector(
            child: Text(AppStrings.cancel, style: TextStyle(color: AppColors.darkGray, fontSize: 15.0)),
            onTap: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Divider(
          color: AppColors.darkGray,
          height: 1,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: 100,
      child: Column(
        children: [
          Text(
            AppStrings.signIn,
            style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: AppColors.pink,
            thickness: 2,
            height: 2,
          )
        ],
      ),
    );
  }

  Widget _buildMainScreenWidget(SignInState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 100, 16, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTitle(),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: CustomTextFormField(
              hintText: AppStrings.email,
              errorText: _setErrorText(state, InputFields.email),
              iconPath: AppAssets.iconEmail,
              onChanged: (value) => context.read<SignInBloc>().add(EmailChanged(value)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 29),
            child: CustomTextFormField(
              hintText: AppStrings.password,
              errorText: _setErrorText(state, InputFields.password),
              iconPath: AppAssets.iconPassword,
              onChanged: (value) => context.read<SignInBloc>().add(PasswordChanged(value)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                AppStrings.forgotLoginOrPassword,
                style: TextStyle(color: AppColors.gray, fontSize: 13),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
              onPressed: () => context.read<SignInBloc>().add(SignInClicked()),
              child: Text(
                AppStrings.signIn,
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 19),
            child: GestureDetector(
                child: Text(AppStrings.signUp, style: TextStyle(color: Colors.black, fontSize: 17)),
                onTap: () {
                  context.read<SignInBloc>().add(SignUpClicked());
                }),
          ),
        ],
      ),
    );
  }

  String? _setErrorText(SignInState state, InputFields field) {
    if (state is SignInInitial) {
      return state.field == field ? state.errorMessage : null;
    }
    return null;
  }
}
