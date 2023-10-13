import 'package:flutter/material.dart';

import '../widgets/boletaCard.dart';
import '../widgets/gridview.dart';

class TicketRegisterPage extends StatelessWidget {
  const TicketRegisterPage({super.key});
    static const String routerName = 'TicketRegister';

  @override
  Widget build(BuildContext context) {


    return ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.black87,
          //child: CardGridView(),
          child: boletaCardView(),
          // boletaCardView(),
        ));
  }
}
