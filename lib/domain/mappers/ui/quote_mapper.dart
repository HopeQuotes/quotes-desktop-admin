import 'package:admin/domain/models/response/quote_response.dart';
import 'package:admin/domain/models/ui/quote.dart';

extension QuoteResponseToUiMapper on QuoteResponse {
  Quote toUi() {
    return Quote(
        id, state.value, author, text, hashtags.map((e) => e.value).toList());
  }
}
