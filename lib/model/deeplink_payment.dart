
class DeeplinkPayment {
  String authority;
  String scheme;
  String returnScheme;
  Map<String, dynamic>? queryParameters;

  DeeplinkPayment(
      {required this.authority,
      required this.scheme,
      required this.returnScheme,
      required this.queryParameters});

  ///## Gerar Uri de deeplink com a Stone
  ///### Todas as informações podem ser encontradas na documentação da Stone: <br>
  ///https://sdkandroid.stone.com.br/reference/pagamento-deeplink
  factory DeeplinkPayment.build(
      {required String authority,
      required String scheme,
      required String returnScheme,
      int? amount,
      bool? editableAmount,
      TransactionType? transactionType,
      InstallmentType? installmentType,
      int? installmentCount,
      int? orderId}) {
    Map<String, dynamic> parameters = {};

    parameters['return_scheme'] = returnScheme;

    if (amount != null) {
      parameters['amount'] = amount.toString();
    }

    if (editableAmount != null) {
      parameters['editable_amount'] = editableAmount ? "1" : "0";
    }

    if (transactionType != null) {
      parameters['transaction_type'] = transactionType.value;
    }

    if (installmentType != null) {
      parameters['installment_type'] = installmentType.value;
    }

    if (installmentCount != null) {
      parameters['installment_count'] = installmentCount.toString();
    }

    if (orderId != null) {
      parameters['order_id'] = orderId.toString();
    }

    return DeeplinkPayment(
        authority: authority,
        scheme: scheme,
        returnScheme: returnScheme,
        queryParameters: parameters);
  }

  String getUri() {
    return Uri(
            scheme: scheme, host: authority, queryParameters: queryParameters)
        .toString();
  }
}

enum TransactionType {
  debit(value: "DEBIT"),
  credit(value: "CREDIT"),
  voucher(value: "VOUCHER"),
  instantPayment(value: "INSTANT_PAYMENT"),
  pix(value: "PIX");

  const TransactionType({required this.value});

  final String value;
}

enum InstallmentType {
  merchant(value: "MERCHANT", description: "parcelado sem juros"),
  issuer(value: "ISSUER", description: "parcelado com juros"),
  none(value: "NONE", description: "à vista");

  const InstallmentType({required this.value, required this.description});

  final String value;
  final String description;
}
