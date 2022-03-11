import 'package:flutter/material.dart';
import 'package:flutter_banking_app/methods/config.dart';
import 'package:flutter_banking_app/models/user.dart';
import 'package:flutter_banking_app/models/wallet.dart';
import 'package:flutter_banking_app/utils/size_config.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:flutter_banking_app/utils/values.dart';
import 'package:flutter_banking_app/widgets/appbar/my_app_bar.dart';
import 'package:flutter_banking_app/widgets/buttons.dart';
import 'package:flutter_banking_app/widgets/textfield/new_text_field.dart';
import 'package:gap/gap.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  SharedPref sharedPref = SharedPref();
  User userLoad = User();
  Wallet wallet = Wallet();

  String? name, email, phone, branchId, emailVerifiedAt, smsVerifiedAt;
  String? membershipId;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      appBar: myAppBar(
        title: Str.editProfile,
        implyLeading: true,
        context: context,
      ),
      body: _innerContainer(),
    );
  }

  _innerContainer() {
    return ListView(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      constraints:
                          const BoxConstraints(minWidth: 20, maxWidth: 100),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            userLoad.profilePicture ?? Values.userDefaultImage),
                        // backgroundImage: AssetImage(Values.userPath),
                        minRadius: 10,
                        maxRadius: 50,
                      ),
                    ),
                    const Gap(20),
                    NewField(
                      read
                        initialValue: userLoad.memberId,
                        onSaved: (val) => membershipId = val,
                        hintText: Str.membershipId),
                    const Gap(20.0),
                    NewField(
                        initialValue: userLoad.name,
                        onSaved: (val) => name = val,
                        hintText: Str.name),
                    const Gap(20.0),
                    NewField(
                        initialValue: userLoad.email,
                        onSaved: (val) => email = val,
                        hintText: Str.email),
                    const Gap(20.0),
                    NewField(
                        initialValue:
                            '${userLoad.countryCode}-${userLoad.phone}',
                        onSaved: (val) => phone = val,
                        hintText: Str.phoneNumber),
                    const Gap(20.0),
                    // NewField(
                    //     initialValue: userLoad.branchId ?? 'Default',
                    //     onSaved: (val) => branchId = val,
                    //     hintText: Str.branch),
                    // const Gap(20.0),
                    elevatedButton(
                      color: Styles.secondaryColor,
                      context: context,
                      callback: () {},
                      text: Str.editProfile.toUpperCase(),
                    ),
                  ],
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ],
    );
  }
}
