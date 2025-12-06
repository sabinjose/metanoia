import 'dart:convert';

import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Model for prayers content
class PrayersContent {
  final String subtitle;
  final List<PrayerCategory> categories;

  PrayersContent({
    required this.subtitle,
    required this.categories,
  });

  factory PrayersContent.fromJson(Map<String, dynamic> json) {
    return PrayersContent(
      subtitle: json['subtitle'] as String,
      categories: (json['categories'] as List)
          .map((c) => PrayerCategory.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PrayerCategory {
  final String id;
  final String title;
  final String icon;
  final List<PrayerItem> prayers;

  PrayerCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.prayers,
  });

  factory PrayerCategory.fromJson(Map<String, dynamic> json) {
    return PrayerCategory(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
      prayers: (json['prayers'] as List)
          .map((p) => PrayerItem.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }
}

class PrayerItem {
  final String id;
  final String title;
  final String? subtitle;
  final String icon;
  final String? content;
  final bool isExpandable;
  final List<PrayerSection>? sections;

  PrayerItem({
    required this.id,
    required this.title,
    this.subtitle,
    required this.icon,
    this.content,
    this.isExpandable = false,
    this.sections,
  });

  factory PrayerItem.fromJson(Map<String, dynamic> json) {
    return PrayerItem(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      icon: json['icon'] as String,
      content: json['content'] as String?,
      isExpandable: json['isExpandable'] as bool? ?? false,
      sections: json['sections'] != null
          ? (json['sections'] as List)
              .map((s) => PrayerSection.fromJson(s as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

class PrayerSection {
  final String title;
  final String? subtitle;
  final String content;

  PrayerSection({
    required this.title,
    this.subtitle,
    required this.content,
  });

  factory PrayerSection.fromJson(Map<String, dynamic> json) {
    return PrayerSection(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      content: json['content'] as String,
    );
  }
}

/// Provider for prayers content based on content language
final prayersContentProvider =
    FutureProvider.autoDispose<PrayersContent>((ref) async {
  final contentLanguage =
      await ref.watch(contentLanguageControllerProvider.future);
  final languageCode = contentLanguage.languageCode;

  final jsonString = await rootBundle.loadString(
    'assets/data/prayers/prayers_$languageCode.json',
  );
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  return PrayersContent.fromJson(json);
});

/// A beautifully designed prayers screen with categorized prayers
class PrayersScreen extends ConsumerWidget {
  const PrayersScreen({super.key});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'church_outlined':
        return Icons.church_outlined;
      case 'auto_awesome_outlined':
        return Icons.auto_awesome_outlined;
      case 'favorite_border':
        return Icons.favorite_border;
      case 'self_improvement':
        return Icons.self_improvement;
      case 'brightness_7_outlined':
        return Icons.brightness_7_outlined;
      case 'wb_twilight_outlined':
        return Icons.wb_twilight_outlined;
      case 'favorite_outline':
        return Icons.favorite_outline;
      case 'light_mode_outlined':
        return Icons.light_mode_outlined;
      case 'person_outline':
        return Icons.person_outline;
      case 'cloud_outlined':
        return Icons.cloud_outlined;
      case 'star_outline':
        return Icons.star_outline;
      case 'brightness_high_outlined':
        return Icons.brightness_high_outlined;
      case 'menu_book_outlined':
        return Icons.menu_book_outlined;
      case 'volunteer_activism_outlined':
        return Icons.volunteer_activism_outlined;
      case 'flare_outlined':
        return Icons.flare_outlined;
      case 'all_inclusive':
        return Icons.all_inclusive;
      case 'water_drop_outlined':
        return Icons.water_drop_outlined;
      case 'shield_outlined':
        return Icons.shield_outlined;
      default:
        return Icons.auto_stories_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final contentAsync = ref.watch(prayersContentProvider);

    return Scaffold(
      body: contentAsync.when(
        data: (content) => _buildContent(context, content, theme, l10n),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('${l10n.error}: $error'),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrayersContent content,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          floating: false,
          pinned: true,
          elevation: 0,
          scrolledUnderElevation: 1,
          backgroundColor: theme.scaffoldBackgroundColor,
          surfaceTintColor: theme.colorScheme.primary,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: theme.colorScheme.onSurface,
              semanticLabel: 'Go back',
            ),
            onPressed: () {
              HapticUtils.lightImpact();
              context.pop();
            },
          ),
        ),

        // Header section with icon and subtitle
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_stories_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                    semanticLabel: 'Prayers',
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  content.subtitle,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamilyEBGaramond,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Prayer categories
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, categoryIndex) {
                final category = content.categories[categoryIndex];
                return _buildCategorySection(
                  context,
                  category,
                  theme,
                  categoryIndex,
                );
              },
              childCount: content.categories.length,
            ),
          ),
        ),

        // Bottom padding
        const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
      ],
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    PrayerCategory category,
    ThemeData theme,
    int categoryIndex,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category heading
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16, left: 4),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                _getIconData(category.icon),
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  category.title,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamilyEBGaramond,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: (50 * categoryIndex).ms),

        // Prayers in this category
        ...category.prayers.asMap().entries.map((entry) {
          final prayerIndex = entry.key;
          final prayer = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildPrayerCard(context, prayer, theme, prayerIndex),
          );
        }),

