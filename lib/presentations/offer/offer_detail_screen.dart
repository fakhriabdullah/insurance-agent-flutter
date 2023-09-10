import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_agent_flutter/bloc/offer/get_offer_detail_cubit.dart';
import 'package:insurance_agent_flutter/presentations/offer/widgets/item_detail.dart';
import 'package:insurance_agent_flutter/util/date_parser.dart';
import 'package:insurance_agent_flutter/util/double_extension.dart';

class OfferDetailScreen extends StatelessWidget {
  final int? id;
  const OfferDetailScreen(this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: BlocProvider(
        create: (context) => GetOfferDetailCubit()..getOfferDetail(id ?? 0),
        child: BlocBuilder<GetOfferDetailCubit, GetOfferDetailState>(
          builder: (context, state) {
            if (state is GetOfferError) {
              return const Center(
                child: Text("Terjadi Kesalahan"),
              );
            } else if (state is GetOfferLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetOfferLoaded) {
              return ListView(
                padding: const EdgeInsets.only(
                    top: 12, left: 12, right: 12, bottom: 60),
                children: [
                  Text(
                    "General Information",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemDetail(
                          title: "Nama Tertanggung",
                          desc: state.offers.name ?? "",
                        ),
                        ItemDetail(
                          title: "Periode Pertanggungan",
                          desc:
                              "${state.offers.startDate.formatDate(newPattern: "dd/MM/yyyy", oldPattern: "yyyy-MM-dd")} - ${state.offers.endDate.formatDate(newPattern: "dd/MM/yyyy", oldPattern: "yyyy-MM-dd")}",
                        ),
                        ItemDetail(
                          title: "Pertanggungan / Kendaraan",
                          desc: state.offers.coverageName ?? "",
                        ),
                        ItemDetail(
                          title: "Harga Pertanggungan",
                          desc: state.offers.coveragePrice.priceFormat(),
                          bottomMargin: 0,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Coverage Information",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemDetail(
                          title: "Jenis Pertanggungan",
                          desc: state.offers.coverageType == 1
                              ? "Comprehensive"
                              : "Total Loss Only",
                        ),
                        ItemDetail(
                          title: "Risiko Pertanggungan",
                          desc: state.offers.coverageRisk,
                          bottomMargin: 0,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Premium Calculation",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4, bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.offers.detail?.length ?? 0,
                      separatorBuilder: (context, index) {
                        return const Divider(color: Colors.black12);
                      },
                      itemBuilder: (context, index) {
                        var item = state.offers.detail?[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ItemDetail(
                              title: "Periode Pertanggungan",
                              desc:
                                  "${item?.startDate.formatDate(newPattern: "dd/MM/yyyy", oldPattern: "yyyy-MM-dd")} - ${item?.endDate.formatDate(newPattern: "dd/MM/yyyy", oldPattern: "yyyy-MM-dd")}",
                            ),
                            ListView(
                              primary: false,
                              shrinkWrap: true,
                              children: item?.premiumItem
                                      ?.map(
                                        (e) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.name ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                            ),
                                            Container(
                                                width: double.maxFinite,
                                                margin: const EdgeInsets.only(
                                                    top: 2, bottom: 6),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      e.premium.priceFormat(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      state.offers.coveragePrice
                                                              .priceFormat() +
                                                          " x " +
                                                          e.rate.toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium,
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      )
                                      .toList() ??
                                  [],
                            ),
                            const SizedBox(height: 4),
                            ItemDetail(
                              title: "Total Premi",
                              desc: item?.totalPremium?.priceFormat(),
                              bottomMargin: 0,
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
