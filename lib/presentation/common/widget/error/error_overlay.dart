import 'package:flutter/material.dart';
import 'package:poke_master_detail/presentation/common/errorhandling/app_error.dart';
import 'package:poke_master_detail/presentation/common/errorhandling/base/error_bundle.dart';
import 'package:poke_master_detail/presentation/common/localization/app_localizations.dart';

class ErrorOverlay {
  BuildContext _context;

  ErrorOverlay._create(this._context);

  factory ErrorOverlay.of(BuildContext context) {
    return ErrorOverlay._create(context);
  }

  void show(ErrorBundle? error, {VoidCallback? onRetry}) {
    if (error == null) {
      return;
    }

    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.error_title),
            content: Text(_getErrorMessage(context, error.appError)), // Change
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.action_ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Visibility(
                visible: onRetry != null,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onRetry?.call();
                  },
                  child: Text(AppLocalizations.of(context)!.action_retry),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getErrorMessage(BuildContext context, AppError appError) {
    final locs = AppLocalizations.of(context)!;

    switch (appError) {
      case AppError.NO_INTERNET:
        return locs.error_no_internet;
      case AppError.TIMEOUT:
        return locs.error_timeout;
      case AppError.SERVER:
        return locs.error_server;
      default:
        return locs.error_default;
    }
  }
}
