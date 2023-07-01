import 'package:starterapp/const/consts.dart';
import 'package:starterapp/const/images.dart';
import 'package:starterapp/const/loading_indicator.dart';
import 'package:starterapp/controller/mail_varification_controller.dart';
import 'package:starterapp/widgets-common/my_button.dart';

class EmailVarificationScreen extends StatelessWidget {
  const EmailVarificationScreen({Key? key, emailaddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MailVarificationController());

    Future<bool> onWillPop() async {
      await controller.removeUser(auth.currentUser?.uid);
      await auth.currentUser?.delete();
      // Get.to(() => const LoginScreen());
      return true;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
        ),
        body: Stack(
          children: [
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Image.asset(imgForgotPassBg),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(icApplogo, width: 250,),
                  const SizedBox(height: 5),
                  'Varifyyouraccount'.text.bold.size(25).color(highEmphasis).make(),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      const Icon(Icons.attach_email_outlined, size: 50, color: darkFontGrey),
                      if (auth.currentUser?.email != null)
                        ('We have sent you an email${auth.currentUser!.email!}please check').text.align(TextAlign.justify).make(),
                      const SizedBox(height: 10),
                      // ifnotautoredirect.text.align(TextAlign.justify).make(),
                      const SizedBox(height: 20),
                      controller.isloading.value ? loadingIndicator() : myButton(
                        color: primary,
                        onPress: () {
                          controller.isloading(true);
                          controller.manualRedirect(context);
                        },
                        textColor: whiteColor,
                        title: 'Continue',
                        buttonSize: 20.0,
                      ).box.width(context.screenWidth).make(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
