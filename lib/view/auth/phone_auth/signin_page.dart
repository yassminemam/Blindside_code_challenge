import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';
import '../../../routes/app_routs.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/color_palette.dart';
import '../../../utils/strings.dart';
import '../../../view_model/app_auth_provider.dart';
import '../../../view_model/user_provider.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  static const double _grayAreaHeightPercentage = 30; //TODO ask Adel
  static const double _whiteAreaHeightPercentage =
      100 - _grayAreaHeightPercentage;
  static const double pix8Percentage = 1;
  static const double pix16Percentage = 2;
  static const double pix24Percentage = 3;
  static const double pix32Percentage = 4;
  static const double pix64Percentage = 8;
  String phoneNum = "";
  String countryCode = "+971";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        left: false,
        top: true,
        right: false,
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/images/bg.png",
                    height: 250,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      AppStrings.appTitle,
                      style: AppStyles.robortoDarkGrayH1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      AppStrings.signIn,
                      style: AppStyles.robortoDarkGrayH1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 300,
                      height: 60,
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        color: Palette.whiteColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CountryCodePicker(
                            onChanged: (code) {
                              setState(() {
                                countryCode = code.dialCode!;
                              });
                            },
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'AE',
                            countryFilter: ['DE', 'TR', 'AE', 'EG'],
                            showFlagDialog: false,
                            comparator: (a, b) => b.name!.compareTo(a.name!),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: 150,
                              height: 56,
                              child: TextField(
                                style: AppStyles.robortoDarkGrayB2,
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                onChanged: (value) {
                                  setState(() {
                                    phoneNum = countryCode + value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: AppStrings.mobile_num,
                                  hintStyle:
                                  const TextStyle(color: Palette.textColor),
                                  labelStyle: TextStyle(
                                      color: const Color(kGrayDarkHex),
                                      fontSize: 18),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 300,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Palette.secondaryDarkColor,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      ),
                      child: InkWell(
                        onTap: () {
                          Provider
                              .of<UserProvider>(context, listen: false)
                              .mobileNumber = phoneNum;
                          context
                              .read<AppAuthProvider>()
                              .sendOTPcode(context: context)
                              .then((value) =>
                              Navigator.pushNamed(
                                  context, AppRoutes.sign_in_phone_otp_page));
                        },
                        child: Center(
                          child: Text(
                            AppStrings.continu,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
