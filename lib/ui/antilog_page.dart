import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:log_table/calculate.dart';
import 'package:log_table/models/log_data.dart';
import 'package:log_table/ui/log_data_source.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'providers/antilog_view_model_provider.dart';

class AntilogPage extends ConsumerWidget {
  const AntilogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final model = ref.watch(antilogViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANTILOGARITHMS'),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.value,
                ),
              ),
            ],
          )
        ],
      ),
      body: SfDataGrid(
        rowHeight: 32,
        frozenColumnsCount: 1,
        headerRowHeight: 40,
        source: LogDataSource(
          data: List.generate(
            100,
            (index) {
              final number = index;
              return [
                    LogData(
                        isMean: false,
                        label:
                            ".${(number / 100).toStringAsFixed(2).split('.').last}",
                        value: number / 10,
                        rowSelected: model.rowIndex == number,
                        columnSelected: false,
                        columnName: '',
                        onTap: () {
                          model.rowIndex = number;
                        }),
                  ] +
                  List.generate(
                    10,
                    (rowIndex) {
                      final Log log = Calculate.antiLogCell(number, rowIndex);
                      return LogData(
                        isMean: false,
                        label: log.label,
                        value: log.value,
                        rowSelected: model.rowIndex == number,
                        columnSelected: model.antilogIndex == rowIndex,
                        columnName: "$rowIndex",
                        onTap: () {
                          model.antilogIndex = rowIndex;
                          model.rowIndex = number;
                        },
                      );
                    },
                  ) +
                  List.generate(
                    9,
                    (rowIndex) {
                      final Mean log =
                          Calculate.meanACell(number, rowIndex + 1);
                      return LogData(
                        isMean: true,
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
                  color: model.antilogIndex == rowIndex
                      ? scheme.primaryContainer
                      : scheme.surface,
                  child: InkWell(
                    onTap: () {
                      model.antilogIndex = rowIndex;
                    },
                    child: Center(
                      child: Text(
                        "$rowIndex",
                      ),
                    ),
                  ),
                ),
              ),
            ) +
            List.generate(
              9,
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
                        "${rowIndex + 1}",
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
