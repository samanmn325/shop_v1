import 'package:flutter/material.dart';

class OfferTitleBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/offer.png',
                ),
              ),
            )),
        SizedBox(
          height: 10,
        ),
        /*GestureDetector(
          onTap: () {},
          child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 11),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.white, style: BorderStyle.solid, width: 1),
                  borderRadius: BorderRadius.circular(6)),
              child: TextButton(
                child: Text("همه"),
                onPressed: () {
                  getOfferProducts();
                },
              )),
        )*/
      ],
    );
  }
}
