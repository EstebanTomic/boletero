import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';
import '../widgets/gridview.dart';
import '../widgets/listview.dart';

class TicketRegisterPage extends StatelessWidget {
  const TicketRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.black87,
          child: CardGridView(),
          // boletaCardView(),
        ));
  }
}
