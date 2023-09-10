import 'dart:developer';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_agent_flutter/bloc/offer/add_offer_cubit.dart';
import 'package:insurance_agent_flutter/bloc/offer/checkbox_coverage_cubit.dart';
import 'package:insurance_agent_flutter/bloc/offer/coverage_risk_cubit.dart';
import 'package:insurance_agent_flutter/model/offer/offer_detail.dart';
import 'package:insurance_agent_flutter/presentations/offer/offer_detail_screen.dart';
import 'package:insurance_agent_flutter/presentations/offer/widgets/coverage_risk.dart';
import 'package:insurance_agent_flutter/util/date_parser.dart';
import 'package:insurance_agent_flutter/util/my_utils.dart';
import 'package:intl/intl.dart';

class AddOfferScreen extends StatefulWidget {
  const AddOfferScreen({super.key});

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends State<AddOfferScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _dateStart = TextEditingController();
  final TextEditingController _dateEnd = TextEditingController();
  final TextEditingController _item = TextEditingController();
  final TextEditingController _price = MoneyMaskedTextController(
      decimalSeparator: '', thousandSeparator: '.', precision: 0);

  String selectedCoverageType = "Comprehensive";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Penawaran"),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CoverageRiskCubit(),
          ),
          BlocProvider(
            create: (context) => CheckboxCoverageCubit(),
          ),
          BlocProvider(
            create: (context) => AddOfferCubit(),
          ),
        ],
        child: BlocListener<AddOfferCubit, AddOfferState>(
          listener: (context, state) {
            if (state is AddOfferLoading) {
              AlertDialog alert = AlertDialog(
                content: Row(
                  children: [
                    const CircularProgressIndicator(),
                    Container(
                        margin: const EdgeInsets.only(left: 7, top: 12),
                        child: const Text("Loading...")),
                  ],
                ),
              );
              showDialog(
                  context: context,
                  builder: (context) => alert,
                  barrierDismissible: false);
            } else if (state is AddOfferSuccess) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => OfferDetailScreen(state.id),
                ),
              );
            } else if (state is AddOfferError) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  "Nama Nasabah",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                TextFormField(
                  keyboardType: TextInputType.name,
                  validator: MyUtils.validatorDefault(),
                  decoration:
                      const InputDecoration(hintText: "Masukan Nama Nasabah"),
                  controller: _name,
                ),
                const SizedBox(height: 12),
                Text(
                  "Periode Pertanggungan",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          var now = DateTime.now();
                          showDatePicker(
                                  context: context,
                                  initialDate: (_dateStart.text.isEmpty)
                                      ? DateTime.now()
                                      : DateFormat("dd/MM/yyyy")
                                          .parse(_dateStart.text),
                                  firstDate:
                                      DateTime(now.year, now.month, now.day),
                                  lastDate: DateTime(
                                      now.year + 5, now.month, now.day))
                              .then(
                            (value) {
                              if (value != null) {
                                String date =
                                    DateFormat("dd/MM/yyyy").format(value);
                                _dateStart.text = date;
                              }
                            },
                          );
                        },
                        validator: MyUtils.validatorDefault(),
                        decoration: const InputDecoration(
                          hintText: "Tanggal Mulai",
                        ),
                        controller: _dateStart,
                      ),
                    ),
                    const SizedBox(
                      width: 42,
                      child: Center(child: Text(" s/d ")),
                    ),
                    Expanded(
                      child: TextFormField(
                        onTap: () async {
                          var now = DateTime.now();
                          var firstDate =
                              DateTime(now.year, now.month, now.day);
                          if (_dateStart.text.isNotEmpty) {
                            try {
                              var temp = DateFormat("dd/MM/yyyy")
                                  .parse(_dateStart.text);
                              firstDate =
                                  DateTime(temp.year + 1, now.month, now.day);
                            } catch (e) {
                              log(e.toString());
                            }
                          }
                          showDatePicker(
                                  context: context,
                                  initialDate: (_dateEnd.text.isEmpty)
                                      ? firstDate
                                      : DateFormat("dd/MM/yyyy")
                                          .parse(_dateEnd.text),
                                  firstDate: firstDate,
                                  lastDate: DateTime(firstDate.year + 10,
                                      firstDate.month, firstDate.day))
                              .then(
                            (value) {
                              String date =
                                  DateFormat("dd/MM/yyyy").format(value!);
                              _dateEnd.text = date;
                            },
                          );
                        },
                        validator: MyUtils.validatorDefault(),
                        decoration:
                            const InputDecoration(hintText: "Tanggal Akhir"),
                        controller: _dateEnd,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "Pertanggungan / Kendaraan",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: MyUtils.validatorDefault(),
                  decoration: const InputDecoration(
                      hintText: "Masukan pertanggungan / kendaran"),
                  controller: _item,
                ),
                const SizedBox(height: 12),
                Text(
                  "Harga Pertanggungan",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: false,
                  ),
                  validator: MyUtils.validatorDefault(),
                  decoration: const InputDecoration(
                      hintText: "Masukan harga pertanggungan",
                      prefixText: "Rp "),
                  controller: _price,
                ),
                const SizedBox(height: 12),
                Text(
                  "Jenis Pertanggungan",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<String?>(
                  value: selectedCoverageType,
                  items: ["Comprehensive", "Total Loss Only"]
                      .map((e) =>
                          DropdownMenuItem<String?>(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    selectedCoverageType = value ?? "";
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  "Risiko Pertanggungan",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                const CoverageRisk(),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        var params = {
                          "name": _name.text,
                          "start_date": _dateStart.text.formatDate(
                              newPattern: "yyyy-MM-dd",
                              oldPattern: "dd/MM/yyyy"),
                          "end_date": _dateEnd.text.formatDate(
                              newPattern: "yyyy-MM-dd",
                              oldPattern: "dd/MM/yyyy"),
                          "coverage_name": _item.text,
                          "coverage_price": _price.text.replaceAll(".", ""),
                          "coverage_type":
                              (selectedCoverageType == "Comprehensive") ? 1 : 2,
                        };
                        var ids = context
                            .read<CheckboxCoverageCubit>()
                            .state
                            .checkboxIds;
                        params['coverage_risk'] = ids;
                        context.read<AddOfferCubit>().addOffer(params);
                      }
                    },
                    child: const Text("Simpan"),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
