import 'package:flutter/material.dart';
import 'package:flutter_banking_app/utils/layouts.dart';
import 'package:flutter_banking_app/utils/styles.dart';
import 'package:gap/gap.dart';

class BalanceBox extends StatelessWidget {
  const BalanceBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);
    
    return FittedBox(
      child: SizedBox(
        height: size.height * 0.23,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.67,
              padding: const EdgeInsets.fromLTRB(16, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(15)),
                color: Styles.accentColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(Assets.cardsVisaYellow,
                      width: 60, height: 50, fit: BoxFit.cover),
                  const Text('\$20,000.00',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white)),
                  const Gap(20),
                  Text('CARD NUMBER',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.5), fontSize: 12)),
                  const Gap(5),
                  const Text('3829 4820 4629 5025',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),
            Container(
              width: size.width * 0.27,
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 20),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(15)),
                color: Styles.yellowColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Styles.accentColor,
                    ),
                    child: const Icon(Icons.swipe_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const Spacer(),
                  const Text('VALID', style: TextStyle(fontSize: 12)),
                  const Gap(5),
                  const Text('05/22', style: TextStyle(fontSize: 15)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
