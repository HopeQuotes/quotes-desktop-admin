import 'package:admin/domain/models/response/quote_response.dart';
import 'package:admin/domain/models/response/quote_state_response.dart';
import 'package:admin/domain/models/ui/quote.dart';

extension QuoteResponseToUiMapper on QuoteResponse {
  Quote toUi() {
    return Quote(
        id, state.toUi(), author, text, hashtags.map((e) => e.value).toList());
  }
}

extension StateMapper on QuoteStateResponse {
  QuoteState toUi() {
    return QuoteState(id: id, value: value, idDefault: idDefault, color: color);
  }
}
