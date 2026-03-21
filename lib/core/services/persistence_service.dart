import 'package:docguard/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for handling persistent storage using SharedPreferences.
class PersistenceService {
  final SharedPreferences _prefs;

  PersistenceService(this._prefs);

  /// Gets the number of times the onboarding has been seen.
  int getOnboardingSeenCount() {
    return _prefs.getInt(AppConstants.onboardingSeenCountKey) ?? 0;
  }

  /// Increments the onboarding seen count.
  Future<void> incrementOnboardingSeenCount() async {
    final currentCount = getOnboardingSeenCount();
    await _prefs.setInt(AppConstants.onboardingSeenCountKey, currentCount + 1);
  }

  /// Checks if the onboarding should be shown (seen less than twice).
  bool shouldShowOnboarding() {
    return getOnboardingSeenCount() < 2;
  }
}
