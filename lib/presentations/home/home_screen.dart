import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_agent_flutter/bloc/home/get_user_cubit.dart';
import 'package:insurance_agent_flutter/presentations/login/login_screen.dart';
import 'package:insurance_agent_flutter/presentations/offer/add_offer_screen.dart';
import 'package:insurance_agent_flutter/presentations/offer/history_offer_screen.dart';
import 'package:insurance_agent_flutter/util/secure_storage_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            BlocProvider(
              create: (context) => GetUserCubit(),
              child: Container(
                padding: const EdgeInsets.all(16),
                constraints: const BoxConstraints(minHeight: 120),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/logo.png")),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.width / 8,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 121, 121, 121),
                          ),
                          child: const Icon(
                            Icons.person_3,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        BlocBuilder<GetUserCubit, GetUserState>(
                          builder: (context, state) {
                            return Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Selamat Datang",
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    state is GetUserLoaded
                                        ? state.user.name ?? ""
                                        : "",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        InkResponse(
                          onTap: () {
                            SecureStorageUtils.logout();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Icon(Icons.exit_to_app),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [BoxShadow(blurRadius: 4)]),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddOfferScreen()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 24, right: 24, top: 32),
                          padding: const EdgeInsets.all(12),
                          constraints: const BoxConstraints(minHeight: 100),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 254, 225, 150),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.edit_document,
                                size: 60,
                                color: Color.fromARGB(255, 255, 158, 2),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                  child: Text(
                                "Buat Penawaran",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                              ))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HistoryOfferScreen()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 24, right: 24, top: 32),
                          padding: const EdgeInsets.all(12),
                          constraints: const BoxConstraints(minHeight: 100),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 150, 212, 254),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.history,
                                size: 60,
                                color: Color.fromARGB(255, 54, 141, 199),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                  child: Text(
                                "Riwayat Penawaran",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87),
                              ))
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
