import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/log_cosines.dart';
import 'package:log_table/models/log_data.dart';
import 'package:log_table/ui/providers/log_cosines_view_model_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'log_data_source.dart';

class LogCosinesPage extends ConsumerWidget {
  const LogCosinesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;
    final model = ref.watch(logCosinesModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOG COSINES"),
        actions: [
          model.value.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          text: "${model.value.split(' = ').first} = ",
                          children: [
                            TextSpan(
                              text:
                                  "${model.value.split(' = ').last.split('.').first}",
                              style: TextStyle(
                                decoration: model.value
                                            .split(' = ')
                                            .last
                                            .split('.')
                                            .first !=
                                        '0'
                                    ? TextDecoration.overline
                                    : TextDecoration.none,
                              ),
                            ),
                            TextSpan(
                                text: ".${model.value.split('.').last}",
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                ),),
                          ],
                          style: TextStyle(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox()
        ],
      ),
      body: SfDataGrid(
        rowHeight: 32,
        frozenColumnsCount: 1,
        headerRowHeight: 56,
        source: LogDataSource(
          data: List.generate(
            90,
            (index) {
              final number = index;
              return [
                    LogData(
                      label: "$number",
                      value: number.toDouble(),
                      rowSelected: model.rowIndex == number,
                      columnSelected: false,
                      columnName: '',
                      onTap: () {
                        model.rowIndex = number;
                      },
                      isMean: false,
                    ),
                  ] +
                  List.generate(
                    10,
                    (rowIndex) {
                      final Log log =
                          LogCosines.logcosinCell(number, rowIndex / 10);
                      return LogData(
                        label: log.label,
                        value: log.value,
                        rowSelected: model.rowIndex == number,
                        columnSelected: model.logIndex == rowIndex,
                        columnName: "$rowIndex",
                        onTap: () {
                          model.logIndex = rowIndex;
                          model.rowIndex = number;
                        },
                        isMean: false,
                        bar: log.value.isInfinite || log.label.contains('0000')
                            ? false
                            : true,
                      );
                    },
                  ) +
                  List.generate(
                    5,
                    (rowIndex) {
                      final Mean log =
                          LogCosines.meanCell(number, rowIndex + 1);
                      return LogData(
                        label: log.label,
                        value: log.value,
                        rowSelected: model.rowIndex == number,
                        columnSelected: model.meanIndex == rowIndex + 1,
                        columnName: "$rowIndex",
                        onTap: () {
                          if (model.meanIndex == rowIndex + 1 &&
                              model.rowIndex == number) {
                            model.meanIndex = null;
                          } else {
                            model.meanIndex = rowIndex + 1;
                            model.rowIndex = number;
                          }
                        },
                        isMean: true,
                      );
                    },
                  );
            },
          ),
        ),
        columns: [
              GridColumn(
                minimumWidth: 48,
                maximumWidth: 48,
                columnName: '',
                label: const SizedBox(),
              ),
            ] +
            List.generate(
              10,
              (rowIndex) => GridColumn(
                columnName: rowIndex.toString(),
                label: Material(
                  color: model.logIndex == rowIndex
                      ? scheme.primaryContainer
                      : scheme.surface,
                  child: InkWell(
                    onTap: () {
                      model.logIndex = rowIndex;
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${rowIndex * 6}'",
                            style: style.bodyText1,
                          ),
                          Text(
                            "${rowIndex / 10}??",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ) +
            List.generate(
              5,
              (rowIndex) => GridColumn(
                columnName: "${rowIndex + 1}",
                label: Material(
                  color: model.meanIndex == rowIndex + 1
                      ? scheme.tertiaryContainer
                      : scheme.surface,
                  child: InkWell(
                    onTap: () {
                      if (model.meanIndex == rowIndex + 1) {
                        model.meanIndex = null;
                      } else {
                        model.meanIndex = rowIndex + 1;
                      }
                    },
                    child: Center(
                      child: Text(
                        "${rowIndex + 1}'",
                      ),
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
