import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({ 
    required this.beginColorAlignment,
    required this.endColorAlignment,
    required this.colorList,
    required this.onPressed,
    required this.child,
    required this.margin,
  });

  final EdgeInsetsGeometry margin;
  final Alignment beginColorAlignment;
  final Alignment endColorAlignment;
  final List<Color> colorList;
  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: beginColorAlignment,
          end: endColorAlignment,
          colors: colorList
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}


// class GradientButton extends StatefulWidget {
//   const GradientButton({Key? key});

//   final EdgeInsetsGeometry margin;
//   final Alignment beginColorAlignment;
//   final Alignment endColorAlignment;
//   final List<Color> colorList;
//   final Function onPressed;
//   final Widget child;

//   @override
//   _GradientButtonState createState() => _GradientButtonState();
// }

// class _GradientButtonState extends State<GradientButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: margin,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: beginColorAlignment,
//           end: endColorAlignment,
//           colors: colorList
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ElevatedButton(
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(Colors.transparent),
//           shadowColor: MaterialStateProperty.all(Colors.transparent),
//         ),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }


  // Widget gradButton() {
  //   return Container(
  //     margin: marginField,
  //     decoration: BoxDecoration(
  //       gradient: const LinearGradient(
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //           colors: [greenSecondColor, greenFirstColor]),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: ElevatedButton(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all(Colors.transparent),
  //         shadowColor: MaterialStateProperty.all(Colors.transparent),
  //       ),
  //       onPressed: () {
  //         print(email);
  //         print(password);
  //         // if (_formKey.currentState.validate()) {
  //         //   login();
  //         // } else {
  //         //   ScaffoldMessenger.of(context)
  //         //       .showSnackBar(SnackBar(content: Text("Error!")));
  //         // }
  //       },
  //       child: const Text('LOGIN',
  //           style: TextStyle(fontSize: 18, fontFamily: 'Open Sans')),
  //     ),
  //   );
  // }