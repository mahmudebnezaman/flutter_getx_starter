import 'package:starterapp/const/consts.dart';
import 'package:starterapp/const/images.dart';
import 'package:starterapp/view/auth_screen/email_varification_screen.dart';
import 'package:starterapp/widgets-common/custom_textfeild.dart';
import 'package:starterapp/widgets-common/my_button.dart';


class ForgotPasswordEmailScreen extends StatelessWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
          children: [
            Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(icApplogo, width: 250,),
                    // "skip".text.color(textfieldGrey).size(16).fontFamily(semibold).make().onTap(() {Get.to(()=> const Home());}),
                  ],
                ),
        
        
                5.heightBox,
                'Find your accout'.text.bold.size(25).color(highEmphasis).make(),
                
                25.heightBox,
                // Obx(()=>
                Column(
                    children: [
                      customTextFeild(hint: 'example@email.com', title: 'Email', prefixIcon: const Icon(Icons.email_rounded)),
                      10.heightBox,
                      // controller.isloading.value ?  loadingIndicator() : 
                      myButton(
                        color: primary,
                        onPress: () {
                          // vaildation();
                          Get.to(()=> const EmailVarificationScreen());
                        },
                        textColor: whiteColor,
                        title: 'Find Account',
                        buttonSize: 20.0,
                      ).box.width(context.screenWidth).make(),
                    ],
                  ),
                // ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}