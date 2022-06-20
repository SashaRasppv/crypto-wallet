import 'package:crpt/coin_data/coin_data.dart';
import 'package:crpt/ui/coin_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../net/add_coin.dart';

class AddCoin extends StatefulWidget {
  const AddCoin({Key? key}) : super(key: key);

  @override
  State<AddCoin> createState() => _AddCoinState();
}

class _AddCoinState extends State<AddCoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(183, 218, 206, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(183, 218, 206, 1),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 50),
        child: AllCryptoCoins(),
      ),
    );
  }
}

// -------------

class AllCryptoCoins extends StatelessWidget {
  const AllCryptoCoins({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: allCoins.length,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(135, 153, 166, 1),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20),
                  child: Row(
                    children: [
                      // Coin title

                      Expanded(
                          child: Text(
                        allCoins[index],
                        style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(216, 233, 207, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 32),
                      )),

                      // Coin title

                      // -------------

                      // Add button

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(183, 218, 206, 1)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CoinDetails(
                                        coinTitle: allCoins[index],
                                        coinDecription:
                                            coinsDescriprions[index],
                                        coinAbbraviation:
                                            coinsAbbreviation[index],
                                      )),
                            );
                          },
                          child: Text(
                            'ADD',
                            style: GoogleFonts.roboto(
                                color: const Color.fromRGBO(135, 153, 166, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),

                      // Add button
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ],
          );
        }));
  }
}
