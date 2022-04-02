import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/widgets/secondary_widgets/colors.dart';
import 'package:todolist/widgets/secondary_widgets/text_style.dart';

class SettingsPageWidget extends StatelessWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: dWhiteColor,
      body: _SettingsPageWidgetBody(),
    );
  }
}

class _SettingsPageWidgetBody extends StatelessWidget {
  const _SettingsPageWidgetBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Тебе нахер настройки нужны?',
      style: textStyleForSettings,
    ));
  }
}
// Container(
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: 200,
//             decoration: const BoxDecoration(
//               color: dDarkColor,
//               borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(16),
//                   bottomLeft: Radius.circular(16)),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(top: 32),
//               child: Container(
//                 child: Row(
//                   children: <Widget>[
//                     const Expanded(
//                         flex: 3,
//                         child: Padding(
//                           padding: EdgeInsets.all(16.0),
//                           child: Text(
//                             'Hello,\nLatrygin Arseniy!',
//                             style: TextStyle(
//                                 fontFamily: 'YandexSansBold',
//                                 fontSize: 32,
//                                 color: dWhiteColor),
//                           ),
//                         )),
//                     Expanded(
//                       flex: 1,
//                       child: CircleAvatar(
//                         backgroundColor: dLightBlueColor,
//                         radius: 35,
//                         child: CircleAvatar(
//                           backgroundColor: dDarkColor,
//                           radius: 33,
//                           child: CircleAvatar(
//                             radius: 30,
//                             child: Image.asset("assets/image/icon.png"),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             child: Row(
//               children: const <Widget>[
//                 Icon(CupertinoIcons.person_alt_circle),
//                 Text('Settings'),
//               ],
//             ),
//           )
//         ],
//       ),
//     );