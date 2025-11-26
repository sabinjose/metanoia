// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Metanoia';

  @override
  String get homeTitle => 'Welcome';

  @override
  String get examineTitle => 'Examine';

  @override
  String get confessTitle => 'Confess';

  @override
  String get prayersTitle => 'Prayers';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get examinationTitle => 'Examination';

  @override
  String get commandment => 'Commandment';

  @override
  String get guideTitle => 'Guide';

  @override
  String get faqTitle => 'FAQ';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose your preferred language';

  @override
  String get theme => 'Theme';

  @override
  String get chooseTheme => 'Choose your preferred theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get reminders => 'Reminders';

  @override
  String get getReminded => 'Get reminded to go to confession';

  @override
  String get enableReminders => 'Enable Reminders';

  @override
  String get weekly => 'Weekly';

  @override
  String get biweekly => 'Bi-weekly';

  @override
  String get monthly => 'Monthly';

  @override
  String get quarterly => 'Quarterly';

  @override
  String get day => 'Day';

  @override
  String get time => 'Time';

  @override
  String get remindMe => 'Remind me';

  @override
  String get onTheDay => 'On the day';

  @override
  String daysBefore(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days before',
      one: '1 day before',
    );
    return '$_temp0';
  }

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get lastConfession => 'Last Confession';

  @override
  String get noneYet => 'None yet';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '1 day ago',
    );
    return '$_temp0';
  }

  @override
  String get nextReminder => 'Next Reminder';

  @override
  String get off => 'Off';

  @override
  String get mon => 'Mon';

  @override
  String get tue => 'Tue';

  @override
  String get wed => 'Wed';

  @override
  String get thu => 'Thu';

  @override
  String get fri => 'Fri';

  @override
  String get sat => 'Sat';

  @override
  String get sun => 'Sun';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get appLanguage => 'App Language';

  @override
  String get appLanguageSubtitle => 'Language for buttons, labels, and menus';

  @override
  String get contentLanguage => 'Content Language';

  @override
  String get contentLanguageSubtitle => 'Language for examination questions, FAQs, and prayers';

  @override
  String get version => 'Version';

  @override
  String get selectDay => 'Select Day';

  @override
  String selected(Object count) {
    return '$count selected';
  }

  @override
  String get searchPlaceholder => 'Search commandments or questions...';

  @override
  String get noResults => 'No results found';

  @override
  String get viewHistory => 'View History';

  @override
  String get noActiveConfession => 'No active confession';

  @override
  String get startExaminationPrompt => 'Start an examination to add sins here.';

  @override
  String get startExamination => 'Start Examination';

  @override
  String get finishConfessionTitle => 'Finish Confession?';

  @override
  String get finishConfessionContent => 'This will mark the confession as completed and move it to your history.';

  @override
  String get cancel => 'Cancel';

  @override
  String get finish => 'Finish';

  @override
  String get confessionCompletedMessage => 'Confession completed! God bless you.';

  @override
  String get finishConfession => 'Finish Confession';

  @override
  String get error => 'Error';

  @override
  String get keepHistory => 'Keep Confession History';

  @override
  String get keepHistorySubtitle => 'Save your sins along with the date. If disabled, only the date will be saved.';

  @override
  String get deleteConfession => 'Delete Confession';

  @override
  String get deleteConfessionContent => 'Are you sure you want to delete this confession? This action cannot be undone.';

  @override
  String get tutorialExamineDesc => 'Start here to examine your conscience before confession.';

  @override
  String get tutorialConfessDesc => 'Use this during confession to track your sins.';

  @override
  String get tutorialPrayersDesc => 'Find common prayers for before and after confession.';

  @override
  String get tutorialGuideDesc => 'Read the guide and FAQs to learn more.';

  @override
  String get tutorialSearchDesc => 'Search for specific sins or commandments.';

  @override
  String get tutorialFinishDesc => 'Tap here when you are ready to confess.';

  @override
  String get replayTutorial => 'Replay Tutorial';

  @override
  String get replayTutorialDesc => 'View the app tutorial again';

  @override
  String get about => 'About';

  @override
  String get aboutSubtitle => 'Version, license, and source code';

  @override
  String get shareApp => 'Share App';

  @override
  String get shareAppSubtitle => 'Share with friends and family';

  @override
  String get rateApp => 'Rate App';

  @override
  String get rateAppSubtitle => 'Rate us on the Play Store';

  @override
  String get sourceCode => 'Source Code';

  @override
  String get viewOnGithub => 'View on GitHub';

  @override
  String get madeWithLove => 'Made with ❤️ by Sabin';

  @override
  String get rateDialogTitle => 'Enjoying Metanoia?';

  @override
  String get rateDialogContent => 'If you find this app helpful, please take a moment to rate it. It helps us a lot!';

  @override
  String get rateDialogYes => 'Rate Now';

  @override
  String get rateDialogNo => 'No, thanks';

  @override
  String get rateDialogLater => 'Remind me later';

  @override
  String get greekLabel => 'Greek';

  @override
  String get nounLabel => 'noun';

  @override
  String get metanoiaDefinition => 'A profound change of mind and heart; a spiritual awakening that transforms one\'s entire being and redirects their life toward God.';

  @override
  String get turnBackToGrace => 'Turn Back to Grace';

  @override
  String get welcomeSubtitle => 'Your guide for a meaningful confession';

  @override
  String get getStarted => 'Get Started';

  @override
  String get chooseContentLanguage => 'Choose Content Language';

  @override
  String get contentLanguageDescription => 'Select language for prayers, conscience examination, and guides';

  @override
  String get changeAnytimeNote => 'You can change this anytime in Settings';

  @override
  String get continueButton => 'Continue';

  @override
  String get examineDescription => 'Examine your conscience using the Ten Commandments before confession';

  @override
  String get confessDescription => 'Track your sins during confession to ensure nothing is forgotten';

  @override
  String get prayersDescription => 'Access prayers for before and after confession, and penance prayers';

  @override
  String get remindersDescription => 'Set regular reminders in Settings so you never forget to go to confession';

  @override
  String get nextButton => 'Next';
}
