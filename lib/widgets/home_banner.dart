import 'package:flutter/cupertino.dart';
import 'package:rolesp/widgets/home_gradient_effect.dart';

class HomeBanner extends StatelessWidget {
  final bool isLight;

  const HomeBanner({Key? key, required this.isLight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var banner = 'assets/images/city.jpg';
    if (isLight) {
      banner = 'assets/images/rest.jpg';
    }
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Stack(
        children: [
          Image.asset(
            banner,
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
