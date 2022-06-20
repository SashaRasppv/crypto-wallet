// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crpt/ui/coin_manipulation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/api/get_currency_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// Available coins

  double bitcoin = 0.0;
  double solana = 0.0;
  double ethereum = 0.0;
  double monero = 0.0;
  double tether = 0.0;
  double litecoin = 0.0;
  double cardano = 0.0;

// Available coins

  @override
  // ignore: must_call_super
  void initState() {
    getCurrency();
  }

  // Functions

  getCurrency() async {
    bitcoin = await Provider.of<CurrencyProvider>(context, listen: false)
        .getCryptoCurrency('bitcoin');
    solana = await Provider.of<CurrencyProvider>(context, listen: false)
        .getCryptoCurrency('solana');
    ethereum = await Provider.of<CurrencyProvider>(context, listen: false)
        .getCryptoCurrency('ethereum');
    monero = await Provider.of<CurrencyProvider>(context, listen: false)
        .getCryptoCurrency('monero');
    tether = await Provider.of<CurrencyProvider>(context, listen: false)
        .getCryptoCurrency('tether');
    litecoin = await Provider.of<CurrencyProvider>(context, listen: false)
        .getCryptoCurrency('litecoin');
    cardano = await Provider.of<CurrencyProvider>(context, listen: false)
        .getCryptoCurrency('cardano');
    setState(() {});
  }

  getFinalResult(String cryptoName, double amount) {
    if (cryptoName == 'bitcoin') {
      return (bitcoin * amount).toStringAsFixed(2);
    } else if (cryptoName == 'solana') {
      return (solana * amount).toStringAsFixed(2);
    } else if (cryptoName == 'ethereum') {
      return (ethereum * amount).toStringAsFixed(2);
    } else if (cryptoName == 'monero') {
      return (monero * amount).toStringAsFixed(2);
    } else if (cryptoName == 'tether') {
      return (tether * amount).toStringAsFixed(2);
    } else if (cryptoName == 'litecoin') {
      return (litecoin * amount).toStringAsFixed(2);
    } else if (cryptoName == 'cardano') {
      return (cardano * amount).toStringAsFixed(2);
    }
  }

  // Functions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(183, 218, 206, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(183, 218, 206, 1),
        title: Text(
          'YOUR BALANCE',
          style: GoogleFonts.lexend(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color.fromRGBO(98, 87, 102, 1)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Coins").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show user's crypto balance

            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((coin) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Balance in crypto

                    Column(
                      children: [
                        Row(
                          children: [
                            Text(coin['Amount'].toString(),
                                style: GoogleFonts.oxygen(
                                    color: const Color.fromRGBO(98, 87, 102, 1),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('${coin.id}:',
                                style: GoogleFonts.oxygen(
                                    color: const Color.fromRGBO(98, 87, 102, 1),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),

                    // Balance in crypto

                    const SizedBox(
                      width: 30,
                    ),

                    // Balance in dollars

                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                                '${getFinalResult(coin.id.toLowerCase(), double.parse(coin['Amount'].toString()))}\$',
                                style: GoogleFonts.oxygen(
                                    color: const Color.fromRGBO(98, 87, 102, 1),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),

                    // Balance in dollars
                  ],
                );
              }).toList(),
            );

            // Show user's crypto balance
          },
        ),
      ),

      // Add button

      floatingActionButton: const AddButton(),

      // Add button
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: const Color.fromRGBO(135, 153, 166, 1),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const AddCoin()));
      },
      label: Text(
        'ADD',
        style: GoogleFonts.roboto(
            color: const Color.fromRGBO(216, 233, 207, 1),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
