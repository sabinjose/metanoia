// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CommandmentsTable extends Commandments
    with TableInfo<$CommandmentsTable, Commandment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommandmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _commandmentNoMeta =
      const VerificationMeta('commandmentNo');
  @override
  late final GeneratedColumn<int> commandmentNo = GeneratedColumn<int>(
      'commandment_no', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('en'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _customTitleMeta =
      const VerificationMeta('customTitle');
  @override
  late final GeneratedColumn<String> customTitle = GeneratedColumn<String>(
      'custom_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, commandmentNo, content, languageCode, code, customTitle];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'commandments';
  @override
  VerificationContext validateIntegrity(Insertable<Commandment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('commandment_no')) {
      context.handle(
          _commandmentNoMeta,
          commandmentNo.isAcceptableOrUnknown(
              data['commandment_no']!, _commandmentNoMeta));
    } else if (isInserting) {
      context.missing(_commandmentNoMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('custom_title')) {
      context.handle(
          _customTitleMeta,
          customTitle.isAcceptableOrUnknown(
              data['custom_title']!, _customTitleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Commandment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Commandment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      commandmentNo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}commandment_no'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      customTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}custom_title']),
    );
  }

  @override
  $CommandmentsTable createAlias(String alias) {
    return $CommandmentsTable(attachedDatabase, alias);
  }
}

class Commandment extends DataClass implements Insertable<Commandment> {
  final int id;
  final int commandmentNo;
  final String content;
  final String languageCode;
  final String? code;
  final String? customTitle;
  const Commandment(
      {required this.id,
      required this.commandmentNo,
      required this.content,
      required this.languageCode,
      this.code,
      this.customTitle});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['commandment_no'] = Variable<int>(commandmentNo);
    map['content'] = Variable<String>(content);
    map['language_code'] = Variable<String>(languageCode);
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || customTitle != null) {
      map['custom_title'] = Variable<String>(customTitle);
    }
    return map;
  }

  CommandmentsCompanion toCompanion(bool nullToAbsent) {
    return CommandmentsCompanion(
      id: Value(id),
      commandmentNo: Value(commandmentNo),
      content: Value(content),
      languageCode: Value(languageCode),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      customTitle: customTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(customTitle),
    );
  }

  factory Commandment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Commandment(
      id: serializer.fromJson<int>(json['id']),
      commandmentNo: serializer.fromJson<int>(json['commandmentNo']),
      content: serializer.fromJson<String>(json['content']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      code: serializer.fromJson<String?>(json['code']),
      customTitle: serializer.fromJson<String?>(json['customTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'commandmentNo': serializer.toJson<int>(commandmentNo),
      'content': serializer.toJson<String>(content),
      'languageCode': serializer.toJson<String>(languageCode),
      'code': serializer.toJson<String?>(code),
      'customTitle': serializer.toJson<String?>(customTitle),
    };
  }

  Commandment copyWith(
          {int? id,
          int? commandmentNo,
          String? content,
          String? languageCode,
          Value<String?> code = const Value.absent(),
          Value<String?> customTitle = const Value.absent()}) =>
      Commandment(
        id: id ?? this.id,
        commandmentNo: commandmentNo ?? this.commandmentNo,
        content: content ?? this.content,
        languageCode: languageCode ?? this.languageCode,
        code: code.present ? code.value : this.code,
        customTitle: customTitle.present ? customTitle.value : this.customTitle,
      );
  Commandment copyWithCompanion(CommandmentsCompanion data) {
    return Commandment(
      id: data.id.present ? data.id.value : this.id,
      commandmentNo: data.commandmentNo.present
          ? data.commandmentNo.value
          : this.commandmentNo,
      content: data.content.present ? data.content.value : this.content,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      code: data.code.present ? data.code.value : this.code,
      customTitle:
          data.customTitle.present ? data.customTitle.value : this.customTitle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Commandment(')
          ..write('id: $id, ')
          ..write('commandmentNo: $commandmentNo, ')
          ..write('content: $content, ')
          ..write('languageCode: $languageCode, ')
          ..write('code: $code, ')
          ..write('customTitle: $customTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, commandmentNo, content, languageCode, code, customTitle);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Commandment &&
          other.id == this.id &&
          other.commandmentNo == this.commandmentNo &&
          other.content == this.content &&
          other.languageCode == this.languageCode &&
          other.code == this.code &&
          other.customTitle == this.customTitle);
}

class CommandmentsCompanion extends UpdateCompanion<Commandment> {
  final Value<int> id;
  final Value<int> commandmentNo;
  final Value<String> content;
  final Value<String> languageCode;
  final Value<String?> code;
  final Value<String?> customTitle;
  const CommandmentsCompanion({
    this.id = const Value.absent(),
    this.commandmentNo = const Value.absent(),
    this.content = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.code = const Value.absent(),
    this.customTitle = const Value.absent(),
  });
  CommandmentsCompanion.insert({
    this.id = const Value.absent(),
    required int commandmentNo,
    required String content,
    this.languageCode = const Value.absent(),
    this.code = const Value.absent(),
    this.customTitle = const Value.absent(),
  })  : commandmentNo = Value(commandmentNo),
        content = Value(content);
  static Insertable<Commandment> custom({
    Expression<int>? id,
    Expression<int>? commandmentNo,
    Expression<String>? content,
    Expression<String>? languageCode,
    Expression<String>? code,
    Expression<String>? customTitle,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commandmentNo != null) 'commandment_no': commandmentNo,
      if (content != null) 'content': content,
      if (languageCode != null) 'language_code': languageCode,
      if (code != null) 'code': code,
      if (customTitle != null) 'custom_title': customTitle,
    });
  }

  CommandmentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? commandmentNo,
      Value<String>? content,
      Value<String>? languageCode,
      Value<String?>? code,
      Value<String?>? customTitle}) {
    return CommandmentsCompanion(
      id: id ?? this.id,
      commandmentNo: commandmentNo ?? this.commandmentNo,
      content: content ?? this.content,
      languageCode: languageCode ?? this.languageCode,
      code: code ?? this.code,
      customTitle: customTitle ?? this.customTitle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (commandmentNo.present) {
      map['commandment_no'] = Variable<int>(commandmentNo.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (customTitle.present) {
      map['custom_title'] = Variable<String>(customTitle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommandmentsCompanion(')
          ..write('id: $id, ')
          ..write('commandmentNo: $commandmentNo, ')
          ..write('content: $content, ')
          ..write('languageCode: $languageCode, ')
          ..write('code: $code, ')
          ..write('customTitle: $customTitle')
          ..write(')'))
        .toString();
  }
}

class $ExaminationQuestionsTable extends ExaminationQuestions
    with TableInfo<$ExaminationQuestionsTable, ExaminationQuestion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExaminationQuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _commandmentIdMeta =
      const VerificationMeta('commandmentId');
  @override
  late final GeneratedColumn<int> commandmentId = GeneratedColumn<int>(
      'commandment_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES commandments (id)'));
  static const VerificationMeta _questionMeta =
      const VerificationMeta('question');
  @override
  late final GeneratedColumn<String> question = GeneratedColumn<String>(
      'question', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('en'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, commandmentId, question, languageCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'examination_questions';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExaminationQuestion> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('commandment_id')) {
      context.handle(
          _commandmentIdMeta,
          commandmentId.isAcceptableOrUnknown(
              data['commandment_id']!, _commandmentIdMeta));
    } else if (isInserting) {
      context.missing(_commandmentIdMeta);
    }
    if (data.containsKey('question')) {
      context.handle(_questionMeta,
          question.isAcceptableOrUnknown(data['question']!, _questionMeta));
    } else if (isInserting) {
      context.missing(_questionMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExaminationQuestion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExaminationQuestion(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      commandmentId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}commandment_id'])!,
      question: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
    );
  }

  @override
  $ExaminationQuestionsTable createAlias(String alias) {
    return $ExaminationQuestionsTable(attachedDatabase, alias);
  }
}

class ExaminationQuestion extends DataClass
    implements Insertable<ExaminationQuestion> {
  final int id;
  final int commandmentId;
  final String question;
  final String languageCode;
  const ExaminationQuestion(
      {required this.id,
      required this.commandmentId,
      required this.question,
      required this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['commandment_id'] = Variable<int>(commandmentId);
    map['question'] = Variable<String>(question);
    map['language_code'] = Variable<String>(languageCode);
    return map;
  }

  ExaminationQuestionsCompanion toCompanion(bool nullToAbsent) {
    return ExaminationQuestionsCompanion(
      id: Value(id),
      commandmentId: Value(commandmentId),
      question: Value(question),
      languageCode: Value(languageCode),
    );
  }

  factory ExaminationQuestion.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExaminationQuestion(
      id: serializer.fromJson<int>(json['id']),
      commandmentId: serializer.fromJson<int>(json['commandmentId']),
      question: serializer.fromJson<String>(json['question']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'commandmentId': serializer.toJson<int>(commandmentId),
      'question': serializer.toJson<String>(question),
      'languageCode': serializer.toJson<String>(languageCode),
    };
  }

  ExaminationQuestion copyWith(
          {int? id,
          int? commandmentId,
          String? question,
          String? languageCode}) =>
      ExaminationQuestion(
        id: id ?? this.id,
        commandmentId: commandmentId ?? this.commandmentId,
        question: question ?? this.question,
        languageCode: languageCode ?? this.languageCode,
      );
  ExaminationQuestion copyWithCompanion(ExaminationQuestionsCompanion data) {
    return ExaminationQuestion(
      id: data.id.present ? data.id.value : this.id,
      commandmentId: data.commandmentId.present
          ? data.commandmentId.value
          : this.commandmentId,
      question: data.question.present ? data.question.value : this.question,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExaminationQuestion(')
          ..write('id: $id, ')
          ..write('commandmentId: $commandmentId, ')
          ..write('question: $question, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, commandmentId, question, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExaminationQuestion &&
          other.id == this.id &&
          other.commandmentId == this.commandmentId &&
          other.question == this.question &&
          other.languageCode == this.languageCode);
}

class ExaminationQuestionsCompanion
    extends UpdateCompanion<ExaminationQuestion> {
  final Value<int> id;
  final Value<int> commandmentId;
  final Value<String> question;
  final Value<String> languageCode;
  const ExaminationQuestionsCompanion({
    this.id = const Value.absent(),
    this.commandmentId = const Value.absent(),
    this.question = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  ExaminationQuestionsCompanion.insert({
    this.id = const Value.absent(),
    required int commandmentId,
    required String question,
    this.languageCode = const Value.absent(),
  })  : commandmentId = Value(commandmentId),
        question = Value(question);
  static Insertable<ExaminationQuestion> custom({
    Expression<int>? id,
    Expression<int>? commandmentId,
    Expression<String>? question,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commandmentId != null) 'commandment_id': commandmentId,
      if (question != null) 'question': question,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  ExaminationQuestionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? commandmentId,
      Value<String>? question,
      Value<String>? languageCode}) {
    return ExaminationQuestionsCompanion(
      id: id ?? this.id,
      commandmentId: commandmentId ?? this.commandmentId,
      question: question ?? this.question,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (commandmentId.present) {
      map['commandment_id'] = Variable<int>(commandmentId.value);
    }
    if (question.present) {
      map['question'] = Variable<String>(question.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExaminationQuestionsCompanion(')
          ..write('id: $id, ')
          ..write('commandmentId: $commandmentId, ')
          ..write('question: $question, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

class $FaqsTable extends Faqs with TableInfo<$FaqsTable, Faq> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FaqsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _headingMeta =
      const VerificationMeta('heading');
  @override
  late final GeneratedColumn<String> heading = GeneratedColumn<String>(
      'heading', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('en'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, heading, title, content, languageCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'faqs';
  @override
  VerificationContext validateIntegrity(Insertable<Faq> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('heading')) {
      context.handle(_headingMeta,
          heading.isAcceptableOrUnknown(data['heading']!, _headingMeta));
    } else if (isInserting) {
      context.missing(_headingMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Faq map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Faq(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      heading: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}heading'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
    );
  }

  @override
  $FaqsTable createAlias(String alias) {
    return $FaqsTable(attachedDatabase, alias);
  }
}

class Faq extends DataClass implements Insertable<Faq> {
  final int id;
  final String heading;
  final String title;
  final String content;
  final String languageCode;
  const Faq(
      {required this.id,
      required this.heading,
      required this.title,
      required this.content,
      required this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['heading'] = Variable<String>(heading);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['language_code'] = Variable<String>(languageCode);
    return map;
  }

  FaqsCompanion toCompanion(bool nullToAbsent) {
    return FaqsCompanion(
      id: Value(id),
      heading: Value(heading),
      title: Value(title),
      content: Value(content),
      languageCode: Value(languageCode),
    );
  }

  factory Faq.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Faq(
      id: serializer.fromJson<int>(json['id']),
      heading: serializer.fromJson<String>(json['heading']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'heading': serializer.toJson<String>(heading),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'languageCode': serializer.toJson<String>(languageCode),
    };
  }

  Faq copyWith(
          {int? id,
          String? heading,
          String? title,
          String? content,
          String? languageCode}) =>
      Faq(
        id: id ?? this.id,
        heading: heading ?? this.heading,
        title: title ?? this.title,
        content: content ?? this.content,
        languageCode: languageCode ?? this.languageCode,
      );
  Faq copyWithCompanion(FaqsCompanion data) {
    return Faq(
      id: data.id.present ? data.id.value : this.id,
      heading: data.heading.present ? data.heading.value : this.heading,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Faq(')
          ..write('id: $id, ')
          ..write('heading: $heading, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, heading, title, content, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Faq &&
          other.id == this.id &&
          other.heading == this.heading &&
          other.title == this.title &&
          other.content == this.content &&
          other.languageCode == this.languageCode);
}

class FaqsCompanion extends UpdateCompanion<Faq> {
  final Value<int> id;
  final Value<String> heading;
  final Value<String> title;
  final Value<String> content;
  final Value<String> languageCode;
  const FaqsCompanion({
    this.id = const Value.absent(),
    this.heading = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  FaqsCompanion.insert({
    this.id = const Value.absent(),
    required String heading,
    required String title,
    required String content,
    this.languageCode = const Value.absent(),
  })  : heading = Value(heading),
        title = Value(title),
        content = Value(content);
  static Insertable<Faq> custom({
    Expression<int>? id,
    Expression<String>? heading,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (heading != null) 'heading': heading,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  FaqsCompanion copyWith(
      {Value<int>? id,
      Value<String>? heading,
      Value<String>? title,
      Value<String>? content,
      Value<String>? languageCode}) {
    return FaqsCompanion(
      id: id ?? this.id,
      heading: heading ?? this.heading,
      title: title ?? this.title,
      content: content ?? this.content,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (heading.present) {
      map['heading'] = Variable<String>(heading.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FaqsCompanion(')
          ..write('id: $id, ')
          ..write('heading: $heading, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, Quote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quoteMeta = const VerificationMeta('quote');
  @override
  late final GeneratedColumn<String> quote = GeneratedColumn<String>(
      'quote', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('en'));
  @override
  List<GeneratedColumn> get $columns => [id, author, quote, languageCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(Insertable<Quote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('quote')) {
      context.handle(
          _quoteMeta, quote.isAcceptableOrUnknown(data['quote']!, _quoteMeta));
    } else if (isInserting) {
      context.missing(_quoteMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      quote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quote'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
    );
  }

  @override
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }
}

class Quote extends DataClass implements Insertable<Quote> {
  final int id;
  final String author;
  final String quote;
  final String languageCode;
  const Quote(
      {required this.id,
      required this.author,
      required this.quote,
      required this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['author'] = Variable<String>(author);
    map['quote'] = Variable<String>(quote);
    map['language_code'] = Variable<String>(languageCode);
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      author: Value(author),
      quote: Value(quote),
      languageCode: Value(languageCode),
    );
  }

  factory Quote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quote(
      id: serializer.fromJson<int>(json['id']),
      author: serializer.fromJson<String>(json['author']),
      quote: serializer.fromJson<String>(json['quote']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'author': serializer.toJson<String>(author),
      'quote': serializer.toJson<String>(quote),
      'languageCode': serializer.toJson<String>(languageCode),
    };
  }

  Quote copyWith(
          {int? id, String? author, String? quote, String? languageCode}) =>
      Quote(
        id: id ?? this.id,
        author: author ?? this.author,
        quote: quote ?? this.quote,
        languageCode: languageCode ?? this.languageCode,
      );
  Quote copyWithCompanion(QuotesCompanion data) {
    return Quote(
      id: data.id.present ? data.id.value : this.id,
      author: data.author.present ? data.author.value : this.author,
      quote: data.quote.present ? data.quote.value : this.quote,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quote(')
          ..write('id: $id, ')
          ..write('author: $author, ')
          ..write('quote: $quote, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, author, quote, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quote &&
          other.id == this.id &&
          other.author == this.author &&
          other.quote == this.quote &&
          other.languageCode == this.languageCode);
}

class QuotesCompanion extends UpdateCompanion<Quote> {
  final Value<int> id;
  final Value<String> author;
  final Value<String> quote;
  final Value<String> languageCode;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.author = const Value.absent(),
    this.quote = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  QuotesCompanion.insert({
    this.id = const Value.absent(),
    required String author,
    required String quote,
    this.languageCode = const Value.absent(),
  })  : author = Value(author),
        quote = Value(quote);
  static Insertable<Quote> custom({
    Expression<int>? id,
    Expression<String>? author,
    Expression<String>? quote,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (author != null) 'author': author,
      if (quote != null) 'quote': quote,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  QuotesCompanion copyWith(
      {Value<int>? id,
      Value<String>? author,
      Value<String>? quote,
      Value<String>? languageCode}) {
    return QuotesCompanion(
      id: id ?? this.id,
      author: author ?? this.author,
      quote: quote ?? this.quote,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (quote.present) {
      map['quote'] = Variable<String>(quote.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotesCompanion(')
          ..write('id: $id, ')
          ..write('author: $author, ')
          ..write('quote: $quote, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

class $ConfessionsTable extends Confessions
    with TableInfo<$ConfessionsTable, Confession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isFinishedMeta =
      const VerificationMeta('isFinished');
  @override
  late final GeneratedColumn<bool> isFinished = GeneratedColumn<bool>(
      'is_finished', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_finished" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _finishedAtMeta =
      const VerificationMeta('finishedAt');
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
      'finished_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, isFinished, finishedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'confessions';
  @override
  VerificationContext validateIntegrity(Insertable<Confession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('is_finished')) {
      context.handle(
          _isFinishedMeta,
          isFinished.isAcceptableOrUnknown(
              data['is_finished']!, _isFinishedMeta));
    }
    if (data.containsKey('finished_at')) {
      context.handle(
          _finishedAtMeta,
          finishedAt.isAcceptableOrUnknown(
              data['finished_at']!, _finishedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Confession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Confession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      isFinished: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_finished'])!,
      finishedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}finished_at']),
    );
  }

  @override
  $ConfessionsTable createAlias(String alias) {
    return $ConfessionsTable(attachedDatabase, alias);
  }
}

class Confession extends DataClass implements Insertable<Confession> {
  final int id;
  final DateTime date;
  final bool isFinished;
  final DateTime? finishedAt;
  const Confession(
      {required this.id,
      required this.date,
      required this.isFinished,
      this.finishedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['is_finished'] = Variable<bool>(isFinished);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    return map;
  }

  ConfessionsCompanion toCompanion(bool nullToAbsent) {
    return ConfessionsCompanion(
      id: Value(id),
      date: Value(date),
      isFinished: Value(isFinished),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
    );
  }

  factory Confession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Confession(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      isFinished: serializer.fromJson<bool>(json['isFinished']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'isFinished': serializer.toJson<bool>(isFinished),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
    };
  }

  Confession copyWith(
          {int? id,
          DateTime? date,
          bool? isFinished,
          Value<DateTime?> finishedAt = const Value.absent()}) =>
      Confession(
        id: id ?? this.id,
        date: date ?? this.date,
        isFinished: isFinished ?? this.isFinished,
        finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
      );
  Confession copyWithCompanion(ConfessionsCompanion data) {
    return Confession(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      isFinished:
          data.isFinished.present ? data.isFinished.value : this.isFinished,
      finishedAt:
          data.finishedAt.present ? data.finishedAt.value : this.finishedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Confession(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('isFinished: $isFinished, ')
          ..write('finishedAt: $finishedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, isFinished, finishedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Confession &&
          other.id == this.id &&
          other.date == this.date &&
          other.isFinished == this.isFinished &&
          other.finishedAt == this.finishedAt);
}

class ConfessionsCompanion extends UpdateCompanion<Confession> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<bool> isFinished;
  final Value<DateTime?> finishedAt;
  const ConfessionsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.finishedAt = const Value.absent(),
  });
  ConfessionsCompanion.insert({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.isFinished = const Value.absent(),
    this.finishedAt = const Value.absent(),
  });
  static Insertable<Confession> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<bool>? isFinished,
    Expression<DateTime>? finishedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (isFinished != null) 'is_finished': isFinished,
      if (finishedAt != null) 'finished_at': finishedAt,
    });
  }

  ConfessionsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<bool>? isFinished,
      Value<DateTime?>? finishedAt}) {
    return ConfessionsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      isFinished: isFinished ?? this.isFinished,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isFinished.present) {
      map['is_finished'] = Variable<bool>(isFinished.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfessionsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('isFinished: $isFinished, ')
          ..write('finishedAt: $finishedAt')
          ..write(')'))
        .toString();
  }
}

class $ConfessionItemsTable extends ConfessionItems
    with TableInfo<$ConfessionItemsTable, ConfessionItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfessionItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _confessionIdMeta =
      const VerificationMeta('confessionId');
  @override
  late final GeneratedColumn<int> confessionId = GeneratedColumn<int>(
      'confession_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES confessions (id) ON DELETE CASCADE'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isCustomMeta =
      const VerificationMeta('isCustom');
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
      'is_custom', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_custom" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<int> questionId = GeneratedColumn<int>(
      'question_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES examination_questions (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, confessionId, content, note, isCustom, questionId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'confession_items';
  @override
  VerificationContext validateIntegrity(Insertable<ConfessionItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('confession_id')) {
      context.handle(
          _confessionIdMeta,
          confessionId.isAcceptableOrUnknown(
              data['confession_id']!, _confessionIdMeta));
    } else if (isInserting) {
      context.missing(_confessionIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('is_custom')) {
      context.handle(_isCustomMeta,
          isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConfessionItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfessionItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      confessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}confession_id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      isCustom: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_custom'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_id']),
    );
  }

  @override
  $ConfessionItemsTable createAlias(String alias) {
    return $ConfessionItemsTable(attachedDatabase, alias);
  }
}

class ConfessionItem extends DataClass implements Insertable<ConfessionItem> {
  final int id;
  final int confessionId;
  final String content;
  final String? note;
  final bool isCustom;
  final int? questionId;
  const ConfessionItem(
      {required this.id,
      required this.confessionId,
      required this.content,
      this.note,
      required this.isCustom,
      this.questionId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['confession_id'] = Variable<int>(confessionId);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['is_custom'] = Variable<bool>(isCustom);
    if (!nullToAbsent || questionId != null) {
      map['question_id'] = Variable<int>(questionId);
    }
    return map;
  }

  ConfessionItemsCompanion toCompanion(bool nullToAbsent) {
    return ConfessionItemsCompanion(
      id: Value(id),
      confessionId: Value(confessionId),
      content: Value(content),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      isCustom: Value(isCustom),
      questionId: questionId == null && nullToAbsent
          ? const Value.absent()
          : Value(questionId),
    );
  }

  factory ConfessionItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfessionItem(
      id: serializer.fromJson<int>(json['id']),
      confessionId: serializer.fromJson<int>(json['confessionId']),
      content: serializer.fromJson<String>(json['content']),
      note: serializer.fromJson<String?>(json['note']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      questionId: serializer.fromJson<int?>(json['questionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'confessionId': serializer.toJson<int>(confessionId),
      'content': serializer.toJson<String>(content),
      'note': serializer.toJson<String?>(note),
      'isCustom': serializer.toJson<bool>(isCustom),
      'questionId': serializer.toJson<int?>(questionId),
    };
  }

  ConfessionItem copyWith(
          {int? id,
          int? confessionId,
          String? content,
          Value<String?> note = const Value.absent(),
          bool? isCustom,
          Value<int?> questionId = const Value.absent()}) =>
      ConfessionItem(
        id: id ?? this.id,
        confessionId: confessionId ?? this.confessionId,
        content: content ?? this.content,
        note: note.present ? note.value : this.note,
        isCustom: isCustom ?? this.isCustom,
        questionId: questionId.present ? questionId.value : this.questionId,
      );
  ConfessionItem copyWithCompanion(ConfessionItemsCompanion data) {
    return ConfessionItem(
      id: data.id.present ? data.id.value : this.id,
      confessionId: data.confessionId.present
          ? data.confessionId.value
          : this.confessionId,
      content: data.content.present ? data.content.value : this.content,
      note: data.note.present ? data.note.value : this.note,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfessionItem(')
          ..write('id: $id, ')
          ..write('confessionId: $confessionId, ')
          ..write('content: $content, ')
          ..write('note: $note, ')
          ..write('isCustom: $isCustom, ')
          ..write('questionId: $questionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, confessionId, content, note, isCustom, questionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfessionItem &&
          other.id == this.id &&
          other.confessionId == this.confessionId &&
          other.content == this.content &&
          other.note == this.note &&
          other.isCustom == this.isCustom &&
          other.questionId == this.questionId);
}

class ConfessionItemsCompanion extends UpdateCompanion<ConfessionItem> {
  final Value<int> id;
  final Value<int> confessionId;
  final Value<String> content;
  final Value<String?> note;
  final Value<bool> isCustom;
  final Value<int?> questionId;
  const ConfessionItemsCompanion({
    this.id = const Value.absent(),
    this.confessionId = const Value.absent(),
    this.content = const Value.absent(),
    this.note = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.questionId = const Value.absent(),
  });
  ConfessionItemsCompanion.insert({
    this.id = const Value.absent(),
    required int confessionId,
    required String content,
    this.note = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.questionId = const Value.absent(),
  })  : confessionId = Value(confessionId),
        content = Value(content);
  static Insertable<ConfessionItem> custom({
    Expression<int>? id,
    Expression<int>? confessionId,
    Expression<String>? content,
    Expression<String>? note,
    Expression<bool>? isCustom,
    Expression<int>? questionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (confessionId != null) 'confession_id': confessionId,
      if (content != null) 'content': content,
      if (note != null) 'note': note,
      if (isCustom != null) 'is_custom': isCustom,
      if (questionId != null) 'question_id': questionId,
    });
  }

  ConfessionItemsCompanion copyWith(
      {Value<int>? id,
      Value<int>? confessionId,
      Value<String>? content,
      Value<String?>? note,
      Value<bool>? isCustom,
      Value<int?>? questionId}) {
    return ConfessionItemsCompanion(
      id: id ?? this.id,
      confessionId: confessionId ?? this.confessionId,
      content: content ?? this.content,
      note: note ?? this.note,
      isCustom: isCustom ?? this.isCustom,
      questionId: questionId ?? this.questionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (confessionId.present) {
      map['confession_id'] = Variable<int>(confessionId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<int>(questionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfessionItemsCompanion(')
          ..write('id: $id, ')
          ..write('confessionId: $confessionId, ')
          ..write('content: $content, ')
          ..write('note: $note, ')
          ..write('isCustom: $isCustom, ')
          ..write('questionId: $questionId')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(Insertable<UserSetting> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final int id;
  final String key;
  final String value;
  const UserSetting({required this.id, required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
    );
  }

  factory UserSetting.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  UserSetting copyWith({int? id, String? key, String? value}) => UserSetting(
        id: id ?? this.id,
        key: key ?? this.key,
        value: value ?? this.value,
      );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  const UserSettingsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
  })  : key = Value(key),
        value = Value(value);
  static Insertable<UserSetting> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
    });
  }

  UserSettingsCompanion copyWith(
      {Value<int>? id, Value<String>? key, Value<String>? value}) {
    return UserSettingsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $GuideItemsTable extends GuideItems
    with TableInfo<$GuideItemsTable, GuideItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GuideItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sectionMeta =
      const VerificationMeta('section');
  @override
  late final GeneratedColumn<String> section = GeneratedColumn<String>(
      'section', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayOrderMeta =
      const VerificationMeta('displayOrder');
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
      'display_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, section, title, icon, content, displayOrder, languageCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'guide_items';
  @override
  VerificationContext validateIntegrity(Insertable<GuideItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('section')) {
      context.handle(_sectionMeta,
          section.isAcceptableOrUnknown(data['section']!, _sectionMeta));
    } else if (isInserting) {
      context.missing(_sectionMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('display_order')) {
      context.handle(
          _displayOrderMeta,
          displayOrder.isAcceptableOrUnknown(
              data['display_order']!, _displayOrderMeta));
    } else if (isInserting) {
      context.missing(_displayOrderMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GuideItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GuideItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      section: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      displayOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_order'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
    );
  }

  @override
  $GuideItemsTable createAlias(String alias) {
    return $GuideItemsTable(attachedDatabase, alias);
  }
}

class GuideItem extends DataClass implements Insertable<GuideItem> {
  final int id;
  final String section;
  final String title;
  final String icon;
  final String content;
  final int displayOrder;
  final String languageCode;
  const GuideItem(
      {required this.id,
      required this.section,
      required this.title,
      required this.icon,
      required this.content,
      required this.displayOrder,
      required this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['section'] = Variable<String>(section);
    map['title'] = Variable<String>(title);
    map['icon'] = Variable<String>(icon);
    map['content'] = Variable<String>(content);
    map['display_order'] = Variable<int>(displayOrder);
    map['language_code'] = Variable<String>(languageCode);
    return map;
  }

  GuideItemsCompanion toCompanion(bool nullToAbsent) {
    return GuideItemsCompanion(
      id: Value(id),
      section: Value(section),
      title: Value(title),
      icon: Value(icon),
      content: Value(content),
      displayOrder: Value(displayOrder),
      languageCode: Value(languageCode),
    );
  }

  factory GuideItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GuideItem(
      id: serializer.fromJson<int>(json['id']),
      section: serializer.fromJson<String>(json['section']),
      title: serializer.fromJson<String>(json['title']),
      icon: serializer.fromJson<String>(json['icon']),
      content: serializer.fromJson<String>(json['content']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'section': serializer.toJson<String>(section),
      'title': serializer.toJson<String>(title),
      'icon': serializer.toJson<String>(icon),
      'content': serializer.toJson<String>(content),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'languageCode': serializer.toJson<String>(languageCode),
    };
  }

  GuideItem copyWith(
          {int? id,
          String? section,
          String? title,
          String? icon,
          String? content,
          int? displayOrder,
          String? languageCode}) =>
      GuideItem(
        id: id ?? this.id,
        section: section ?? this.section,
        title: title ?? this.title,
        icon: icon ?? this.icon,
        content: content ?? this.content,
        displayOrder: displayOrder ?? this.displayOrder,
        languageCode: languageCode ?? this.languageCode,
      );
  GuideItem copyWithCompanion(GuideItemsCompanion data) {
    return GuideItem(
      id: data.id.present ? data.id.value : this.id,
      section: data.section.present ? data.section.value : this.section,
      title: data.title.present ? data.title.value : this.title,
      icon: data.icon.present ? data.icon.value : this.icon,
      content: data.content.present ? data.content.value : this.content,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GuideItem(')
          ..write('id: $id, ')
          ..write('section: $section, ')
          ..write('title: $title, ')
          ..write('icon: $icon, ')
          ..write('content: $content, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, section, title, icon, content, displayOrder, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GuideItem &&
          other.id == this.id &&
          other.section == this.section &&
          other.title == this.title &&
          other.icon == this.icon &&
          other.content == this.content &&
          other.displayOrder == this.displayOrder &&
          other.languageCode == this.languageCode);
}

class GuideItemsCompanion extends UpdateCompanion<GuideItem> {
  final Value<int> id;
  final Value<String> section;
  final Value<String> title;
  final Value<String> icon;
  final Value<String> content;
  final Value<int> displayOrder;
  final Value<String> languageCode;
  const GuideItemsCompanion({
    this.id = const Value.absent(),
    this.section = const Value.absent(),
    this.title = const Value.absent(),
    this.icon = const Value.absent(),
    this.content = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  GuideItemsCompanion.insert({
    this.id = const Value.absent(),
    required String section,
    required String title,
    required String icon,
    required String content,
    required int displayOrder,
    required String languageCode,
  })  : section = Value(section),
        title = Value(title),
        icon = Value(icon),
        content = Value(content),
        displayOrder = Value(displayOrder),
        languageCode = Value(languageCode);
  static Insertable<GuideItem> custom({
    Expression<int>? id,
    Expression<String>? section,
    Expression<String>? title,
    Expression<String>? icon,
    Expression<String>? content,
    Expression<int>? displayOrder,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (section != null) 'section': section,
      if (title != null) 'title': title,
      if (icon != null) 'icon': icon,
      if (content != null) 'content': content,
      if (displayOrder != null) 'display_order': displayOrder,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  GuideItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? section,
      Value<String>? title,
      Value<String>? icon,
      Value<String>? content,
      Value<int>? displayOrder,
      Value<String>? languageCode}) {
    return GuideItemsCompanion(
      id: id ?? this.id,
      section: section ?? this.section,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      content: content ?? this.content,
      displayOrder: displayOrder ?? this.displayOrder,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (section.present) {
      map['section'] = Variable<String>(section.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GuideItemsCompanion(')
          ..write('id: $id, ')
          ..write('section: $section, ')
          ..write('title: $title, ')
          ..write('icon: $icon, ')
          ..write('content: $content, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

class $PrayersTable extends Prayers with TableInfo<$PrayersTable, Prayer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _displayOrderMeta =
      const VerificationMeta('displayOrder');
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
      'display_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, displayOrder, languageCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'prayers';
  @override
  VerificationContext validateIntegrity(Insertable<Prayer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('display_order')) {
      context.handle(
          _displayOrderMeta,
          displayOrder.isAcceptableOrUnknown(
              data['display_order']!, _displayOrderMeta));
    } else if (isInserting) {
      context.missing(_displayOrderMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    } else if (isInserting) {
      context.missing(_languageCodeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Prayer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Prayer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      displayOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_order'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
    );
  }

  @override
  $PrayersTable createAlias(String alias) {
    return $PrayersTable(attachedDatabase, alias);
  }
}

class Prayer extends DataClass implements Insertable<Prayer> {
  final int id;
  final String title;
  final String content;
  final int displayOrder;
  final String languageCode;
  const Prayer(
      {required this.id,
      required this.title,
      required this.content,
      required this.displayOrder,
      required this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['display_order'] = Variable<int>(displayOrder);
    map['language_code'] = Variable<String>(languageCode);
    return map;
  }

  PrayersCompanion toCompanion(bool nullToAbsent) {
    return PrayersCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      displayOrder: Value(displayOrder),
      languageCode: Value(languageCode),
    );
  }

  factory Prayer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Prayer(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'languageCode': serializer.toJson<String>(languageCode),
    };
  }

  Prayer copyWith(
          {int? id,
          String? title,
          String? content,
          int? displayOrder,
          String? languageCode}) =>
      Prayer(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        displayOrder: displayOrder ?? this.displayOrder,
        languageCode: languageCode ?? this.languageCode,
      );
  Prayer copyWithCompanion(PrayersCompanion data) {
    return Prayer(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Prayer(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, content, displayOrder, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Prayer &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.displayOrder == this.displayOrder &&
          other.languageCode == this.languageCode);
}

class PrayersCompanion extends UpdateCompanion<Prayer> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<int> displayOrder;
  final Value<String> languageCode;
  const PrayersCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  PrayersCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    required int displayOrder,
    required String languageCode,
  })  : title = Value(title),
        content = Value(content),
        displayOrder = Value(displayOrder),
        languageCode = Value(languageCode);
  static Insertable<Prayer> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<int>? displayOrder,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (displayOrder != null) 'display_order': displayOrder,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  PrayersCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<int>? displayOrder,
      Value<String>? languageCode}) {
    return PrayersCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      displayOrder: displayOrder ?? this.displayOrder,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrayersCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

class $UserCustomSinsTable extends UserCustomSins
    with TableInfo<$UserCustomSinsTable, UserCustomSin> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCustomSinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sinTextMeta =
      const VerificationMeta('sinText');
  @override
  late final GeneratedColumn<String> sinText = GeneratedColumn<String>(
      'sin_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _commandmentCodeMeta =
      const VerificationMeta('commandmentCode');
  @override
  late final GeneratedColumn<String> commandmentCode = GeneratedColumn<String>(
      'commandment_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _originalQuestionIdMeta =
      const VerificationMeta('originalQuestionId');
  @override
  late final GeneratedColumn<int> originalQuestionId = GeneratedColumn<int>(
      'original_question_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES examination_questions (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sinText,
        note,
        commandmentCode,
        originalQuestionId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_custom_sins';
  @override
  VerificationContext validateIntegrity(Insertable<UserCustomSin> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sin_text')) {
      context.handle(_sinTextMeta,
          sinText.isAcceptableOrUnknown(data['sin_text']!, _sinTextMeta));
    } else if (isInserting) {
      context.missing(_sinTextMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('commandment_code')) {
      context.handle(
          _commandmentCodeMeta,
          commandmentCode.isAcceptableOrUnknown(
              data['commandment_code']!, _commandmentCodeMeta));
    }
    if (data.containsKey('original_question_id')) {
      context.handle(
          _originalQuestionIdMeta,
          originalQuestionId.isAcceptableOrUnknown(
              data['original_question_id']!, _originalQuestionIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserCustomSin map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserCustomSin(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sinText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sin_text'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      commandmentCode: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}commandment_code']),
      originalQuestionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}original_question_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserCustomSinsTable createAlias(String alias) {
    return $UserCustomSinsTable(attachedDatabase, alias);
  }
}

class UserCustomSin extends DataClass implements Insertable<UserCustomSin> {
  final int id;
  final String sinText;
  final String? note;
  final String? commandmentCode;
  final int? originalQuestionId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserCustomSin(
      {required this.id,
      required this.sinText,
      this.note,
      this.commandmentCode,
      this.originalQuestionId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sin_text'] = Variable<String>(sinText);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || commandmentCode != null) {
      map['commandment_code'] = Variable<String>(commandmentCode);
    }
    if (!nullToAbsent || originalQuestionId != null) {
      map['original_question_id'] = Variable<int>(originalQuestionId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserCustomSinsCompanion toCompanion(bool nullToAbsent) {
    return UserCustomSinsCompanion(
      id: Value(id),
      sinText: Value(sinText),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      commandmentCode: commandmentCode == null && nullToAbsent
          ? const Value.absent()
          : Value(commandmentCode),
      originalQuestionId: originalQuestionId == null && nullToAbsent
          ? const Value.absent()
          : Value(originalQuestionId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserCustomSin.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserCustomSin(
      id: serializer.fromJson<int>(json['id']),
      sinText: serializer.fromJson<String>(json['sinText']),
      note: serializer.fromJson<String?>(json['note']),
      commandmentCode: serializer.fromJson<String?>(json['commandmentCode']),
      originalQuestionId: serializer.fromJson<int?>(json['originalQuestionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sinText': serializer.toJson<String>(sinText),
      'note': serializer.toJson<String?>(note),
      'commandmentCode': serializer.toJson<String?>(commandmentCode),
      'originalQuestionId': serializer.toJson<int?>(originalQuestionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserCustomSin copyWith(
          {int? id,
          String? sinText,
          Value<String?> note = const Value.absent(),
          Value<String?> commandmentCode = const Value.absent(),
          Value<int?> originalQuestionId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UserCustomSin(
        id: id ?? this.id,
        sinText: sinText ?? this.sinText,
        note: note.present ? note.value : this.note,
        commandmentCode: commandmentCode.present
            ? commandmentCode.value
            : this.commandmentCode,
        originalQuestionId: originalQuestionId.present
            ? originalQuestionId.value
            : this.originalQuestionId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserCustomSin copyWithCompanion(UserCustomSinsCompanion data) {
    return UserCustomSin(
      id: data.id.present ? data.id.value : this.id,
      sinText: data.sinText.present ? data.sinText.value : this.sinText,
      note: data.note.present ? data.note.value : this.note,
      commandmentCode: data.commandmentCode.present
          ? data.commandmentCode.value
          : this.commandmentCode,
      originalQuestionId: data.originalQuestionId.present
          ? data.originalQuestionId.value
          : this.originalQuestionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserCustomSin(')
          ..write('id: $id, ')
          ..write('sinText: $sinText, ')
          ..write('note: $note, ')
          ..write('commandmentCode: $commandmentCode, ')
          ..write('originalQuestionId: $originalQuestionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sinText, note, commandmentCode,
      originalQuestionId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCustomSin &&
          other.id == this.id &&
          other.sinText == this.sinText &&
          other.note == this.note &&
          other.commandmentCode == this.commandmentCode &&
          other.originalQuestionId == this.originalQuestionId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserCustomSinsCompanion extends UpdateCompanion<UserCustomSin> {
  final Value<int> id;
  final Value<String> sinText;
  final Value<String?> note;
  final Value<String?> commandmentCode;
  final Value<int?> originalQuestionId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserCustomSinsCompanion({
    this.id = const Value.absent(),
    this.sinText = const Value.absent(),
    this.note = const Value.absent(),
    this.commandmentCode = const Value.absent(),
    this.originalQuestionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserCustomSinsCompanion.insert({
    this.id = const Value.absent(),
    required String sinText,
    this.note = const Value.absent(),
    this.commandmentCode = const Value.absent(),
    this.originalQuestionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : sinText = Value(sinText);
  static Insertable<UserCustomSin> custom({
    Expression<int>? id,
    Expression<String>? sinText,
    Expression<String>? note,
    Expression<String>? commandmentCode,
    Expression<int>? originalQuestionId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sinText != null) 'sin_text': sinText,
      if (note != null) 'note': note,
      if (commandmentCode != null) 'commandment_code': commandmentCode,
      if (originalQuestionId != null)
        'original_question_id': originalQuestionId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserCustomSinsCompanion copyWith(
      {Value<int>? id,
      Value<String>? sinText,
      Value<String?>? note,
      Value<String?>? commandmentCode,
      Value<int?>? originalQuestionId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UserCustomSinsCompanion(
      id: id ?? this.id,
      sinText: sinText ?? this.sinText,
      note: note ?? this.note,
      commandmentCode: commandmentCode ?? this.commandmentCode,
      originalQuestionId: originalQuestionId ?? this.originalQuestionId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sinText.present) {
      map['sin_text'] = Variable<String>(sinText.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (commandmentCode.present) {
      map['commandment_code'] = Variable<String>(commandmentCode.value);
    }
    if (originalQuestionId.present) {
      map['original_question_id'] = Variable<int>(originalQuestionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCustomSinsCompanion(')
          ..write('id: $id, ')
          ..write('sinText: $sinText, ')
          ..write('note: $note, ')
          ..write('commandmentCode: $commandmentCode, ')
          ..write('originalQuestionId: $originalQuestionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CommandmentsTable commandments = $CommandmentsTable(this);
  late final $ExaminationQuestionsTable examinationQuestions =
      $ExaminationQuestionsTable(this);
  late final $FaqsTable faqs = $FaqsTable(this);
  late final $QuotesTable quotes = $QuotesTable(this);
  late final $ConfessionsTable confessions = $ConfessionsTable(this);
  late final $ConfessionItemsTable confessionItems =
      $ConfessionItemsTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $GuideItemsTable guideItems = $GuideItemsTable(this);
  late final $PrayersTable prayers = $PrayersTable(this);
  late final $UserCustomSinsTable userCustomSins = $UserCustomSinsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        commandments,
        examinationQuestions,
        faqs,
        quotes,
        confessions,
        confessionItems,
        userSettings,
        guideItems,
        prayers,
        userCustomSins
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('confessions',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('confession_items', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$CommandmentsTableCreateCompanionBuilder = CommandmentsCompanion
    Function({
  Value<int> id,
  required int commandmentNo,
  required String content,
  Value<String> languageCode,
  Value<String?> code,
  Value<String?> customTitle,
});
typedef $$CommandmentsTableUpdateCompanionBuilder = CommandmentsCompanion
    Function({
  Value<int> id,
  Value<int> commandmentNo,
  Value<String> content,
  Value<String> languageCode,
  Value<String?> code,
  Value<String?> customTitle,
});

class $$CommandmentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CommandmentsTable,
    Commandment,
    $$CommandmentsTableFilterComposer,
    $$CommandmentsTableOrderingComposer,
    $$CommandmentsTableCreateCompanionBuilder,
    $$CommandmentsTableUpdateCompanionBuilder> {
  $$CommandmentsTableTableManager(_$AppDatabase db, $CommandmentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CommandmentsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CommandmentsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> commandmentNo = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> customTitle = const Value.absent(),
          }) =>
              CommandmentsCompanion(
            id: id,
            commandmentNo: commandmentNo,
            content: content,
            languageCode: languageCode,
            code: code,
            customTitle: customTitle,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int commandmentNo,
            required String content,
            Value<String> languageCode = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> customTitle = const Value.absent(),
          }) =>
              CommandmentsCompanion.insert(
            id: id,
            commandmentNo: commandmentNo,
            content: content,
            languageCode: languageCode,
            code: code,
            customTitle: customTitle,
          ),
        ));
}

class $$CommandmentsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CommandmentsTable> {
  $$CommandmentsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get commandmentNo => $state.composableBuilder(
      column: $state.table.commandmentNo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get customTitle => $state.composableBuilder(
      column: $state.table.customTitle,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter examinationQuestionsRefs(
      ComposableFilter Function($$ExaminationQuestionsTableFilterComposer f)
          f) {
    final $$ExaminationQuestionsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.examinationQuestions,
            getReferencedColumn: (t) => t.commandmentId,
            builder: (joinBuilder, parentComposers) =>
                $$ExaminationQuestionsTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.examinationQuestions,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$CommandmentsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CommandmentsTable> {
  $$CommandmentsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get commandmentNo => $state.composableBuilder(
      column: $state.table.commandmentNo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get code => $state.composableBuilder(
      column: $state.table.code,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get customTitle => $state.composableBuilder(
      column: $state.table.customTitle,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ExaminationQuestionsTableCreateCompanionBuilder
    = ExaminationQuestionsCompanion Function({
  Value<int> id,
  required int commandmentId,
  required String question,
  Value<String> languageCode,
});
typedef $$ExaminationQuestionsTableUpdateCompanionBuilder
    = ExaminationQuestionsCompanion Function({
  Value<int> id,
  Value<int> commandmentId,
  Value<String> question,
  Value<String> languageCode,
});

class $$ExaminationQuestionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExaminationQuestionsTable,
    ExaminationQuestion,
    $$ExaminationQuestionsTableFilterComposer,
    $$ExaminationQuestionsTableOrderingComposer,
    $$ExaminationQuestionsTableCreateCompanionBuilder,
    $$ExaminationQuestionsTableUpdateCompanionBuilder> {
  $$ExaminationQuestionsTableTableManager(
      _$AppDatabase db, $ExaminationQuestionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ExaminationQuestionsTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ExaminationQuestionsTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> commandmentId = const Value.absent(),
            Value<String> question = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
          }) =>
              ExaminationQuestionsCompanion(
            id: id,
            commandmentId: commandmentId,
            question: question,
            languageCode: languageCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int commandmentId,
            required String question,
            Value<String> languageCode = const Value.absent(),
          }) =>
              ExaminationQuestionsCompanion.insert(
            id: id,
            commandmentId: commandmentId,
            question: question,
            languageCode: languageCode,
          ),
        ));
}

class $$ExaminationQuestionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ExaminationQuestionsTable> {
  $$ExaminationQuestionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get question => $state.composableBuilder(
      column: $state.table.question,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CommandmentsTableFilterComposer get commandmentId {
    final $$CommandmentsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commandmentId,
        referencedTable: $state.db.commandments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CommandmentsTableFilterComposer(ComposerState($state.db,
                $state.db.commandments, joinBuilder, parentComposers)));
    return composer;
  }

  ComposableFilter confessionItemsRefs(
      ComposableFilter Function($$ConfessionItemsTableFilterComposer f) f) {
    final $$ConfessionItemsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.confessionItems,
            getReferencedColumn: (t) => t.questionId,
            builder: (joinBuilder, parentComposers) =>
                $$ConfessionItemsTableFilterComposer(ComposerState($state.db,
                    $state.db.confessionItems, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter userCustomSinsRefs(
      ComposableFilter Function($$UserCustomSinsTableFilterComposer f) f) {
    final $$UserCustomSinsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.userCustomSins,
        getReferencedColumn: (t) => t.originalQuestionId,
        builder: (joinBuilder, parentComposers) =>
            $$UserCustomSinsTableFilterComposer(ComposerState($state.db,
                $state.db.userCustomSins, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ExaminationQuestionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ExaminationQuestionsTable> {
  $$ExaminationQuestionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get question => $state.composableBuilder(
      column: $state.table.question,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CommandmentsTableOrderingComposer get commandmentId {
    final $$CommandmentsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.commandmentId,
        referencedTable: $state.db.commandments,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$CommandmentsTableOrderingComposer(ComposerState($state.db,
                $state.db.commandments, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$FaqsTableCreateCompanionBuilder = FaqsCompanion Function({
  Value<int> id,
  required String heading,
  required String title,
  required String content,
  Value<String> languageCode,
});
typedef $$FaqsTableUpdateCompanionBuilder = FaqsCompanion Function({
  Value<int> id,
  Value<String> heading,
  Value<String> title,
  Value<String> content,
  Value<String> languageCode,
});

class $$FaqsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FaqsTable,
    Faq,
    $$FaqsTableFilterComposer,
    $$FaqsTableOrderingComposer,
    $$FaqsTableCreateCompanionBuilder,
    $$FaqsTableUpdateCompanionBuilder> {
  $$FaqsTableTableManager(_$AppDatabase db, $FaqsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$FaqsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$FaqsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> heading = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
          }) =>
              FaqsCompanion(
            id: id,
            heading: heading,
            title: title,
            content: content,
            languageCode: languageCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String heading,
            required String title,
            required String content,
            Value<String> languageCode = const Value.absent(),
          }) =>
              FaqsCompanion.insert(
            id: id,
            heading: heading,
            title: title,
            content: content,
            languageCode: languageCode,
          ),
        ));
}

class $$FaqsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $FaqsTable> {
  $$FaqsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get heading => $state.composableBuilder(
      column: $state.table.heading,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$FaqsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $FaqsTable> {
  $$FaqsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get heading => $state.composableBuilder(
      column: $state.table.heading,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$QuotesTableCreateCompanionBuilder = QuotesCompanion Function({
  Value<int> id,
  required String author,
  required String quote,
  Value<String> languageCode,
});
typedef $$QuotesTableUpdateCompanionBuilder = QuotesCompanion Function({
  Value<int> id,
  Value<String> author,
  Value<String> quote,
  Value<String> languageCode,
});

class $$QuotesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuotesTable,
    Quote,
    $$QuotesTableFilterComposer,
    $$QuotesTableOrderingComposer,
    $$QuotesTableCreateCompanionBuilder,
    $$QuotesTableUpdateCompanionBuilder> {
  $$QuotesTableTableManager(_$AppDatabase db, $QuotesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$QuotesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$QuotesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> author = const Value.absent(),
            Value<String> quote = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
          }) =>
              QuotesCompanion(
            id: id,
            author: author,
            quote: quote,
            languageCode: languageCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String author,
            required String quote,
            Value<String> languageCode = const Value.absent(),
          }) =>
              QuotesCompanion.insert(
            id: id,
            author: author,
            quote: quote,
            languageCode: languageCode,
          ),
        ));
}

class $$QuotesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get author => $state.composableBuilder(
      column: $state.table.author,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get quote => $state.composableBuilder(
      column: $state.table.quote,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$QuotesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get author => $state.composableBuilder(
      column: $state.table.author,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get quote => $state.composableBuilder(
      column: $state.table.quote,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ConfessionsTableCreateCompanionBuilder = ConfessionsCompanion
    Function({
  Value<int> id,
  Value<DateTime> date,
  Value<bool> isFinished,
  Value<DateTime?> finishedAt,
});
typedef $$ConfessionsTableUpdateCompanionBuilder = ConfessionsCompanion
    Function({
  Value<int> id,
  Value<DateTime> date,
  Value<bool> isFinished,
  Value<DateTime?> finishedAt,
});

class $$ConfessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConfessionsTable,
    Confession,
    $$ConfessionsTableFilterComposer,
    $$ConfessionsTableOrderingComposer,
    $$ConfessionsTableCreateCompanionBuilder,
    $$ConfessionsTableUpdateCompanionBuilder> {
  $$ConfessionsTableTableManager(_$AppDatabase db, $ConfessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ConfessionsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ConfessionsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime?> finishedAt = const Value.absent(),
          }) =>
              ConfessionsCompanion(
            id: id,
            date: date,
            isFinished: isFinished,
            finishedAt: finishedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<bool> isFinished = const Value.absent(),
            Value<DateTime?> finishedAt = const Value.absent(),
          }) =>
              ConfessionsCompanion.insert(
            id: id,
            date: date,
            isFinished: isFinished,
            finishedAt: finishedAt,
          ),
        ));
}

class $$ConfessionsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ConfessionsTable> {
  $$ConfessionsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isFinished => $state.composableBuilder(
      column: $state.table.isFinished,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get finishedAt => $state.composableBuilder(
      column: $state.table.finishedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter confessionItemsRefs(
      ComposableFilter Function($$ConfessionItemsTableFilterComposer f) f) {
    final $$ConfessionItemsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.confessionItems,
            getReferencedColumn: (t) => t.confessionId,
            builder: (joinBuilder, parentComposers) =>
                $$ConfessionItemsTableFilterComposer(ComposerState($state.db,
                    $state.db.confessionItems, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ConfessionsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ConfessionsTable> {
  $$ConfessionsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isFinished => $state.composableBuilder(
      column: $state.table.isFinished,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get finishedAt => $state.composableBuilder(
      column: $state.table.finishedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ConfessionItemsTableCreateCompanionBuilder = ConfessionItemsCompanion
    Function({
  Value<int> id,
  required int confessionId,
  required String content,
  Value<String?> note,
  Value<bool> isCustom,
  Value<int?> questionId,
});
typedef $$ConfessionItemsTableUpdateCompanionBuilder = ConfessionItemsCompanion
    Function({
  Value<int> id,
  Value<int> confessionId,
  Value<String> content,
  Value<String?> note,
  Value<bool> isCustom,
  Value<int?> questionId,
});

class $$ConfessionItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ConfessionItemsTable,
    ConfessionItem,
    $$ConfessionItemsTableFilterComposer,
    $$ConfessionItemsTableOrderingComposer,
    $$ConfessionItemsTableCreateCompanionBuilder,
    $$ConfessionItemsTableUpdateCompanionBuilder> {
  $$ConfessionItemsTableTableManager(
      _$AppDatabase db, $ConfessionItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ConfessionItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ConfessionItemsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> confessionId = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<bool> isCustom = const Value.absent(),
            Value<int?> questionId = const Value.absent(),
          }) =>
              ConfessionItemsCompanion(
            id: id,
            confessionId: confessionId,
            content: content,
            note: note,
            isCustom: isCustom,
            questionId: questionId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int confessionId,
            required String content,
            Value<String?> note = const Value.absent(),
            Value<bool> isCustom = const Value.absent(),
            Value<int?> questionId = const Value.absent(),
          }) =>
              ConfessionItemsCompanion.insert(
            id: id,
            confessionId: confessionId,
            content: content,
            note: note,
            isCustom: isCustom,
            questionId: questionId,
          ),
        ));
}

class $$ConfessionItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ConfessionItemsTable> {
  $$ConfessionItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get isCustom => $state.composableBuilder(
      column: $state.table.isCustom,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ConfessionsTableFilterComposer get confessionId {
    final $$ConfessionsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.confessionId,
        referencedTable: $state.db.confessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ConfessionsTableFilterComposer(ComposerState($state.db,
                $state.db.confessions, joinBuilder, parentComposers)));
    return composer;
  }

  $$ExaminationQuestionsTableFilterComposer get questionId {
    final $$ExaminationQuestionsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.questionId,
            referencedTable: $state.db.examinationQuestions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ExaminationQuestionsTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.examinationQuestions,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$ConfessionItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ConfessionItemsTable> {
  $$ConfessionItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get isCustom => $state.composableBuilder(
      column: $state.table.isCustom,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ConfessionsTableOrderingComposer get confessionId {
    final $$ConfessionsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.confessionId,
        referencedTable: $state.db.confessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ConfessionsTableOrderingComposer(ComposerState($state.db,
                $state.db.confessions, joinBuilder, parentComposers)));
    return composer;
  }

  $$ExaminationQuestionsTableOrderingComposer get questionId {
    final $$ExaminationQuestionsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.questionId,
            referencedTable: $state.db.examinationQuestions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ExaminationQuestionsTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.examinationQuestions,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

typedef $$UserSettingsTableCreateCompanionBuilder = UserSettingsCompanion
    Function({
  Value<int> id,
  required String key,
  required String value,
});
typedef $$UserSettingsTableUpdateCompanionBuilder = UserSettingsCompanion
    Function({
  Value<int> id,
  Value<String> key,
  Value<String> value,
});

class $$UserSettingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserSettingsTable,
    UserSetting,
    $$UserSettingsTableFilterComposer,
    $$UserSettingsTableOrderingComposer,
    $$UserSettingsTableCreateCompanionBuilder,
    $$UserSettingsTableUpdateCompanionBuilder> {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserSettingsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserSettingsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
          }) =>
              UserSettingsCompanion(
            id: id,
            key: key,
            value: value,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String key,
            required String value,
          }) =>
              UserSettingsCompanion.insert(
            id: id,
            key: key,
            value: value,
          ),
        ));
}

class $$UserSettingsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UserSettingsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get key => $state.composableBuilder(
      column: $state.table.key,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get value => $state.composableBuilder(
      column: $state.table.value,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$GuideItemsTableCreateCompanionBuilder = GuideItemsCompanion Function({
  Value<int> id,
  required String section,
  required String title,
  required String icon,
  required String content,
  required int displayOrder,
  required String languageCode,
});
typedef $$GuideItemsTableUpdateCompanionBuilder = GuideItemsCompanion Function({
  Value<int> id,
  Value<String> section,
  Value<String> title,
  Value<String> icon,
  Value<String> content,
  Value<int> displayOrder,
  Value<String> languageCode,
});

class $$GuideItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GuideItemsTable,
    GuideItem,
    $$GuideItemsTableFilterComposer,
    $$GuideItemsTableOrderingComposer,
    $$GuideItemsTableCreateCompanionBuilder,
    $$GuideItemsTableUpdateCompanionBuilder> {
  $$GuideItemsTableTableManager(_$AppDatabase db, $GuideItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$GuideItemsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$GuideItemsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> section = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
          }) =>
              GuideItemsCompanion(
            id: id,
            section: section,
            title: title,
            icon: icon,
            content: content,
            displayOrder: displayOrder,
            languageCode: languageCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String section,
            required String title,
            required String icon,
            required String content,
            required int displayOrder,
            required String languageCode,
          }) =>
              GuideItemsCompanion.insert(
            id: id,
            section: section,
            title: title,
            icon: icon,
            content: content,
            displayOrder: displayOrder,
            languageCode: languageCode,
          ),
        ));
}

class $$GuideItemsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $GuideItemsTable> {
  $$GuideItemsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get section => $state.composableBuilder(
      column: $state.table.section,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get icon => $state.composableBuilder(
      column: $state.table.icon,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get displayOrder => $state.composableBuilder(
      column: $state.table.displayOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$GuideItemsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $GuideItemsTable> {
  $$GuideItemsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get section => $state.composableBuilder(
      column: $state.table.section,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get icon => $state.composableBuilder(
      column: $state.table.icon,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get displayOrder => $state.composableBuilder(
      column: $state.table.displayOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PrayersTableCreateCompanionBuilder = PrayersCompanion Function({
  Value<int> id,
  required String title,
  required String content,
  required int displayOrder,
  required String languageCode,
});
typedef $$PrayersTableUpdateCompanionBuilder = PrayersCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> content,
  Value<int> displayOrder,
  Value<String> languageCode,
});

class $$PrayersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PrayersTable,
    Prayer,
    $$PrayersTableFilterComposer,
    $$PrayersTableOrderingComposer,
    $$PrayersTableCreateCompanionBuilder,
    $$PrayersTableUpdateCompanionBuilder> {
  $$PrayersTableTableManager(_$AppDatabase db, $PrayersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PrayersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PrayersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
          }) =>
              PrayersCompanion(
            id: id,
            title: title,
            content: content,
            displayOrder: displayOrder,
            languageCode: languageCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String content,
            required int displayOrder,
            required String languageCode,
          }) =>
              PrayersCompanion.insert(
            id: id,
            title: title,
            content: content,
            displayOrder: displayOrder,
            languageCode: languageCode,
          ),
        ));
}

class $$PrayersTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PrayersTable> {
  $$PrayersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get displayOrder => $state.composableBuilder(
      column: $state.table.displayOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PrayersTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PrayersTable> {
  $$PrayersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get displayOrder => $state.composableBuilder(
      column: $state.table.displayOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get languageCode => $state.composableBuilder(
      column: $state.table.languageCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UserCustomSinsTableCreateCompanionBuilder = UserCustomSinsCompanion
    Function({
  Value<int> id,
  required String sinText,
  Value<String?> note,
  Value<String?> commandmentCode,
  Value<int?> originalQuestionId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$UserCustomSinsTableUpdateCompanionBuilder = UserCustomSinsCompanion
    Function({
  Value<int> id,
  Value<String> sinText,
  Value<String?> note,
  Value<String?> commandmentCode,
  Value<int?> originalQuestionId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$UserCustomSinsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserCustomSinsTable,
    UserCustomSin,
    $$UserCustomSinsTableFilterComposer,
    $$UserCustomSinsTableOrderingComposer,
    $$UserCustomSinsTableCreateCompanionBuilder,
    $$UserCustomSinsTableUpdateCompanionBuilder> {
  $$UserCustomSinsTableTableManager(
      _$AppDatabase db, $UserCustomSinsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$UserCustomSinsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$UserCustomSinsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> sinText = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String?> commandmentCode = const Value.absent(),
            Value<int?> originalQuestionId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserCustomSinsCompanion(
            id: id,
            sinText: sinText,
            note: note,
            commandmentCode: commandmentCode,
            originalQuestionId: originalQuestionId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String sinText,
            Value<String?> note = const Value.absent(),
            Value<String?> commandmentCode = const Value.absent(),
            Value<int?> originalQuestionId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UserCustomSinsCompanion.insert(
            id: id,
            sinText: sinText,
            note: note,
            commandmentCode: commandmentCode,
            originalQuestionId: originalQuestionId,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
        ));
}

class $$UserCustomSinsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UserCustomSinsTable> {
  $$UserCustomSinsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get sinText => $state.composableBuilder(
      column: $state.table.sinText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get commandmentCode => $state.composableBuilder(
      column: $state.table.commandmentCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ExaminationQuestionsTableFilterComposer get originalQuestionId {
    final $$ExaminationQuestionsTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.originalQuestionId,
            referencedTable: $state.db.examinationQuestions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ExaminationQuestionsTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.examinationQuestions,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$UserCustomSinsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UserCustomSinsTable> {
  $$UserCustomSinsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get sinText => $state.composableBuilder(
      column: $state.table.sinText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get commandmentCode => $state.composableBuilder(
      column: $state.table.commandmentCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ExaminationQuestionsTableOrderingComposer get originalQuestionId {
    final $$ExaminationQuestionsTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.originalQuestionId,
            referencedTable: $state.db.examinationQuestions,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$ExaminationQuestionsTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.examinationQuestions,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CommandmentsTableTableManager get commandments =>
      $$CommandmentsTableTableManager(_db, _db.commandments);
  $$ExaminationQuestionsTableTableManager get examinationQuestions =>
      $$ExaminationQuestionsTableTableManager(_db, _db.examinationQuestions);
  $$FaqsTableTableManager get faqs => $$FaqsTableTableManager(_db, _db.faqs);
  $$QuotesTableTableManager get quotes =>
      $$QuotesTableTableManager(_db, _db.quotes);
  $$ConfessionsTableTableManager get confessions =>
      $$ConfessionsTableTableManager(_db, _db.confessions);
  $$ConfessionItemsTableTableManager get confessionItems =>
      $$ConfessionItemsTableTableManager(_db, _db.confessionItems);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
  $$GuideItemsTableTableManager get guideItems =>
      $$GuideItemsTableTableManager(_db, _db.guideItems);
  $$PrayersTableTableManager get prayers =>
      $$PrayersTableTableManager(_db, _db.prayers);
  $$UserCustomSinsTableTableManager get userCustomSins =>
      $$UserCustomSinsTableTableManager(_db, _db.userCustomSins);
}
