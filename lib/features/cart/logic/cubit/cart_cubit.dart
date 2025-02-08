import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  TextEditingController toController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  int cartItems = 1;
  int selectedTypingStyle = 0;
  int selectedCardIndex = 0;
  String to = '';
  String message = '';
  String from = '';
  Uint8List? signature; // Store signature image

  // Card Data
  List<Map<String, dynamic>> cards = [
    {
      'image': 'assets/images/cards/card1.png',
      'title': 'Floward Card',
      'price': 'Free',
      'currency': '',
    },
    {
      'image': 'assets/images/cards/card2.png',
      'title': 'You Complete Me',
      'price': '99',
      'currency': 'EGP',
    },
  ];

  CartCubit() : super(const CartState.initial());

  void changeLength(int newLength) async {
    cartItems = newLength;
    emit(CartState.changeLength(cartItems));
  }

  void setSelectedCard(int index) {
    selectedCardIndex = index;
    emit(CartState.changeSelectedCardIndex(index));
  }

  void setMessageData({
    required String to,
    required String message,
    required String from,
  }) {
    this.to = to;
    this.message = message;
    this.from = from;
    toController.text = to;
    messageController.text = message;
    fromController.text = from;

    log(to);
    log(message);
    log(from);
    emit(
      CartState.changeSelectedMessage(to, message, from),
    );
  }

  void setSignature({required Uint8List? signature}) {
    this.signature = signature;
    emit(
      CartState.changeSignature(signature),
    );
  }

  void setLink({required String link}) {
    linkController.text = link;
    emit(
      CartState.changeLink(link),
    );
  }

  void setSelectingType(int index) {
    selectedTypingStyle = index;
    emit(CartState.changeSelectedTypingStyle(index));
  }
}
