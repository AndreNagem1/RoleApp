import 'package:flutter/cupertino.dart';
import 'package:rolesp/widgets/home_gradient_effect.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/city.jpg',
            fit: BoxFit.fill,
            height: 350,
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/big_logo.png',
              height: 100,
            ),
          ),
          const HomeGradientEffect(),
        ],
      ),
    );
  }
}
