import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ml.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ml')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Metanoia'**
  String get appTitle;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get homeTitle;

  /// No description provided for @examineTitle.
  ///
  /// In en, this message translates to:
  /// **'Examine'**
  String get examineTitle;

  /// No description provided for @confessTitle.
  ///
  /// In en, this message translates to:
  /// **'Confess'**
  String get confessTitle;

  /// No description provided for @prayersTitle.
  ///
  /// In en, this message translates to:
  /// **'Prayers'**
  String get prayersTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @examinationTitle.
  ///
  /// In en, this message translates to:
  /// **'Examination'**
  String get examinationTitle;

  /// No description provided for @commandment.
  ///
  /// In en, this message translates to:
  /// **'Commandment'**
  String get commandment;

  /// No description provided for @guideTitle.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get guideTitle;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get faqTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language'**
  String get chooseLanguage;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @chooseTheme.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme'**
  String get chooseTheme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @getReminded.
  ///
  /// In en, this message translates to:
  /// **'Get reminded to go to confession'**
  String get getReminded;

  /// No description provided for @enableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable Reminders'**
  String get enableReminders;

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @biweekly.
  ///
  /// In en, this message translates to:
  /// **'Bi-weekly'**
  String get biweekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @quarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get quarterly;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @remindMe.
  ///
  /// In en, this message translates to:
  /// **'Remind me'**
  String get remindMe;

  /// No description provided for @onTheDay.
  ///
  /// In en, this message translates to:
  /// **'On the day'**
  String get onTheDay;

  /// No description provided for @daysBefore.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day before} other{{count} days before}}'**
  String daysBefore(num count);

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @lastConfession.
  ///
  /// In en, this message translates to:
  /// **'Last Confession'**
  String get lastConfession;

  /// No description provided for @noneYet.
  ///
  /// In en, this message translates to:
  /// **'None yet'**
  String get noneYet;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day ago} other{{count} days ago}}'**
  String daysAgo(num count);

  /// No description provided for @nextReminder.
  ///
  /// In en, this message translates to:
  /// **'Next Reminder'**
  String get nextReminder;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get off;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get appLanguage;

  /// No description provided for @appLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Language for buttons, labels, and menus'**
  String get appLanguageSubtitle;

  /// No description provided for @contentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Content Language'**
  String get contentLanguage;

  /// No description provided for @contentLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Language for examination questions, FAQs, and prayers'**
  String get contentLanguageSubtitle;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @selectDay.
  ///
  /// In en, this message translates to:
  /// **'Select Day'**
  String get selectDay;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selected(Object count);

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Search commandments or questions...'**
  String get searchPlaceholder;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @viewHistory.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistory;

  /// No description provided for @noActiveConfession.
  ///
  /// In en, this message translates to:
  /// **'No active confession'**
  String get noActiveConfession;

  /// No description provided for @startExaminationPrompt.
  ///
  /// In en, this message translates to:
  /// **'Start an examination to add sins here.'**
  String get startExaminationPrompt;

  /// No description provided for @startExamination.
  ///
  /// In en, this message translates to:
  /// **'Start Examination'**
  String get startExamination;

  /// No description provided for @finishConfessionTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish Confession?'**
  String get finishConfessionTitle;

  /// No description provided for @finishConfessionContent.
  ///
  /// In en, this message translates to:
  /// **'This will mark the confession as completed and move it to your history.'**
  String get finishConfessionContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @confessionCompletedMessage.
  ///
  /// In en, this message translates to:
  /// **'Confession completed! God bless you.'**
  String get confessionCompletedMessage;

  /// No description provided for @finishConfession.
  ///
  /// In en, this message translates to:
  /// **'Finish Confession'**
  String get finishConfession;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @keepHistory.
  ///
  /// In en, this message translates to:
  /// **'Keep Confession History'**
  String get keepHistory;

  /// No description provided for @keepHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Save your sins along with the date. If disabled, only the date will be saved.'**
  String get keepHistorySubtitle;

  /// No description provided for @deleteConfession.
  ///
  /// In en, this message translates to:
  /// **'Delete Confession'**
  String get deleteConfession;

  /// No description provided for @deleteConfessionContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this confession? This action cannot be undone.'**
  String get deleteConfessionContent;

  /// No description provided for @tutorialExamineDesc.
  ///
  /// In en, this message translates to:
  /// **'Start here to examine your conscience before confession.'**
  String get tutorialExamineDesc;

  /// No description provided for @tutorialConfessDesc.
  ///
  /// In en, this message translates to:
  /// **'Use this during confession to track your sins.'**
  String get tutorialConfessDesc;

  /// No description provided for @tutorialPrayersDesc.
  ///
  /// In en, this message translates to:
  /// **'Find common prayers for before and after confession.'**
  String get tutorialPrayersDesc;

  /// No description provided for @tutorialGuideDesc.
  ///
  /// In en, this message translates to:
  /// **'Read the guide and FAQs to learn more.'**
  String get tutorialGuideDesc;

  /// No description provided for @tutorialSearchDesc.
  ///
  /// In en, this message translates to:
  /// **'Search for specific sins or commandments.'**
  String get tutorialSearchDesc;

  /// No description provided for @tutorialFinishDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap here when you are ready to confess.'**
  String get tutorialFinishDesc;

  /// No description provided for @replayTutorial.
  ///
  /// In en, this message translates to:
  /// **'Replay Tutorial'**
  String get replayTutorial;

  /// No description provided for @replayTutorialDesc.
  ///
  /// In en, this message translates to:
  /// **'View the app tutorial again'**
  String get replayTutorialDesc;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @aboutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Version, license, and source code'**
  String get aboutSubtitle;

  /// No description provided for @shareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get shareApp;

  /// No description provided for @shareAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share with friends and family'**
  String get shareAppSubtitle;

  /// No description provided for @rateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// No description provided for @rateAppSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rate us on the Play Store'**
  String get rateAppSubtitle;

  /// No description provided for @sourceCode.
  ///
  /// In en, this message translates to:
  /// **'Source Code'**
  String get sourceCode;

  /// No description provided for @viewOnGithub.
  ///
  /// In en, this message translates to:
  /// **'View on GitHub'**
  String get viewOnGithub;

  /// No description provided for @madeWithLove.
  ///
  /// In en, this message translates to:
  /// **'Made with ❤️ by Sabin'**
  String get madeWithLove;

  /// No description provided for @rateDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoying Metanoia?'**
  String get rateDialogTitle;

  /// No description provided for @rateDialogContent.
  ///
  /// In en, this message translates to:
  /// **'If you find this app helpful, please take a moment to rate it. It helps us a lot!'**
  String get rateDialogContent;

  /// No description provided for @rateDialogYes.
  ///
  /// In en, this message translates to:
  /// **'Rate Now'**
  String get rateDialogYes;

  /// No description provided for @rateDialogNo.
  ///
  /// In en, this message translates to:
  /// **'No, thanks'**
  String get rateDialogNo;

  /// No description provided for @rateDialogLater.
  ///
  /// In en, this message translates to:
  /// **'Remind me later'**
  String get rateDialogLater;

  /// No description provided for @greekLabel.
  ///
  /// In en, this message translates to:
  /// **'Greek'**
  String get greekLabel;

  /// No description provided for @nounLabel.
  ///
  /// In en, this message translates to:
  /// **'noun'**
  String get nounLabel;

  /// No description provided for @metanoiaDefinition.
  ///
  /// In en, this message translates to:
  /// **'A profound change of mind and heart; a spiritual awakening that transforms one\'s entire being and redirects their life toward God.'**
  String get metanoiaDefinition;

  /// No description provided for @turnBackToGrace.
  ///
  /// In en, this message translates to:
  /// **'Turn Back to Grace'**
  String get turnBackToGrace;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your guide for a meaningful confession'**
  String get welcomeSubtitle;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @chooseContentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Content Language'**
  String get chooseContentLanguage;

  /// No description provided for @contentLanguageDescription.
  ///
  /// In en, this message translates to:
  /// **'Select language for prayers, conscience examination, and guides'**
  String get contentLanguageDescription;

  /// No description provided for @changeAnytimeNote.
  ///
  /// In en, this message translates to:
  /// **'You can change this anytime in Settings'**
  String get changeAnytimeNote;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @examineDescription.
  ///
  /// In en, this message translates to:
  /// **'Examine your conscience using the Ten Commandments before confession'**
  String get examineDescription;

  /// No description provided for @confessDescription.
  ///
  /// In en, this message translates to:
  /// **'Track your sins during confession to ensure nothing is forgotten'**
  String get confessDescription;

  /// No description provided for @prayersDescription.
  ///
  /// In en, this message translates to:
  /// **'Access prayers for before and after confession, and penance prayers'**
  String get prayersDescription;

  /// No description provided for @remindersDescription.
  ///
  /// In en, this message translates to:
  /// **'Set regular reminders in Settings so you never forget to go to confession'**
  String get remindersDescription;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @customSins.
  ///
  /// In en, this message translates to:
  /// **'Custom Sins'**
  String get customSins;

  /// No description provided for @manageCustomSins.
  ///
  /// In en, this message translates to:
  /// **'Manage Custom Sins'**
  String get manageCustomSins;

  /// No description provided for @addCustomSin.
  ///
  /// In en, this message translates to:
  /// **'Add Custom Sin'**
  String get addCustomSin;

  /// No description provided for @editCustomSin.
  ///
  /// In en, this message translates to:
  /// **'Edit Custom Sin'**
  String get editCustomSin;

  /// No description provided for @deleteCustomSin.
  ///
  /// In en, this message translates to:
  /// **'Delete Custom Sin'**
  String get deleteCustomSin;

  /// No description provided for @sinDescription.
  ///
  /// In en, this message translates to:
  /// **'Sin Description'**
  String get sinDescription;

  /// No description provided for @sinDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the sin you want to remember'**
  String get sinDescriptionHint;

  /// No description provided for @sinDescriptionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a sin description'**
  String get sinDescriptionRequired;

  /// No description provided for @optionalNote.
  ///
  /// In en, this message translates to:
  /// **'Optional Note'**
  String get optionalNote;

  /// No description provided for @optionalNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Add any additional details'**
  String get optionalNoteHint;

  /// No description provided for @selectCommandment.
  ///
  /// In en, this message translates to:
  /// **'Select Commandment (Optional)'**
  String get selectCommandment;

  /// No description provided for @noCommandment.
  ///
  /// In en, this message translates to:
  /// **'General / No Commandment'**
  String get noCommandment;

  /// No description provided for @customSinAdded.
  ///
  /// In en, this message translates to:
  /// **'Custom sin added'**
  String get customSinAdded;

  /// No description provided for @customSinUpdated.
  ///
  /// In en, this message translates to:
  /// **'Custom sin updated'**
  String get customSinUpdated;

  /// No description provided for @customSinDeleted.
  ///
  /// In en, this message translates to:
  /// **'Custom sin deleted'**
  String get customSinDeleted;

  /// No description provided for @deleteCustomSinConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this custom sin?'**
  String get deleteCustomSinConfirm;

  /// No description provided for @noCustomSins.
  ///
  /// In en, this message translates to:
  /// **'No custom sins yet'**
  String get noCustomSins;

  /// No description provided for @noCustomSinsDesc.
  ///
  /// In en, this message translates to:
  /// **'Add custom sins to personalize your examination'**
  String get noCustomSinsDesc;

  /// No description provided for @customVersion.
  ///
  /// In en, this message translates to:
  /// **'Custom (Edited)'**
  String get customVersion;

  /// No description provided for @searchCustomSins.
  ///
  /// In en, this message translates to:
  /// **'Search custom sins...'**
  String get searchCustomSins;

  /// No description provided for @addButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @addYourOwn.
  ///
  /// In en, this message translates to:
  /// **'Add your own...'**
  String get addYourOwn;

  /// No description provided for @tutorialCustomSinDesc.
  ///
  /// In en, this message translates to:
  /// **'Tap here to add your own personal notes for this commandment.'**
  String get tutorialCustomSinDesc;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ml'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ml': return AppLocalizationsMl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
