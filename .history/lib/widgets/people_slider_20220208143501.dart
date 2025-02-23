import 'dart:convert';

import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_banking_app/json/user_list.dart';
import 'package:flutter_banking_app/models/customer.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:http/http.dart' as http;

class PeopleSlider extends StatefulWidget {
  PeopleSlider({Key? key, this.toWhomId}) : super(key: key);

  String? toWhomId;

  @override
  _PeopleSliderState createState() => _PeopleSliderState();
}

class _PeopleSliderState extends State<PeopleSlider> {
  var controller = ScrollController();
  var currentPage = 0;

  List<Customer> customerNewList = [];

  void getList() async {
    final response = await http.get(API.listofUsers, headers: headers);

    if (response.statusCode == Status.ok) {
      var jsonBody = jsonDecode(response.body);

      for (var customer in jsonBody[Field.data]) {
        final customers = Customer.fromMap(customer);

        setState(() {
          customerNewList.add(customers);
        });
      }
    } else {
      print(Status.failed);
    }
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final theme = Layouts.getTheme(context);
    final size = Layouts.getSize(context);
    controller.addListener(() {
      setState(() {
        //currentPage = controller.page!.round();
      });
    });
    return _body(size.height, theme);
  }

  _body(double height, ThemeData theme) {
    double _height = height * 0.19;
    return SizedBox(
      height: _height,
      child: ListView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: customerNewList.length,
        itemBuilder: (context, index) {
          final item = customerNewList[index];
          return InkWell(
            onTap: () {
              setState(() {
                currentPage = index;
              });
              // print(controller.offset);
              // controller.animateTo(470,
              //     duration: const Duration(milliseconds: 700),
              //     curve: Curves.elasticOut);
              //controller.animateToPage(index, duration: Duration(milliseconds: 700), curve: Curves.elasticOut);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: (index == currentPage) ? 70 : 45,
                    width: (index == currentPage) ? 70 : 45,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Styles.infoColor,
                    ),
                    child:
                        // Transform.scale(
                        //     scale: 0.55, child: Image.asset(item['avatar'])),
                        Avatar(
                      name: item.name,
                      textStyle: TextStyle(
                          fontSize: getProportionateScreenWidth(16),
                          fontWeight: FontWeight.bold,
                          color: Styles.whiteColor),
                      // shape: AvatarShape(width: width, height: height, shapeBorder: shapeBorder)
                    )),
                const SizedBox(height: 10),
                (index == currentPage)
                    ? Text(item.name ?? '-',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16))
                    : const Text('')
              ],
            ),
          );
        },
      ),
    );
  }

  /*_indicators(theme) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(userList.length, (int index) {
          return InkWell(
            onTap: () {
              controller.animateToPage(index, duration: Duration(milliseconds: 700), curve: Curves.elasticOut);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: (index == currentPage) ? 60 : 40,
              width: (index == currentPage) ? 50 : 40,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                  color: (index == currentPage) ? Styles.yellowColor:Colors.grey
              ),
            ),
          );
        }),
      ),
    );
  }*/
}
