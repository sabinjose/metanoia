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
  String get selectedLabel => 'selected';

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

  @override
  String get customSins => 'Custom Sins';

  @override
  String get manageCustomSins => 'Manage Custom Sins';

  @override
  String get addCustomSin => 'Add Custom Sin';

  @override
  String get editCustomSin => 'Edit Custom Sin';

  @override
  String get deleteCustomSin => 'Delete Custom Sin';

  @override
  String get sinDescription => 'Sin Description';

  @override
  String get sinDescriptionHint => 'Describe the sin you want to remember';

  @override
  String get sinDescriptionRequired => 'Please enter a sin description';

  @override
  String get optionalNote => 'Optional Note';

  @override
  String get optionalNoteHint => 'Add any additional details';

  @override
  String get selectCommandment => 'Select Commandment (Optional)';

  @override
  String get noCommandment => 'General / No Commandment';

  @override
  String get customSinAdded => 'Custom sin added';

  @override
  String get customSinUpdated => 'Custom sin updated';

  @override
  String get customSinDeleted => 'Custom sin deleted';

  @override
  String get deleteCustomSinConfirm => 'Are you sure you want to delete this custom sin?';

  @override
  String get noCustomSins => 'No custom sins yet';

  @override
  String get noCustomSinsDesc => 'Add custom sins to personalize your examination';

  @override
  String get customVersion => 'Custom (Edited)';

  @override
  String get searchCustomSins => 'Search custom sins...';

  @override
  String get addButton => 'Add';

  @override
  String get updateButton => 'Update';

  @override
  String get deleteButton => 'Delete';

  @override
  String get addYourOwn => 'Add your own...';

  @override
  String get penance => 'Penance';

  @override
  String get penanceTracker => 'Penance Tracker';

  @override
  String get addPenance => 'Add Penance';

  @override
  String get editPenance => 'Edit Penance';

  @override
  String get penanceDescription => 'What penance were you given?';

  @override
  String get penanceHint => 'e.g., Say 3 Hail Marys, Read a Scripture passage...';

  @override
  String get penanceAdded => 'Penance added';

  @override
  String get penanceUpdated => 'Penance updated';

  @override
  String get penanceCompleted => 'Penance completed! God bless you.';

  @override
  String get markAsComplete => 'Mark as Complete';

  @override
  String get pendingPenances => 'Pending Penances';

  @override
  String get noPendingPenances => 'No pending penances';

  @override
  String get noPendingPenancesDesc => 'All your penances are completed. God bless!';

  @override
  String completedOn(Object date) {
    return 'Completed on $date';
  }

  @override
  String assignedOn(Object date) {
    return 'Assigned on $date';
  }

  @override
  String get skipPenance => 'Skip';

  @override
  String get savePenance => 'Save Penance';

  @override
  String get insights => 'Insights';

  @override
  String get confessionInsights => 'Confession Insights';

  @override
  String get totalConfessions => 'Total Confessions';

  @override
  String get averageFrequency => 'Average Frequency';

  @override
  String everyXDays(Object count) {
    return 'Every $count days';
  }

  @override
  String get daysSinceLastConfession => 'Days Since Last';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String weeksStreak(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks',
      one: '1 week',
    );
    return '$_temp0';
  }

  @override
  String get monthlyActivity => 'Monthly Activity';

  @override
  String get confessionsThisYear => 'Confessions This Year';

  @override
  String get noInsightsYet => 'No insights yet';

  @override
  String get noInsightsYetDesc => 'Complete your first confession to see your spiritual journey stats';

  @override
  String get totalItemsConfessed => 'Total Items Confessed';

  @override
  String get firstConfession => 'First Confession';

  @override
  String get spiritualJourney => 'Your Spiritual Journey';

  @override
  String get listView => 'List';

  @override
  String get guidedView => 'Guided';

  @override
  String commandmentProgress(Object current, Object total) {
    return '$current of $total';
  }

  @override
  String get previousCommandment => 'Previous';

  @override
  String get nextCommandment => 'Next';

  @override
  String get finishExamination => 'Finish';

  @override
  String get noQuestionsSelected => 'No questions selected in this section';

  @override
  String questionsSelectedInSection(Object count) {
    return '$count selected';
  }

  @override
  String get examinationSummary => 'Examination Summary';

  @override
  String selectedCount(Object count) {
    return '$count items selected';
  }

  @override
  String get noSinsSelected => 'No sins selected';

  @override
  String get continueEditing => 'Continue Editing';

  @override
  String get proceedToConfess => 'Proceed';

  @override
  String get clearDraftTitle => 'Clear Draft?';

  @override
  String get clearDraftMessage => 'This will remove all selected questions. Are you sure?';

  @override
  String get clearDraft => 'Clear Draft';

  @override
  String get clear => 'Clear';

  @override
  String draftRestored(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Restored $count items from your last session',
      one: 'Restored 1 item from your last session',
    );
    return '$_temp0';
  }

  @override
  String get justNow => 'Just now';

  @override
  String minutesAgo(Object count) {
    return '${count}m ago';
  }

  @override
  String hoursAgo(Object count) {
    return '${count}h ago';
  }

  @override
  String get general => 'General';

  @override
  String get noQuestionsInSection => 'No questions in this section';

  @override
  String get skip => 'Skip';

  @override
  String get back => 'Back';

  @override
  String get skipOnboardingTitle => 'Skip Introduction?';

  @override
  String get skipOnboardingMessage => 'You can always access help and settings later from the app menu.';

  @override
  String get confessionHistoryTitle => 'Confession History';

  @override
  String get deleteAll => 'Delete All';

  @override
  String get editDate => 'Edit Date';

  @override
  String get confessionDate => 'Confession Date';

  @override
  String get dateUpdated => 'Date updated';

  @override
  String get changeDateConfirmTitle => 'Change Date?';

  @override
  String changeDateConfirmMessage(Object date) {
    return 'Change confession date to $date?';
  }

  @override
  String get noGuideContent => 'No guide content available';

  @override
  String get noGuideContentDesc => 'Guide content will appear here';

  @override
  String get noFaqContent => 'No FAQs available';

  @override
  String get noFaqContentDesc => 'Frequently asked questions will appear here';

  @override
  String get faqSubtitle => 'Frequently asked questions about confession';

  @override
  String get tapToExpand => 'Tap to read more';
}
