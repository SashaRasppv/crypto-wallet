import 'package:crpt/coin_data/coin_data.dart';
import 'package:crpt/provider/firebase_database/provider_firebase.dart';
import 'package:crpt/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CoinDetails extends StatefulWidget {
  const CoinDetails(
      {super.key,
      required this.coinTitle,
      required this.coinDecription,
      required this.coinAbbraviation});

  final String coinTitle;
  final String coinDecription;
  final String coinAbbraviation;

  @override
  State<CoinDetails> createState() => _CoinDetailsState();
}

// Main part

class _CoinDetailsState extends State<CoinDetails> {
  double coinBalance = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(183, 218, 206, 1),
      ),
      backgroundColor: const Color.fromRGBO(183, 218, 206, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CoinTitle(widget: widget),

              const SizedBox(
                height: 45,
              ),

              CoinDescription(widget: widget),

              const SizedBox(
                height: 85,
              ),

              UserBalance(coinBalance: coinBalance, widget: widget),

              const SizedBox(
                height: 35,
              ),

              // Add/Remove buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                        primary: const Color.fromRGBO(135, 153, 166, 1)),
                    onPressed: () {
                      if (coinBalance > 0) {
                        coinBalance -= 1;
                        setState(() {});
                      }
                    },
                    child: Text('-',
                        style: GoogleFonts.roboto(
                            color: const Color.fromRGBO(216, 233, 207, 1),
                            fontSize: 36)),
                  ),
                  const SizedBox(width: 100),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          primary: const Color.fromRGBO(135, 153, 166, 1)),
                      onPressed: () {
                        coinBalance += 1;
                        setState(() {});
                      },
                      child: Text('+',
                          style: GoogleFonts.roboto(
                              color: const Color.fromRGBO(216, 233, 207, 1),
                              fontSize: 36))),
                ],
              ),

              // Add/Remove buttons

              const SizedBox(
                height: 55,
              ),

              ConfirmButton(widget: widget, coinBalance: coinBalance)
            ],
          ),
        ),
      ),
    );
  }
}

// Main part

// -------------

// Confirm Button

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
    required this.widget,
    required this.coinBalance,
  }) : super(key: key);

  final CoinDetails widget;
  final double coinBalance;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: () {
            Provider.of<ProviderFirebase>(context, listen: false).addCoin(
                widget.coinTitle, double.parse(coinBalance.toString()));
            // addCoinToFirebase(widget.coinTitle, coinBalance);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
            primary: const Color.fromRGBO(98, 87, 102, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              'CONFIRM',
              style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(183, 218, 206, 1)),
            ),
          )),
    );
  }
}

// Confirm Button

// -------------

// User Balance

class UserBalance extends StatelessWidget {
  const UserBalance({
    Key? key,
    required this.coinBalance,
    required this.widget,
  }) : super(key: key);

  final double coinBalance;
  final CoinDetails widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'Your balance: $coinBalance${widget.coinAbbraviation}',
        style: GoogleFonts.roboto(
            color: const Color.fromRGBO(98, 87, 102, 1),
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

// User Balance

// -------------

// Coin Description

class CoinDescription extends StatelessWidget {
  const CoinDescription({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CoinDetails widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.coinDecription,
      style: GoogleFonts.roboto(
          color: const Color.fromRGBO(135, 153, 166, 1), fontSize: 24),
    );
  }
}

// Coin Description

// -------------

// Coin Title

class CoinTitle extends StatelessWidget {
  const CoinTitle({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CoinDetails widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.coinTitle,
      style: GoogleFonts.roboto(
          color: const Color.fromRGBO(98, 87, 102, 1),
          fontSize: 48,
          fontWeight: FontWeight.bold),
    );
  }
}

// Coin Title