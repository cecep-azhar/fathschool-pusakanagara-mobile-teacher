import 'package:flutter/material.dart';
import 'package:fath_school/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fath_school/presentation/home/bloc/get_mobile_notification/get_mobile_notification_bloc.dart';

class NotificationDetailPage extends StatefulWidget {
  final String notification_id;
  const NotificationDetailPage({super.key, required this.notification_id});

  @override
  State<NotificationDetailPage> createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  //init state
  @override
  void initState() {
    // get mobile notification
    context
        .read<GetMobileNotificationBloc>()
        .add(const GetMobileNotificationEvent.getMobileNotification());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/bg_color.png"),
            fit: BoxFit.fill,
          )),
        ),
        Scaffold(
          appBar: AppBar(
              // backgroundColor: Colors.transparent,
              title: const Text("Detail Notifikasi"),
              backgroundColor: Colors.transparent),
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 4))
                          ]),
                      width: double.infinity,
                      // height: 625.0,
                      child: BlocBuilder<GetMobileNotificationBloc,
                          GetMobileNotificationState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const SizedBox.shrink();
                            },
                            loading: () {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                            error: (message) {
                              return Center(child: Text(message));
                            },
                            loaded: (data) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  if (data[index].id.toString() !=
                                      widget.notification_id) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(
                                              vertical: 10.0, horizontal: 15.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${data[index].sendAt ?? ""} WIB',
                                              style: const TextStyle(
                                                  fontFamily: 'roboto',
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(
                                              vertical: 10.0, horizontal: 15.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              data[index].title ?? "",
                                              style: const TextStyle(
                                                  fontFamily: 'roboto',
                                                  fontSize: 25.0,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        const SpaceHeight(15),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 0, 15, 20),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              data[index].message ?? "",
                                              style: const TextStyle(
                                                  fontFamily: 'roboto',
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xff6A7D94)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  // return Padding(
                                  //   padding: const EdgeInsets.symmetric(vertical:7.0, horizontal:10.0),
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       borderRadius: BorderRadius.circular(6.0),
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //           color: Colors.grey.withOpacity(0.25),
                                  //           spreadRadius: 2,
                                  //           blurRadius: 4,
                                  //           offset: Offset(0, 4)
                                  //         )
                                  //       ]
                                  //     ),
                                  //     width: double.infinity,
                                  //     height: 100.0,
                                  //     child: InkWell(
                                  //       onTap: () {
                                  //         context.push(NotificationDetailPage(notification_id: data[index].id.toString()));
                                  //       },
                                  //       child: Column(
                                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //           children: [
                                  //             Padding(
                                  //               padding: EdgeInsetsDirectional.symmetric(vertical: 0.0, horizontal: 15.0),
                                  //               child: Align(
                                  //                 alignment: Alignment.centerLeft,
                                  //                 child: Text(
                                  //                   '${data[index].sendAt ?? ""} WIB',
                                  //                   style: TextStyle(
                                  //                     fontFamily: 'roboto',
                                  //                     fontSize: 25.0,
                                  //                     fontWeight: FontWeight.w900,
                                  //                     color: Colors.black
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Padding(
                                  //               padding: EdgeInsetsDirectional.symmetric(vertical: 0.0, horizontal: 15.0),
                                  //               child: Align(
                                  //                 alignment: Alignment.centerLeft,
                                  //                 child: Text(
                                  //                   data[index].message ?? "",
                                  //                   style: TextStyle(
                                  //                     fontFamily: 'roboto',
                                  //                     fontSize: 16.0,
                                  //                     fontWeight: FontWeight.normal,
                                  //                     color: Color(0xff6A7D94)
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //     ),
                                  //     ));
                                },
                              );
                            },
                          );
                        },
                      ),
                      // Column(
                      //       children: [
                      //         Padding(
                      //           padding: EdgeInsetsDirectional.symmetric(vertical: 10.0, horizontal: 15.0),
                      //           child: Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text(
                      //               "10:00 WIB",
                      //               style: TextStyle(
                      //                 fontFamily: 'roboto',
                      //                 fontSize: 25.0,
                      //                 fontWeight: FontWeight.w900,
                      //                 color: Colors.black
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: EdgeInsetsDirectional.symmetric(vertical: 10.0, horizontal: 15.0),
                      //           child: Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text(
                      //               "Masuk Kelas XI PPLG 3",
                      //               style: TextStyle(
                      //                 fontFamily: 'roboto',
                      //                 fontSize: 25.0,
                      //                 fontWeight: FontWeight.w900,
                      //                 color: Colors.black
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //         const SpaceHeight(15),
                      //         Padding(
                      //           padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                      //           child: Align(
                      //             alignment: Alignment.centerLeft,
                      //             child: Text(
                      //               "Jadwal masuk kelas XI PPLG 3 telah tiba. Anda dipersilahkan masuk ke kelas.",
                      //               style: TextStyle(
                      //                 fontFamily: 'roboto',
                      //                 fontSize: 18.0,
                      //                 fontWeight: FontWeight.normal,
                      //                 color: Color(0xff6A7D94)
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
