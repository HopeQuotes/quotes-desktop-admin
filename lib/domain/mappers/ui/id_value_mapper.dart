import 'package:admin/domain/models/id_value_data_response.dart';
import 'package:admin/domain/models/ui/id_value.dart';

extension IdValueResponseToUi on IdValueDataResponse {
  IdValue toUi() {
    return IdValue(id: id, value: value);
  }
}
