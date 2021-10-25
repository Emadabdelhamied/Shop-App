import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/onBoardingModel.dart';
import 'file:///D:/Flutter_Projects/shop_app/lib/modules/login/loginScreen.dart';
import 'package:shop_app/shared/component/componant.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/Cubit.dart';
import 'package:shop_app/shared/cubit/States.dart';
import 'package:shop_app/shared/network/local/cacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var pageContraller = PageController();
        List<OnBoard> boarding = [
          OnBoard(
              image: 'assets/images/onBoarding1.png',
              title: 'On Board 1',
              body: 'body 1'),
          OnBoard(
              image: 'assets/images/onBoarding2.png',
              title: 'On Board 2',
              body: 'body 2'),
          OnBoard(
              image: 'assets/images/onBoarding3.png',
              title: 'On Board 3',
              body: 'body 3'),
        ];
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    submit();
                  },
                  child: Text('SKIP'))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: pageContraller,
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemBuilder: (context, index) =>
                        buildBoarding(boarding[index]),
                    itemCount: boarding.length,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: pageContraller,
                      count: boarding.length,
                      effect: ExpandingDotsEffect(
                          activeDotColor: defultColor,
                          dotHeight: 10,
                          dotWidth: 10,
                          spacing: 5,
                          expansionFactor: 3),
                    ),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        if (isLast) {
                          submit();
                        } else {
                          pageContraller.nextPage(
                              duration: Duration(milliseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void submit() {
    CacheHelper.setData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        naigateAndRemove(context, LoginScreen());
      }
    });
  }

  Widget buildBoarding(OnBoard model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset('${model.image}')),
          SizedBox(
            height: 20,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 10,
          ),
          Text('${model.body}'),
        ],
      );
}
