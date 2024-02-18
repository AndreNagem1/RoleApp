import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rolesp/widgets/home_gradient_effect.dart';
import 'package:rolesp/globals.dart' as globals;

class HomeBanner extends StatelessWidget {
  final bool isLight;

  const HomeBanner({Key? key, required this.isLight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var banner = 'assets/images/city.jpg';
    if (isLight) {
      banner = 'assets/images/rest.jpg';
    }
    return GestureDetector(
      onTap: () {
        if(globals.enabledGooglePlacesApi){
          globals.enabledGooglePlacesApi = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Api Google DESLIGADA"),
          ));
        }else{
          globals.enabledGooglePlacesApi = true;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Api Google LIGADA"),
          ));
        }
      },
      child: SizedBox(
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
      ),
    );
  }
}
