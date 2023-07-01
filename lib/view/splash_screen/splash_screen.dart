import 'package:starterapp/const/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:starterapp/const/images.dart';
import 'package:starterapp/controller/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

var authcontroller = Get.put(AuthController());

changeScreen(){
    Future.delayed(const Duration(seconds: 2),(){
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted){
          // Get.offAll (()=>const LoginScreen());
        } else if (user!.emailVerified){
          // Get.offAll(()=>const Home());
        }
         else {
          // Get.offAll(()=>const EmailVarificationScreen());
        }
      });
    });
  }

  @override
  void initState(){
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: highEmphasis,
      body: Center(
        child: Column(
          children: [
            300.heightBox,
            Image.asset(icApplogo).box.size(220, 220).make(),
            const Spacer(),
            '@credits'.text.fontFamily(semibold).white.make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}