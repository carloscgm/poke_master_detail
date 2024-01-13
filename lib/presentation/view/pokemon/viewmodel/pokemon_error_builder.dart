import 'package:poke_master_detail/model/exception/http_exception.dart';
import 'package:poke_master_detail/presentation/common/errorhandling/app_action.dart';
import 'package:poke_master_detail/presentation/common/errorhandling/app_error.dart';
import 'package:poke_master_detail/presentation/common/errorhandling/base/error_bundle.dart';
import 'package:poke_master_detail/presentation/common/errorhandling/base/error_bundle_builder.dart';

class PokemonErrorBuilder extends ErrorBundleBuilder {
  PokemonErrorBuilder.create(Exception exception, AppAction appAction)
      : super.create(exception, appAction);

  @override
  ErrorBundle handle(HTTPException exception, AppAction appAction) {
    AppError appError = AppError.UNKNOWN;

    switch (exception.statusCode) {
      case 500:
        appError = AppError.SERVER;
        break;
    }

    return ErrorBundle(exception, appAction, appError);
  }
}