        // Spacing between categories
        if (categoryIndex < 4) const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPrayerCard(
    BuildContext context,
    PrayerItem prayer,
    ThemeData theme,
    int index,
  ) {
    // For expandable prayers with sections (like Rosary)
    if (prayer.sections != null && prayer.sections!.isNotEmpty) {
      return _ExpandablePrayerCard(
        prayer: prayer,
        theme: theme,
        getIconData: _getIconData,
      ).animate().fadeIn(delay: (80 * (index < 6 ? index : 6)).ms).slideY(begin: 0.05, end: 0);
    }

    // For regular prayers
    return _RegularPrayerCard(
      prayer: prayer,
      theme: theme,
      getIconData: _getIconData,
      isExpandable: prayer.isExpandable,
    ).animate().fadeIn(delay: (80 * (index < 6 ? index : 6)).ms).slideY(begin: 0.05, end: 0);
  }
}

/// A regular prayer card that can optionally be expanded
class _RegularPrayerCard extends StatefulWidget {
  final PrayerItem prayer;
  final ThemeData theme;
  final IconData Function(String) getIconData;
  final bool isExpandable;

  const _RegularPrayerCard({
    required this.prayer,
    required this.theme,
    required this.getIconData,
    this.isExpandable = false,
  });

  @override
  State<_RegularPrayerCard> createState() => _RegularPrayerCardState();
}

