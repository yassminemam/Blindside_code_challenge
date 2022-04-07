import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/app_routs.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/color_palette.dart';
import '../../../utils/strings.dart';
import '../../../view_model/app_auth_provider.dart';
import '../../../view_model/user_provider.dart';

class SignInOTPPage extends StatefulWidget {
  SignInOTPPage({Key? key}) : super(key: key);

  @override
  State<SignInOTPPage> createState() =>
      _SignInOTPPageState();
}

//
class _SignInOTPPageState extends State<SignInOTPPage> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.verification,
          style: TextStyle(color: Palette.textColor),
        ),
        leading: const BackButton(
          color: Palette.textColor,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
                left: 18.0, top: 22.0, right: 18.0, bottom: 18.0),
            child: Text(
              AppStrings.cancel,
              style: TextStyle(
                  color: Palette.textColor,
                  decoration: TextDecoration.underline),
            ),
          )
        ],
        elevation: 0.0,
        backgroundColor: Palette.primaryColor,
      ),
      body: SafeArea(
        left: false,
        top: true,
        right: false,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Text(
                AppStrings.verification,
                style: AppStyles.robortoDarkGrayH1,
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 56,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    style: const TextStyle(color: Palette.textColor),
                    keyboardType: TextInputType.phone,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    onChanged: (value) {
                      setState(() {
                        otp = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: AppStrings.otp_hint,
                      hintStyle: const TextStyle(color: Palette.blueGrayColor),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      labelStyle: TextStyle(
                          color: Palette.textColor, fontSize: 18),
                      border: InputBorder.none,
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 36,
              decoration: const BoxDecoration(
                color: Palette.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: InkWell(
                onTap: () {
                  Provider.of<UserProvider>(context, listen: false).otp = otp;
                  Provider.of<AppAuthProvider>(context, listen: false).signInWithPhoneNumber(context: context)
                      .then((value) => Navigator.pushNamed(
                      context, AppRoutes.all_videos_page));
                },
                child: const Center(
                  child: Text(
                    AppStrings.next,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                context
                    .read<AppAuthProvider>()
                    .signInWithPhoneNumber(context: context);
              },
              child: const Center(
                child: Text(
                  AppStrings.resend_otp,
                  style: TextStyle(
                      color: Palette.secondaryLightColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
