import 'package:bitirme_odev/app_styles.dart';
import 'package:bitirme_odev/cubit/intro_cubits/onboarding_page_cubit.dart';
import 'package:bitirme_odev/entity/onboard_data.dart';
import 'package:bitirme_odev/size_configs.dart';
import 'package:bitirme_odev/views/intro/sign_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {

  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index){
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.white.withOpacity(1) : Colors.white.withOpacity(0.3),
        shape: BoxShape.circle
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<OnboardingPageCubit>().setSeenOnboard();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;
    double sizeH = SizeConfig.blockSizeH!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [orange.withOpacity(0.7),orange.withOpacity(1)]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: PageView.builder(
                      onPageChanged: (value){
                        setState(() {
                          currentPage = value;
                        });
                      },
                      controller: _pageController,
                      itemCount: onboardingContents.length,
                      itemBuilder: (context,index) =>
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignPage()));
                                  }, child: Text("Ge?? >>",style: TextStyle(color: white),)),
                                ],
                              ),
                              SizedBox(
                                height: sizeV * 15,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset("pics/img.png"),
                                    Image.asset("pics/logo.png")
                                  ],
                                ),
                              ),
                              Text(onboardingContents[index].title,style: onboardTitle,textAlign: TextAlign.center,),
                              SizedBox(height: sizeV*40,child: AspectRatio(aspectRatio: 1 / 1,child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(onboardingContents[index].image,fit: BoxFit.cover,)))),
                            ],
                          ),
                  )),
              Expanded(
                flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                        color: orange.withOpacity(0.5),
                        blurRadius: 40.0,
                        spreadRadius: 40.0,
                      ),]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        currentPage == onboardingContents.length - 1 ?
                            SizedBox(
                              width: sizeH * 50,
                              child: ElevatedButton(onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignPage()));
                              }, child: Text("Ba??layal??m",style: TextStyle(color: orange),),style:
                                ElevatedButton.styleFrom(
                                  primary: white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),),
                            )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             ...List.generate(onboardingContents.length, (index) => dotIndicator(index)),
                ],
              ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
