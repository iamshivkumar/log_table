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

        final textColor = logData.isMean
            ? (logData.columnSelected && logData.rowSelected
                ? scheme.onSecondary
                : (logData.columnSelected
                    ? scheme.onTertiaryContainer
                    : logData.rowSelected
                        ? scheme.onSecondaryContainer
                        : scheme.onSurface))
            : (logData.columnSelected && logData.rowSelected
                ? scheme.onPrimary
                : (logData.columnSelected || logData.rowSelected
                    ? scheme.onPrimaryContainer
                    : scheme.onSurface));

        return Material(
          color: logData.isMean
              ? (logData.columnSelected && logData.rowSelected
                  ? Color.alphaBlend(scheme.tertiary.withOpacity(0.75),
                      scheme.secondary.withOpacity(0.75))
                  : (logData.columnSelected
                      ? scheme.tertiaryContainer
                      : logData.rowSelected
                          ? scheme.secondaryContainer
                          : scheme.surfaceVariant.withOpacity(0.33)))
              : (logData.columnSelected && logData.rowSelected
                  ? scheme.primary
                  : (logData.columnSelected || logData.rowSelected
                      ? scheme.primaryContainer
                      : scheme.surface)),
          child: InkWell(
            onTap: logData.onTap,
            child: Center(
              child: logData.bar
                  ? RichText(
                      text: TextSpan(
                        text: logData.label.split('.').first,
                        children: [
                          TextSpan(
                            text: ".${logData.label.split('.').last}",
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                        style: TextStyle(
                          color: textColor,
                          decoration: TextDecoration.overline,
                        ),
                      ),
                    )
                  : Text(
                      logData.label,
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
            ),
          ),
        );
      });
    }).toList());
  }
}
