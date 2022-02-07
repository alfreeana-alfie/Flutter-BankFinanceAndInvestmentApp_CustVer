import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_banking_app/methods/admin/navigation_methods.dart';
import 'package:flutter_banking_app/models/navigation_item.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/dropdown/dropdown_navigation.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:oktoast/oktoast.dart';
import 'package:toggle_switch/toggle_switch.dart';

class UpdateNavigationItem extends StatefulWidget {
  const UpdateNavigationItem({Key? key, required this.navigationItem})
      : super(key: key);

  final NavigationItem navigationItem;

  @override
  _UpdateNavigationItemState createState() => _UpdateNavigationItemState();
}

class _UpdateNavigationItemState extends State<UpdateNavigationItem> {
  final ScrollController _scrollController = ScrollController();

  String? navigation, navigationName, type, url, target;
  int? status;

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    // setState(() {
    //   navigation = widget.navigationItem.navigationId.toString();
    // });
    // navigationName = widget.navigationItem.name;

    return OKToast(
      child: Scaffold(
        backgroundColor: Styles.primaryColor,
        appBar: myAppBar(
            title: Str.updateNavigationItemTxt,
            implyLeading: true,
            context: context),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Styles.cardColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child: Text(Str.navigationTxt,
                              style: Styles.primaryTitle),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child: Text(
                            '*',
                            style: TextStyle(color: Styles.dangerColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      child: DropDowNavigation(
                        // currentValue: widget.navigationItem.id,
                        navigation: navigation,
                        navigationName: navigationName,
                        onChanged: (val) {
                          setState(
                            () {
                              navigation = val!.id.toString();
                              navigationName = val.name;
                            },
                          );
                        },
                      ),
                    ),
                    const Gap(20),
                    NewField(
                        mandatory: true,
                        initialValue: widget.navigationItem.type,
                        onSaved: (val) => type = val,
                        hintText: Str.typeTxt),
                    const Gap(20),
                    NewField(
                        mandatory: true,
                        initialValue: widget.navigationItem.url,
                        onSaved: (val) => url = val,
                        hintText: Str.urlTxt),
                    const Gap(20),
                    NewField(
                        mandatory: true,
                        initialValue: widget.navigationItem.target,
                        onSaved: (val) => target = val,
                        hintText: Str.targetTxt),
                    const Gap(20),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child:
                              Text(Str.statusTxt, style: Styles.primaryTitle),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                          child: Text(
                            '*',
                            style: TextStyle(color: Styles.dangerColor),
                          ),
                        ),
                      ],
                    ),
                    ToggleSwitch(
                      initialLabelIndex: int.parse(widget.navigationItem.status!),
                      minWidth: 120,
                      cornerRadius: 7.0,
                      activeBgColors: const [
                        [Styles.dangerColor],
                        [Styles.successColor]
                      ],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.black12.withOpacity(0.05),
                      inactiveFgColor: Styles.textColor,
                      totalSwitches: 2,
                      labels: Field.statusList,
                      onToggle: (index) {
                        // print('switched to: $index');
                        status = index;
                      },
                    ),
                    const Gap(20),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Styles.primaryColor,
                      ),
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: elevatedButton(
                        color: Styles.secondaryColor,
                        context: context,
                        callback: () {
                          status ??= int.parse(widget.navigationItem.status!);
                          Map<String, String> body = {
                            Field.navigationId: navigation ??
                                widget.navigationItem.navigationId.toString(),
                            Field.type: type ??
                                widget.navigationItem.type ??
                                Field.empty,
                            Field.pageId: '1',
                            Field.url:
                                url ?? widget.navigationItem.url ?? Field.empty,
                            Field.icon:
                                widget.navigationItem.icon ?? Field.emptyString,
                            Field.target: target ??
                                widget.navigationItem.target ??
                                Field.empty,
                            Field.parentId:'1',
                            Field.position:'1',
                            Field.status: status.toString(),
                            Field.cssClass: widget.navigationItem.cssClass ??
                                Field.emptyString,
                            Field.cssId: widget.navigationItem.cssId ??
                                Field.emptyString,
                          };

                          NavigationMethods.editItem(context, body,
                              widget.navigationItem.id.toString());
                        },
                        text: Str.submitTxt.toUpperCase(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
