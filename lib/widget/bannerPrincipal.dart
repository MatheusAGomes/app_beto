import 'package:flutter/material.dart';

import '../service/ColorSevice.dart';

class BannerPrincipal extends StatelessWidget {
  const BannerPrincipal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      height: MediaQuery.of(context).size.height * 0.265,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estrelas',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorService.cinza),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: ColorService.roxo,
                              child: Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '20',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Concluídas',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorService.cinza),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: ColorService.roxo,
                              child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '20',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Streak',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorService.cinza),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 7),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: ColorService.roxo,
                              child: Icon(
                                Icons.local_fire_department,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '20',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Image.asset('assets/images/compartilhar.png'),
          )
        ],
      ),
    );
  }
}
