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
  String? signatureLink; // Store signature image
  String? videoLink; // Store signature image

  // Card Data
  CartCubit() : super(const CartState.initial());

  void changeLength(int newLength) async {
    cartItems = newLength;
    emit(CartState.changeLength(cartItems));
  }

  void setSelectedCard(int index, {bool shouldEmit = true}) {
    selectedCardIndex = index;
    if (shouldEmit) {
      emit(CartState.changeSelectedCardIndex(index));
    }
  }

  void setMessageData({
    required String to,
    required String message,
    required String from,
    bool shouldEmit = true,
  }) {
    this.to = to;
    this.message = message;
    this.from = from;

    // Update controller values without triggering additional notifications
    if (toController.text != to) {
      toController.text = to;
    }
    if (messageController.text != message) {
      messageController.text = message;
    }
    if (fromController.text != from) {
      fromController.text = from;
    }

    // Only emit state when explicitly requested (not during normal typing)
    if (shouldEmit) {
      log("Emitting message state change - to: $to, message: $message, from: $from");
      emit(CartState.changeSelectedMessage(to, message, from));
    }
  }

  void setSignature({required Uint8List? signature}) {
    this.signature = signature;
    emit(
      CartState.changeSignature(signature),
    );
  }

  void setSignatureLink({required String? signatureLink}) {
    this.signatureLink = signatureLink;
    emit(
      CartState.changeSignatureLink(signatureLink),
    );
  }

  void setVideoLink({required String? videoLink}) {
    this.videoLink = videoLink;
    emit(
      CartState.changeVideoLink(videoLink),
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
