import 'package:admin/domain/models/ui/id_value.dart';
import 'package:admin/domain/models/ui/quote.dart';

import '../../models/state/domain_result.dart';

abstract class QuoteRepository {
  Stream<DomainResult> createQuote(
      String author, String body, List<String> hashtags, String photoId);

  Stream<DomainResult> analyzeQuotesFile(String path, String splitBy);

  Stream<DomainResult> createQuotes(String author, List<IdValue> hashtags,
      String photoId, List<String> contents);

  Stream<DomainResult> getHashtags(int page);

  Stream<DomainResult> getImages();

  Stream<DomainResult> deleteQuote();

  Stream<DomainResult> getQuotes(int page);
}
