import 'package:flutter/gestures.dart';
import 'package:starterapp/const/consts.dart';
import 'package:starterapp/const/images.dart';
import 'package:starterapp/const/loading_indicator.dart';
import 'package:starterapp/controller/auth_controller.dart';
import 'package:starterapp/view/auth_screen/email_varification_screen.dart';
import 'package:starterapp/widgets-common/custom_passwordfeild.dart';
import 'package:starterapp/widgets-common/custom_textfeild.dart';
import 'package:starterapp/widgets-common/my_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

class _SignUpState extends State<SignUp> {

  
  var nameIcon = const Icon(Icons.account_circle_outlined, size: 25,);
  var emailIcon = const Icon(Icons.email_outlined, size: 25,);

  bool? isCheck = true;
  bool? isValid = false;

  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  void vaildation() async {
    if (nameController.text.isEmpty && emailController.text.isEmpty && passwordController.text.isEmpty && retypePasswordController.text.isEmpty) {
      VxToast.show(context, msg: "Please fill the signup form");
    } else {
      if (emailController.text.isEmpty) {
      VxToast.show(context, msg: "Email feild is Empty");
    } else if (!regExp.hasMatch(emailController.text)) {
      VxToast.show(context, msg: "Please Try Vaild Email");
    } else if (passwordController.text.isEmpty) {
      VxToast.show(context, msg: "Password feild is Empty");
    } else if (passwordController.text.length < 8) {
      VxToast.show(context, msg: "Minimum password length is 8");
    } else if (passwordController.text != retypePasswordController.text) {
      VxToast.show(context, msg: "Password not matched");
    } else {
      signUpButtonPress();
    }
    }
  }

  signUpButtonPress () async {
    if (isCheck != false){
      controller.isloading(true);
      try{
        await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value){
          return controller.storeUserData(
            email: emailController.text,
            name: nameController.text,
            password: passwordController.text,
          );
          }).then((value) {
            VxToast.show(context, msg: 'Account Created');
            controller.isloading(false);
            Get.to(()=> EmailVarificationScreen(emailaddress: emailController.text,));
         });
      } catch(e){
        controller.isloading(false);
        auth.signOut();
      }
    }
  }

  bool isPass = true;
  bool isConfirmPass = true;

  void togglePasswordView() {
    setState(() {
      isPass = !isPass;
    });
  }
  void toggleConfirmPasswordView() {
    setState(() {
      isConfirmPass = !isConfirmPass;
    });
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    // resizeToAvoidBottomInset: false,
    backgroundColor: whiteColor,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(()=>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(icApplogo, width: 250,),
                  // "skip".text.color(textfieldGrey).size(16).fontFamily(semibold).make().onTap(() {Get.to(const Home());}),
                ],
              ),
        
              5.heightBox,
              'Sign Up'.text.fontFamily(bold).size(35).color(highEmphasis).make(),
              25.heightBox,
              'Already have an account'.text.color(darkFontGrey).size(20).fontFamily(semibold).make(),
              5.heightBox,
              'Sing in here'.text.color(primary).size(20).fontFamily(semibold).make().onTap((){
                Get.back();
              }),
              
              //textfeild
              25.heightBox,
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      customTextFeild(title: 'Name', hint: 'ex: Captain Jake Sppawrow', controller: nameController, prefixIcon: nameIcon),
                      10.heightBox,
                      customTextFeild(hint: 'example@email.com', title: 'Email', prefixIcon: emailIcon, controller: emailController),
                      10.heightBox,
                      customPasswordFeild(hint: 'xxxxxx', title: 'Password', obsText: isPass, suffixIcon: InkWell(
                      onTap: togglePasswordView,
                      child: Icon(
                        isPass 
                          ? Icons.visibility 
                          : Icons.visibility_off,
                      )), controller: passwordController),
                      10.heightBox,
                      customPasswordFeild(hint: 'xxxxxx', title: 'Confirm Password', obsText: isConfirmPass, suffixIcon: InkWell(
                      onTap: toggleConfirmPasswordView,
                      child: Icon(
                        isConfirmPass 
                          ? Icons.visibility 
                          : Icons.visibility_off,
                      )), controller: retypePasswordController),
                      5.heightBox,
                      
                      //checkbox
                      Row(
                        children: [
                          Checkbox(
                            activeColor: primary,
                            checkColor: whiteColor,
                            value: isCheck,
                            onChanged: (newValue){
                              setState(() {
                                isCheck = newValue;
                              });
                          }),
                          5.widthBox,
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                      fontFamily: 'regular',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: const TextStyle(
                                      fontFamily: 'regular',
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Get.to(()=> const PrivacyScreen());
                                      },
                                  ),
                                  const TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: 'regular',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: const TextStyle(
                                      fontFamily: 'regular',
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Get.to(()=> const TermsScreen());
                                      },
                                  ),
                                ],
                              ),
                            ),
                          )

                        ],
                      ),
                      5.heightBox,
                      controller.isloading.value ? loadingIndicator() : myButton(
                        color: isCheck == true ? primary : lightGrey,
                        title: 'Sign Up',
                        textColor: isCheck == true ? whiteColor : fontGrey,
                        onPress: (){
                          vaildation();
                        },
                        buttonSize: 20.0,
                      ).box.width(context.screenWidth).make(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    ));
  }
}