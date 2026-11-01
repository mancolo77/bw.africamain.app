import 'package:flutter/material.dart';
import '../../services/user_progress_service.dart';
import '../../theme/app_theme.dart';

class BadgeItem {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  const BadgeItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  final List<BadgeItem> _badges = const [
    BadgeItem(
      id: 'badge_starter',
      title: 'Спортивный старт',
      description: 'Первое посещение спортивного матч-центра',
      icon: Icons.sports_rounded,
    ),
    BadgeItem(
      id: 'badge_quiz_1',
      title: 'Интеллектуал',
      description: 'Успешный ответ на вопрос блиц-викторины',
      icon: Icons.lightbulb_rounded,
    ),
    BadgeItem(
      id: 'badge_reader',
      title: 'Читатель',
      description: 'Материал добавлен в список для изучения',
      icon: Icons.bookmark_added_rounded,
    ),
    BadgeItem(
      id: 'badge_fan',
      title: 'Болельщик',
      description: 'Два спортивных матча добавлены в избранное',
      icon: Icons.star_rounded,
    ),
    BadgeItem(
      id: 'badge_amateur',
      title: 'Любитель спорта',
      description: 'Набрано более 300 баллов активности',
      icon: Icons.military_tech_rounded,
    ),
    BadgeItem(
      id: 'badge_expert',
      title: 'Спортивный Эксперт',
      description: 'Высший 3 уровень спортивной эрудиции',
      icon: Icons.workspace_premium_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final progress = UserProgressService();

    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(AppTheme.screenPadding, 16, AppTheme.screenPadding, 16),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Text(
                'Мой прогресс',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Уровни участника, активность и виртуальные значки',
                style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 20),

              // 1. Уровень участника
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: AppTheme.border),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppTheme.accentYellow.withAlpha(30),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.accentYellow, width: 2),
                          ),
                          child: const Center(
                            child: Icon(Icons.emoji_events_rounded, color: AppTheme.primary, size: 30),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'УРОВЕНЬ ${progress.levelNumber} ИЗ 3',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                progress.levelName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${progress.points} баллов активности',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                          ),
                        ),
                        Text(
                          progress.levelNumber < 3 ? 'До след. уровня: 700' : 'Максимальный ранг',
                          style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress.levelProgress,
                        minHeight: 10,
                        backgroundColor: AppTheme.surfaceSecondary,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.accentYellow),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Сводка показателей
              const Text(
                'Сводка активности',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Викторины',
                      value: '${progress.quizzesCompleted}',
                      icon: Icons.quiz_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Сохранено статей',
                      value: '${progress.savedArticleIds.length}',
                      icon: Icons.bookmark_rounded,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Матчи в избранном',
                      value: '${progress.favoriteMatchIds.length}',
                      icon: Icons.star_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 3. Виртуальные значки
              const Text(
                'Виртуальные значки',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textMain,
                ),
              ),
              const SizedBox(height: 12),
              ..._badges.map((badge) {
                final isUnlocked = progress.unlockedBadges.contains(badge.id);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceCard,
                    borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                    border: Border.all(
                      color: isUnlocked ? AppTheme.accentYellow : AppTheme.border,
                      width: isUnlocked ? 1.5 : 1.0,
                    ),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: isUnlocked ? AppTheme.accentYellow.withAlpha(25) : AppTheme.surfaceSecondary,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isUnlocked ? AppTheme.accentYellow : AppTheme.border,
                          ),
                        ),
                        child: Icon(
                          badge.icon,
                          color: isUnlocked ? AppTheme.primary : AppTheme.textSecondary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              badge.title,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textMain,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              badge.description,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isUnlocked)
                        const Icon(Icons.check_circle_rounded, color: AppTheme.primary, size: 22)
                      else
                        const Icon(Icons.lock_outline_rounded, color: AppTheme.textSecondary, size: 20),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),

              // 4. Дисклеймер
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                  border: Border.all(color: AppTheme.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline_rounded, color: AppTheme.primary, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Баллы отражают только личную активность, их нельзя покупать, передавать или обменивать. Приложение создано для любителей спорта.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        border: Border.all(color: AppTheme.border),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primary, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textMain,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

