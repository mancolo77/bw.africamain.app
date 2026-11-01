import 'package:flutter/material.dart';
import '../../services/user_progress_service.dart';
import '../../theme/app_theme.dart';

class MatchData {
  final String id;
  final String sport;
  final String tournament;
  final String date;
  final String time;
  final String teamA;
  final String teamB;
  final String? score;
  final bool isLive;

  const MatchData({
    required this.id,
    required this.sport,
    required this.tournament,
    required this.date,
    required this.time,
    required this.teamA,
    required this.teamB,
    this.score,
    this.isLive = false,
  });
}

class MatchesTab extends StatefulWidget {
  const MatchesTab({super.key});

  @override
  State<MatchesTab> createState() => _MatchesTabState();
}

class _MatchesTabState extends State<MatchesTab> {
  final UserProgressService _progress = UserProgressService();
  String _selectedSport = 'Все';
  String _searchQuery = '';
  final List<String> _sports = ['Все', 'Футбол', 'Хоккей', 'Баскетбол', 'Теннис'];

  final List<MatchData> _matches = const [
    MatchData(
      id: 'leo_m_1',
      sport: 'Футбол',
      tournament: 'Чемпионат России',
      date: 'Сегодня',
      time: '19:00',
      teamA: 'Спартак',
      teamB: 'Зенит',
      score: '1 : 2',
      isLive: true,
    ),
    MatchData(
      id: 'leo_m_2',
      sport: 'Теннис',
      tournament: 'Турнир серии Мастерс',
      date: 'Сегодня',
      time: '20:30',
      teamA: 'Д. Медведев',
      teamB: 'К. Алькарас',
      score: '6:4, 3:6, 7:6',
      isLive: false,
    ),
    MatchData(
      id: 'leo_m_3',
      sport: 'Хоккей',
      tournament: 'Регулярный сезон',
      date: 'Завтра',
      time: '17:00',
      teamA: 'ЦСКА',
      teamB: 'Локомотив',
      score: null,
      isLive: false,
    ),
    MatchData(
      id: 'leo_m_4',
      sport: 'Футбол',
      tournament: 'Кубок',
      date: 'Завтра',
      time: '19:45',
      teamA: 'Краснодар',
      teamB: 'Динамо',
      score: null,
      isLive: false,
    ),
    MatchData(
      id: 'leo_m_5',
      sport: 'Теннис',
      tournament: 'Четвертьфинал',
      date: 'Вчера',
      time: '16:00',
      teamA: 'А. Рублев',
      teamB: 'Я. Синнер',
      score: '4:6, 5:7',
      isLive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _matches.where((m) {
      if (_selectedSport != 'Все' && m.sport != _selectedSport) return false;
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        return m.teamA.toLowerCase().contains(query) ||
            m.teamB.toLowerCase().contains(query) ||
            m.tournament.toLowerCase().contains(query);
      }
      return true;
    }).toList();

    return AnimatedBuilder(
      animation: _progress,
      builder: (context, _) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(AppTheme.screenPadding, 16, AppTheme.screenPadding, 16),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Матчи',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textMain,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: const Text(
                      'Пример',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Календарь встреч, результаты и поиск по участникам',
                style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 16),

              // Поисковая строка (#EEF0F2)
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surfaceSecondary,
                  borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                ),
                child: TextField(
                  onChanged: (val) => setState(() => _searchQuery = val),
                  style: const TextStyle(color: AppTheme.textMain, fontSize: 15),
                  decoration: const InputDecoration(
                    hintText: 'Поиск команды или турнира...',
                    hintStyle: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                    prefixIcon: Icon(Icons.search_rounded, color: AppTheme.primary),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Фильтры по видам спорта
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _sports.map((sport) {
                    final isSelected = _selectedSport == sport;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(sport),
                        selected: isSelected,
                        onSelected: (val) {
                          if (val) setState(() => _selectedSport = sport);
                        },
                        selectedColor: AppTheme.primary,
                        backgroundColor: AppTheme.surfaceCard,
                        labelStyle: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? Colors.white : AppTheme.textSecondary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppTheme.buttonRadius),
                          side: BorderSide(
                            color: isSelected ? AppTheme.primary : AppTheme.border,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 18),

              // Список матчей
              if (filtered.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: const [
                      Icon(Icons.search_off_rounded, size: 48, color: AppTheme.textSecondary),
                      SizedBox(height: 12),
                      Text(
                        'Ничего не найдено',
                        style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                      ),
                    ],
                  ),
                )
              else
                ...filtered.map((match) {
                  final isFav = _progress.favoriteMatchIds.contains(match.id);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(AppTheme.cardRadius),
                      border: Border.all(
                        color: match.isLive ? AppTheme.primary : AppTheme.border,
                        width: match.isLive ? 1.5 : 1.0,
                      ),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  match.tournament,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceSecondary,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Пример',
                                    style: TextStyle(fontSize: 10, color: AppTheme.textSecondary),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                isFav ? Icons.star_rounded : Icons.star_border_rounded,
                                color: isFav ? AppTheme.accentYellow : AppTheme.textSecondary,
                                size: 22,
                              ),
                              onPressed: () => _progress.toggleFavoriteMatch(match.id),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                match.teamA,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMain,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  if (match.score != null)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: match.isLive ? AppTheme.primary : AppTheme.surfaceSecondary,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        match.score!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: match.isLive ? Colors.white : AppTheme.textMain,
                                        ),
                                      ),
                                    )
                                  else
                                    Text(
                                      match.time,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textMain,
                                      ),
                                    ),
                                  const SizedBox(height: 4),
                                  Text(
                                    match.isLive ? 'LIVE' : match.date,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: match.isLive ? AppTheme.primary : AppTheme.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                match.teamB,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textMain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
            ],
          ),
        ),
      );
    },
    );
  }
}

