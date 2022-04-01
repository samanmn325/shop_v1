import '../../../components/category_card.dart';
import '../../../components/section.dart';
import '../../../net/brain.dart';
import '../../../screens/product_detail/product_page.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CategoryBox extends StatefulWidget {
  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  @override
  Widget build(BuildContext context) {
    return Section(
        title: 'دسته بندی محصولات',
        children: [
          ...List.generate(
              Brain.productCategory.length,
              (index) => CategoryCard(
                  icon: isNull(Brain.productCategory[index].image)
                      ? ""
                      : Brain.productCategory[index].image!.src!,
                  text: Brain.productCategory[index].name!,
                  press: () {
                    print('print: ${Brain.productCategory[index].id}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductPage(
                            catId: Brain.productCategory[index].id,
                            catName: Brain.productCategory[index].name,
                          );
                        },
                      ),
                    );
                  }))
        ],
        press: () {});
  }
}

class DrawerCategory extends StatefulWidget {
  DrawerCategory({this.productCategoryName});
  final String? productCategoryName;
  @override
  State<DrawerCategory> createState() => _DrawerCategoryState();
}

class _DrawerCategoryState extends State<DrawerCategory> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            Brain.productCategory.length,
            (index) => DrawerCategoryCard(
                text: Brain.productCategory[index].name,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProductPage(
                          catId: Brain.productCategory[index].id,
                          catName: Brain.productCategory[index].name,
                        );
                      },
                    ),
                  );
                }))
      ],
    );
  }
}
