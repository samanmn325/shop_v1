// ignore_for_file: unnecessary_null_comparison

import '../../../net/net_helper.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:woocommerce/models/products.dart';
import '../../../constants.dart';

class ProductDescription extends StatefulWidget {
  ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
    required this.off,
  }) : super(key: key);
  final int off;
  final WooProduct product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          //product name
          child: Text(
            widget.product.name!,
            style: TextStyle(
              fontFamily: "Iransans",
              fontSize: 22,
              //fontWeight: FontWeight.
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Divider(),
        ),
        //Ex price and price
        productPrice(),
        Padding(
          padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5),
          child: Divider(),
        ),

        //  lateer add it with functionallity

        //product Count

        // productCount(),
        /*  Padding(
          padding: EdgeInsets.only(top: 5, left: 15, right: 0),
          child: Divider(),
        ),*/
        (widget.product.attributes.length > 0)
            ? Column(
                children: [
                  MoshakhasatFani(context),
                  Divider(),
                ],
              )
            : Container(),

        /*  Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(15),
            width: 64,
            decoration: BoxDecoration(
              color:Color(0xFFF5F6F9),
            //  product.isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight : Radius.circular(20),
              ),
            ),
            child: SvgPicture.asset(
              "assets/icons/Heart Icon_2.svg",
              color:
              product.isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
              height: 16,
            ),
          ),
        ),*/
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 20,
            right: 40,
          ),
          child: ReadMoreText(
            NetworkHelper().parseHtmlString(widget.product.description!),
            style: TextStyle(color: Colors.black),
            colorClickableText: kPrimaryColor,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'خواندن بیشتر',
            trimExpandedText: 'بستن',
          ),
        ),
        /* Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "خواندن بیشتر",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )*/
      ],
    );
  }

  Padding MoshakhasatFani(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.only(left: 25, right: 4),
          //shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(15)),
          // backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return proAtrrebiute(attrebiute: widget.product.attributes);
              });
        },
        child: Row(
          children: [
            SizedBox(width: 20),
            Expanded(
                child: Text(
              "خصوصیات فنی",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Iransans',
                  fontSize: 17,
                  fontWeight: FontWeight.normal),
            )),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }

  Padding productCount() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'تعداد:',
            style: TextStyle(
              fontFamily: 'Iransans',
              fontSize: 18,
            ),
          ),
          Text(
            '12 عدد ',
            style: TextStyle(
              fontFamily: 'Iransans',
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  productPrice() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 29.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              (widget.off == 0)
                  ? SizedBox(
                      height: 20,
                    )
                  : regularBox(),
              SizedBox(
                width: 5,
              ),
              percentBox(widget.off)
            ],
          ),
        ),

        //PRODUCT PRICE
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 25.0, right: 25, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'قیمت:',
                      style: TextStyle(
                        fontFamily: 'Iransans',
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '${kCheckPrice(widget.product.price.toString())}تومان',
                      style: TextStyle(
                          color: Colors.black.withOpacity(.7),
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      maxLines: 1,
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

//box darsad takhfif
  percentBox(int off) {
    if (off == 0)
      return SizedBox();
    else
      return Container(
        padding: EdgeInsets.only(right: 2),
        width: 35,
        height: 18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.red),
        child: Center(
          child: Text(
            off.toString(),
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      );
  }

//box gheymat asli mahsool
  regularBox() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(kCheckPrice(widget.product.regularPrice),
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough),
          maxLines: 1),
    );
  }

//jadval vijegiha

  proAtrrebite() {
    //List<WooProductItemAttribute> attributes = widget.product.attributes;
  }

//attrebiute table builder
}

class proAtrrebiute extends StatelessWidget {
  const proAtrrebiute({Key? key, required this.attrebiute}) : super(key: key);
  final List<WooProductItemAttribute> attrebiute;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 120, horizontal: 40),
          // width: MediaQuery.of(context).size.width * 0.8,
          // height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Container(
                height: 35,
                color: kSecondaryColor.withOpacity(0.1),
                child: Center(
                  child: Text("مشخصات فنی"),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  //margin: const EdgeInsets.all(15.0),
                  // padding: const EdgeInsets.all(3.0),

                  //height: 300,
                  // width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                            // margin: EdgeInsets.all(10),
                            child: (attrebiute == null)
                                ? SizedBox()
                                : createTable(attrebiute)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget createTable(List<WooProductItemAttribute> attr) {
    List<TableRow> rows = [];
    //length of attr
    for (int i = 0; i < attr.length; ++i) {
      rows.add(TableRow(children: [
        Padding(
            //gharar dadan vijegi dar vasat az lahaz sotooni
            padding:
                EdgeInsets.only(top: attr[i].options!.length * 12, right: 20),
            child: Text(
              "${attr[i].name} :",
              style: TextStyle(fontFamily: "Iransans", fontSize: 18),
            )),
        Column(
          children: attr[i]
              .options!
              .map((e) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //sakht attr option ha be soorat list sotooni

                      Text(e),
                      (attr[i].options!.indexOf(e) ==
                              attr[i].options!.length - 1)
                          ? SizedBox()
                          : Divider()
                    ],
                  ))
              .toList(),
        )
      ]));
    }
    return Table(
      children: rows,
      border: TableBorder.all(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
