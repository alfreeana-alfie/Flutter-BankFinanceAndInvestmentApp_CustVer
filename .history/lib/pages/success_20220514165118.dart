import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
          title: Str.upgrade, implyLeading: true, context: context),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          FutureBuilder(
            future: getView(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Styles.accentColor,
                  ),
                );
              } else {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NewField(
                      readOnly: true,
                      initialValue: 'Not yet Subcribe any Membership Plan!',
                      onSaved: (val) => currentMembershipName = val,
                      hintText: Str.currentMembership,
                      // labelText: Str.amountNum,
                    ),
                  );
                } else {
                  if (currentMembershipName == null) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewField(
                        readOnly: true,
                        initialValue: 'No Membership Plan subcribed yet!',
                        onSaved: (val) => currentMembershipName = val,
                        hintText: Str.currentMembership,
                        // labelText: Str.amountNum,
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: NewField(
                      readOnly: true,
                      initialValue: currentMembershipName,
                      onSaved: (val) => membershipId = val,
                      hintText: Str.currentMembership,
                      // labelText: Str.amountNum,
                    ),
                  );
                }
              }
            },
          ),
          const Gap(20),
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(7, 0, 0, 10),
                        child: Text(Str.upgradeYourPlan,
                            style: Styles.primaryTitle),
                      ),
                      // const Padding(
                      //   padding: EdgeInsets.fromLTRB(7, 0, 0, 10),
                      //   child: Text(
                      //     '*',
                      //     style: TextStyle(color: Styles.dangerColor),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    child: DropDownMembershipPlan(
                      membershipPlan: membershipId,
                      membershipName: membershipName,
                      onChanged: (val) {
                        setState(
                          () {
                            membershipId = val!.id.toString();
                            membershipName = val.planName;
                            membershipFee = val.planFee;
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(10),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      color: Styles.primaryColor,
                    ),
                    // margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 10),
                    child: elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodsMenu(
                              id: id,
                              currentMembershipId: currentMembershipId,
                              membershipPlanId: membershipId ?? '',
                              membershipPlanName: membershipName,
                              fee: membershipFee,
                            ),
                          ),
                        );
                      },
                      text: Str.upgrade,
                    ),
                  ),
                  backButton(context),
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}