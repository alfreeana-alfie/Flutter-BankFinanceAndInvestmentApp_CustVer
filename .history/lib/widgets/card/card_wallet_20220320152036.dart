import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_banking_app/models/wallet.dart';
import 'package:flutter_banking_app/pages/member/wallet/top_up.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/string.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CardWallet extends StatelessWidget {
  const CardWallet({Key? key, required this.userWallet}) : super(key: key);

  final Wallet userWallet;
  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    var currency = NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: FittedBox(
        child: SizedBox(
          height: size.height * 0.17,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.77,
                padding: const EdgeInsets.fromLTRB(16, 10, 0, 20),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(15)),
                  color: Styles.accentColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userWallet.description!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 22,
                            color: Colors.white)),
                    const Gap(5),
                    Text('NGN ${double.parse(userWallet.amount).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white)),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.17,
                // padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(15)),
                  color: Styles.thirdColor,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MTopUpWallet(
                                walletId: userWallet.id.toString(),
                                accountId: userWallet.accountId ?? '0',
                                walletBalance: userWallet.amount,
                              ),
                            ),
                          ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Styles.accentColor,
                        ),
                          child: const Icon(Icons.add,
                            color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