class _RegularPrayerCardState extends State<_RegularPrayerCard> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    // Non-expandable prayers start expanded (show content)
    _isExpanded = !widget.isExpandable;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: widget.theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: widget.theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: widget.isExpandable
            ? () {
                HapticUtils.lightImpact();
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            : null,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.getIconData(widget.prayer.icon),
                      size: 24,
                      color: widget.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.prayer.title,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamilyLato,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.theme.colorScheme.onSurface,
                          ),
                        ),
                        if (widget.prayer.subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            widget.prayer.subtitle!,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamilyEBGaramond,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: widget.theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (widget.isExpandable)
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.expand_more,
                        color: widget.theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),

              // Content
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: _buildFormattedContent(
                    widget.prayer.content ?? '',
                    widget.theme,
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormattedContent(String content, ThemeData theme) {
    final lines = content.split('\n');
    final List<Widget> widgets = [];

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 12));
        continue;
      }

      // Check for special formatting
      if (line.contains('[RUBRIC]')) {
        final rubricText = line
            .replaceAll('[RUBRIC]', '')
            .replaceAll('[/RUBRIC]', '')
            .trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              rubricText,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyLato,
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.error.withValues(alpha: 0.8),
              ),
            ),
          ),
        );
      } else if (line.contains('[PRAYER]')) {
        final prayerText = line
            .replaceAll('[PRAYER]', '')
            .replaceAll('[/PRAYER]', '')
            .trim();
        widgets.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border(
                left: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 3,
                ),
              ),
            ),
            child: Text(
              prayerText,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyEBGaramond,
                fontSize: 16,
                fontStyle: FontStyle.italic,
                height: 1.7,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        );
      } else if (line.contains('[VERSICLE]')) {
        final versicleText = line
            .replaceAll('[VERSICLE]', '')
            .replaceAll('[/VERSICLE]', '')
            .trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              versicleText,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyLato,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        );
      } else if (line.contains('[RESPONSE]')) {
        final responseText = line
            .replaceAll('[RESPONSE]', '')
            .replaceAll('[/RESPONSE]', '')
            .trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              responseText,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyLato,
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        );
      } else if (line.trim() == 'Amen.') {
        // Style "Amen" specially
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              line,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyEBGaramond,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        );
      } else {
        // Regular prayer text
        widgets.add(
          Text(
            line,
            style: TextStyle(
              fontFamily: AppTheme.fontFamilyEBGaramond,
              fontSize: 16,
              height: 1.7,
              color: theme.colorScheme.onSurface,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

/// An expandable prayer card for long prayers with sections (like Rosary)
class _ExpandablePrayerCard extends StatefulWidget {
  final PrayerItem prayer;
  final ThemeData theme;
  final IconData Function(String) getIconData;

  const _ExpandablePrayerCard({
    required this.prayer,
    required this.theme,
    required this.getIconData,
  });

  @override
  State<_ExpandablePrayerCard> createState() => _ExpandablePrayerCardState();
}

class _ExpandablePrayerCardState extends State<_ExpandablePrayerCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: widget.theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: widget.theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header (always visible, tappable)
          InkWell(
            onTap: () {
              HapticUtils.lightImpact();
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.theme.colorScheme.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.getIconData(widget.prayer.icon),
                      size: 24,
                      color: widget.theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.prayer.title,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamilyLato,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: widget.theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _isExpanded ? 'Tap to collapse' : 'Tap to expand',
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamilyLato,
                            fontSize: 13,
                            color: widget.theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.expand_more,
                      color: widget.theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sections (expandable)
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                children: widget.prayer.sections!.asMap().entries.map((entry) {
                  final sectionIndex = entry.key;
                  final section = entry.value;
                  return _buildSection(section, sectionIndex);
                }).toList(),
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(PrayerSection section, int index) {
    return Container(
      margin: EdgeInsets.only(top: index == 0 ? 0 : 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Text(
            section.title,
            style: TextStyle(
              fontFamily: AppTheme.fontFamilyLato,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.theme.colorScheme.onSurface,
            ),
          ),
          if (section.subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              section.subtitle!,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyEBGaramond,
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: widget.theme.colorScheme.primary,
              ),
            ),
          ],
          const SizedBox(height: 12),
          // Section content
          _buildSectionContent(section.content),
        ],
      ),
    );
  }

  Widget _buildSectionContent(String content) {
    final lines = content.split('\n');
    final List<Widget> widgets = [];

    for (final line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(const SizedBox(height: 8));
        continue;
      }

      // Check for special formatting
      if (line.contains('[RUBRIC]')) {
        final rubricText = line
            .replaceAll('[RUBRIC]', '')
            .replaceAll('[/RUBRIC]', '')
            .trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              rubricText,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyLato,
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: widget.theme.colorScheme.error.withValues(alpha: 0.8),
              ),
            ),
          ),
        );
      } else if (line.contains('[PRAYER]')) {
        final prayerText = line
            .replaceAll('[PRAYER]', '')
            .replaceAll('[/PRAYER]', '')
            .trim();
        widgets.add(
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border(
                left: BorderSide(
                  color: widget.theme.colorScheme.primary,
                  width: 3,
                ),
              ),
            ),
            child: Text(
              prayerText,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyEBGaramond,
                fontSize: 15,
                fontStyle: FontStyle.italic,
                height: 1.6,
                color: widget.theme.colorScheme.onSurface,
              ),
            ),
          ),
        );
      } else if (RegExp(r'^\d+\.').hasMatch(line.trim())) {
        // Numbered list item
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              line,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyLato,
                fontSize: 15,
                height: 1.5,
                color: widget.theme.colorScheme.onSurface,
              ),
            ),
          ),
        );
      } else {
        // Regular text
        widgets.add(
          Text(
            line,
            style: TextStyle(
              fontFamily: AppTheme.fontFamilyLato,
              fontSize: 15,
              height: 1.6,
              color: widget.theme.colorScheme.onSurface,
            ),
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
