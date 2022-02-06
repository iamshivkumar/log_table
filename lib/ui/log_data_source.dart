import 'package:flutter/material.dart';
import 'package:log_table/models/log_data.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class LogDataSource extends DataGridSource {
  LogDataSource({required List<List<LogData>> data}) {
    _data = data
        .map<DataGridRow>((e) => DataGridRow(
            cells: e
                .map((d) => DataGridCell(value: d, columnName: d.columnName))
                .toList()))
        .toList();
  }
  List<DataGridRow> _data = [];
  @override
  List<DataGridRow> get rows => _data;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      final LogData logData = dataGridCell.value as LogData;
      return Builder(builder: (context) {
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;
        return Material(
          color: logData.isMean
              ? (logData.columnSelected && logData.rowSelected
                  ? theme.highlightColor
                  : (logData.columnSelected
                      ? scheme.secondary
                      : logData.rowSelected
                          ? theme.shadowColor
                          : scheme.background))
              : (logData.columnSelected && logData.rowSelected
                  ? theme.primaryColorDark
                  : (logData.columnSelected || logData.rowSelected
                      ? theme.primaryColor
                      : theme.cardColor)),
          child: InkWell(
            onTap: logData.onTap,
            child: Center(child: logData.bar? RichText(text: TextSpan(
              text: logData.label.split('.').first,
              children: [
                TextSpan(
                  text: ".${logData.label.split('.').last}",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                  )
                ),
              ],
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.overline,
                
              )
            )):Text(logData.label)),
          ),
        );
      });
    }).toList());
  }
}
