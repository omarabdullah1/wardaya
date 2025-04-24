import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.initial() = _Initial;
  const factory CartState.changeLength(int newLength) = ChangeLength;
  const factory CartState.changeSelectedCardIndex(int selectedCardIndex) =
      ChangeSelectedCardIndex;
  const factory CartState.changeSelectedMessage(
      String to, String message, String from) = ChangeSelectedMessage;
  const factory CartState.changeSignature(Uint8List? signature) =
      ChangeSignature;
  const factory CartState.changeSignatureLink(String? signatureLink) =
      ChangeSignatureLink;
  const factory CartState.changeVideoLink(String? videoLink) = ChangeVideoLink;
  const factory CartState.changeLink(String link) = ChangeLink;
  const factory CartState.changeSelectedTypingStyle(int index) =
      ChangeSelectedTypingStyle;
}
