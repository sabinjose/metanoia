import 'package:drift/drift.dart';

// Static Content Tables

class Commandments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get commandmentNo => integer()();
  TextColumn get content => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  TextColumn get code => text().nullable().unique()();
  TextColumn get customTitle => text().nullable()();
}

class ExaminationQuestions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get commandmentId => integer().references(Commandments, #id)();
  TextColumn get question => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
}

class Faqs extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get heading => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
}

class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get author => text()();
  TextColumn get quote => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
}

// User Data Tables (Encrypted)

class Confessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  DateTimeColumn get finishedAt => dateTime().nullable()();
}

class ConfessionItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get confessionId =>
      integer().references(Confessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get content => text()();
  TextColumn get note => text().nullable()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  // For standard items, we might want to link back to the question, but text is enough for the confession list
  IntColumn get questionId =>
      integer().nullable().references(ExaminationQuestions, #id)();
}

class UserSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
}

class GuideItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get section => text()();
  TextColumn get title => text()();
  TextColumn get icon => text()();
  TextColumn get content => text()();
  IntColumn get displayOrder => integer()();
  TextColumn get languageCode => text()();
}

class Prayers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  IntColumn get displayOrder => integer()();
  TextColumn get languageCode => text()();
}

// User Data Tables - Custom Sins

class UserCustomSins extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sinText => text()();
  TextColumn get note => text().nullable()();

  // Optional: Link to a commandment code (null = standalone/general custom sin)
  TextColumn get commandmentCode => text().nullable()();

  // Track if this is a user's edited version of a pre-existing question
  // If set, this custom sin is shown instead of the original during examination
  IntColumn get originalQuestionId =>
      integer().nullable().references(ExaminationQuestions, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
