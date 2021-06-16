import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_gallery/resources/app_assets.dart';
import 'package:new_gallery/resources/app_colors.dart';
import 'package:new_gallery/resources/app_strings.dart';
import 'package:new_gallery/scenes/sign_in/sign_in_bloc.dart';
import 'package:new_gallery/widgets/CustomTextFormField.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 100, 16, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitle(),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: CustomTextFormField(hintText: AppStrings.email, iconPath: AppAssets.iconEmail),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 29),
                  child: CustomTextFormField(hintText: AppStrings.password, iconPath: AppAssets.iconPassword),
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
                    onPressed: () => null,
                    child: Text(
                      AppStrings.signIn,
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 19),
                  child: Text(
                    AppStrings.signUp,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _onSingInClicked({required BuildContext context, required String username, required String password}) {
    context.read<SignInBloc>().add(SignIn(username, password));
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: Center(child: Text(AppStrings.cancel, style: TextStyle(color: AppColors.darkGray, fontSize: 15.0))),
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
}
