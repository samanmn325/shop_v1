import '../../../components/offer_card.dart';
import '../../../net/brain.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'offer_title_box.dart';

class OfferSlider extends StatefulWidget {
  const OfferSlider({Key? key}) : super(key: key);
  @override
  _OfferSliderState createState() => _OfferSliderState();
}

class _OfferSliderState extends State<OfferSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 1 / 3,
          decoration: BoxDecoration(color: kPrimaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OfferTitleBtn(),
            ],
          ),
        ),
        //
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(color: kPrimaryColor),
              child: Row(
                children: [
                  ...List.generate(Brain.publicProductList.length, (index) {
                    if (Brain.publicProductList[index].dateOnSaleTo != null) {
                      return OfferCard(
                        product: Brain.publicProductList[index],
                      );
                    } else
                      return Container();
                  })
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
