import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_agent_flutter/bloc/offer/get_offer_cubit.dart';
import 'package:insurance_agent_flutter/presentations/offer/offer_detail_screen.dart';
import 'package:insurance_agent_flutter/util/double_extension.dart';

class HistoryOfferScreen extends StatelessWidget {
  const HistoryOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Penawaran"),
      ),
      body: BlocProvider(
        create: (context) => GetOfferCubit(),
        child: BlocBuilder<GetOfferCubit, GetOfferState>(
          builder: (context, state) {
            if (state is GetOfferLoadingFirst) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetOfferLoaded) {
              if (state.offers.isEmpty) {
                return const Center(
                  child: Text("Data tidak ditemukan"),
                );
              } else {
                return NotificationListener<ScrollNotification>(
                  onNotification: (scrollnotification) {
                    if (scrollnotification is ScrollEndNotification) {
                      if (scrollnotification.metrics.atEdge) {
                        if (scrollnotification.metrics.pixels != 0) {
                          context.read<GetOfferCubit>().getOfferNext();
                        }
                      }
                    }
                    return true;
                  },
                  child: ListView.separated(
                    physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OfferDetailScreen(
                                    state.offers[index].id ?? 0),
                              ),
                            );
                          },
                          title: Text(state.offers[index].name ?? ""),
                          subtitle: Text(
                              "Total Premi : ${state.offers[index].premium?.priceFormat() ?? ""}"),
                          trailing: const Icon(Icons.chevron_right),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                          color: Colors.black26,
                        );
                      },
                      itemCount: state.offers.length),
                );
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
