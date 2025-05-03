class AppleLoginRequest {
  final String identityToken;

  AppleLoginRequest({
    required this.identityToken,
  });

  Map<String, dynamic> toJson() => {
        'id_token': identityToken,
      };
}
