import 'package:get/get.dart';
import 'package:seller_app/controller/auth_controller.dart';
import 'package:seller_app/views/home_screen/home.dart';
import 'package:seller_app/widgets/button.dart';
import 'package:seller_app/widgets/loading_indicator.dart';

import '../../const/const.dart';
import '../../widgets/text_stryle.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              normaltext(text: welcome),
              20.heightBox,
              Row(
                children: [
                  Image.asset(icLogo, width: 80, height: 80)
                      .box
                      .border(color: white)
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .make(),
                  10.widthBox,
                  boldText(text: appname, size: 18.0),
                ],
              ),
              30.heightBox,
              normaltext(text: loginto, size: 18.0, color: lightGery),
              20.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                            fillColor: textfieldGrey,
                            filled: true,
                            prefixIcon: Icon(Icons.email, color: purpleColor),
                            border: InputBorder.none,
                            hintText: emailHint)),
                    10.heightBox,
                    TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                            fillColor: textfieldGrey,
                            filled: true,
                            prefixIcon: Icon(Icons.lock, color: purpleColor),
                            border: InputBorder.none,
                            hintText: passwordHint)),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            Get.to(() => Home());
                          },
                          child: normaltext(
                              text: forgotPassword, color: purpleColor)),
                    ),
                    30.heightBox,
                    SizedBox(
                        width: context.screenWidth - 100,
                        child: controller.isLoading.value
                            ? loadingIndicator()
                            : Button(
                                title: login,
                                onPress: () async {
                                  controller.isLoading(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loggedin);
                                    } else {
                                      controller.isLoading(false);
                                    }
                                  });
                                }))
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              10.heightBox,
              Center(
                child: normaltext(text: anyProblem, color: lightGery),
              ),
              const Spacer(),
              Center(
                child: boldText(text: credit),
              ),
              20.heightBox
            ],
          ),
        ));
  }
}
