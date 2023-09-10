import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_agent_flutter/bloc/offer/checkbox_coverage_cubit.dart';
import 'package:insurance_agent_flutter/bloc/offer/coverage_risk_cubit.dart';

class CoverageRisk extends StatelessWidget {
  const CoverageRisk({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoverageRiskCubit, CoverageRiskState>(
      builder: (context, state) {
        if (state is CoverageRiskLoaded) {
          return ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemCount: state.coverageRisks.length,
            separatorBuilder: (contex, index) {
              return const SizedBox(height: 6);
            },
            itemBuilder: (context, index) {
              var data = state.coverageRisks[index];
              return BlocBuilder<CheckboxCoverageCubit, CheckboxCoverageState>(
                builder: (context, CheckboxCoverageState checkboxState) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: checkboxState.checkboxIds.contains(data.id),
                          onChanged: (value) {
                            if (value != null) {
                              if (value) {
                                context
                                    .read<CheckboxCoverageCubit>()
                                    .addChecked(data.id ?? "");
                              } else {
                                context
                                    .read<CheckboxCoverageCubit>()
                                    .removeChecked(data.id ?? "");
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(data.name ?? ""),
                      ),
                    ],
                  );
                },
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
