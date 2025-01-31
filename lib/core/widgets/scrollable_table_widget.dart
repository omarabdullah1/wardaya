import 'package:flutter/material.dart';

import '../theming/styles.dart';

class ScrollableTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final TextStyle? headingTextStyle;
  final double? columnSpacing;

  const ScrollableTable({
    super.key,
    required this.columns,
    required this.rows,
    this.headingTextStyle,
    this.columnSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: columns,
          rows: rows,
          dividerThickness: 1,
          showBottomBorder: false,
          headingTextStyle: headingTextStyle ?? TextStyles.font12MainBlueBold,
          columnSpacing: columnSpacing ?? 30.0,
        ),
      ),
    );
  }
}
