import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class card_form extends StatefulWidget {
  const card_form({super.key});

  @override
  State<card_form> createState() => _card_formState();
}

class _card_formState extends State<card_form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Pay with Credit Card',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Card Form",
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 20,
            ),
            CardFormField(
              controller: CardFormEditController(),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Pay'))
          ],
        ),
      ),
    );
  }
}
