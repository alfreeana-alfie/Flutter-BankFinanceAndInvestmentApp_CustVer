import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/admin/faq_methods.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/utils/api.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateFaq extends StatefulWidget {
  const CreateFaq({Key? key}) : super(key: key);

  @override
  _CreateFaqState createState() => _CreateFaqState();
}

class _CreateFaqState extends State<CreateFaq> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  String? answer, question;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.createFaq, implyLeading: true, context: context),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    NewField(
                        mandatory: true,
                        onSaved: (val) => question = val,
                        hintText: Str.question,
                        ),
                    const Gap(20),
                    NewField(
                        mandatory: true,
                        onSaved: (val) => answer = val,
                        hintText: Str.answer),
                  const Gap(10),
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
                    child: RoundedLoadingButton(
                      controller: _,
                      color: Styles.secondaryColor,
                      onPressed: () {
                        Map<String, String> body = {
                          Field.question: question ?? Field.emptyString,
                          Field.answer: answer ?? Field.emptyString,
                          Field.locale: Status.english,
                          Field.status: Status.pending.toString()
                        };

                        // FaqMethods.add(context, body);
                        Method.add(
                            context,
                            _btnController,
                            body,
                            AdminAPI.createDeposit,
                            Type.deposit,
                            RouteSTR.createDeposit,
                            Str.depositList);
                      },
                      child: Text(Str.submit.toUpperCase()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
