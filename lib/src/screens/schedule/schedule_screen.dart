import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _selectedDate = DateTime.now();

  // نموذج بسيط للمهام
  final Map<String, List<_ScheduleItem>> _itemsByDate = {
    // مفتاح الخريطة هو التاريخ بصيغة yyyy-MM-dd
  };

  @override
  void initState() {
    super.initState();
    _seedExampleData();
  }

  void _seedExampleData() {
    final todayKey = _dateKey(DateTime.now());
    _itemsByDate[todayKey] = [
      _ScheduleItem(
        title: 'Advanced Mathematics',
        subtitle: 'Room 204, Building A',
        start: const TimeOfDay(hour: 9, minute: 0),
        end: const TimeOfDay(hour: 10, minute: 30),
        tag: 'Ongoing',
        tagColor: const Color(0xFF2563EB),
      ),
      _ScheduleItem(
        title: 'Physics Lab',
        subtitle: 'Lab 3, Science Building',
        start: const TimeOfDay(hour: 11, minute: 0),
        end: const TimeOfDay(hour: 12, minute: 30),
        tag: 'Upcoming',
        tagColor: const Color(0xFFF59E0B),
      ),
      _ScheduleItem(
        title: 'Chemistry Review',
        subtitle: 'Room 12',
        start: const TimeOfDay(hour: 13, minute: 0),
        end: const TimeOfDay(hour: 14, minute: 0),
        tag: 'Personal',
        tagColor: const Color(0xFF10B981),
      ),
    ];
  }

  String _dateKey(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  List<_ScheduleItem> get _itemsForSelected {
    return _itemsByDate[_dateKey(_selectedDate)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final monthText = DateFormat.yMMMM().format(_selectedDate);

    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F3F8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'My Schedule',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2563EB),
        onPressed: _showAddItemSheet,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بطاقة التقويم
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // شريط الشهر والأزرار
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.chevron_left,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime(
                                _selectedDate.year,
                                _selectedDate.month - 1,
                                _selectedDate.day,
                              );
                            });
                          },
                        ),
                        Column(
                          children: [
                            Text(
                              monthText,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Select a date',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.chevron_right,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedDate = DateTime(
                                _selectedDate.year,
                                _selectedDate.month + 1,
                                _selectedDate.day,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // شريط أيام الأسبوع + الأيام
                    _buildWeekDays(),
                    const SizedBox(height: 8),
                    _buildDaysRow(),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Today's Schedule",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: _itemsForSelected.isEmpty
                    ? const Center(
                        child: Text(
                          'No events for this day.\nTap + to add one.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _itemsForSelected.length,
                        itemBuilder: (context, index) {
                          final item = _itemsForSelected[index];
                          return _ScheduleCard(item: item);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeekDays() {
    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels
          .map(
            (l) => Expanded(
              child: Center(
                child: Text(
                  l,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDaysRow() {
    // نعرض أسبوع حول التاريخ المختار
    final startOfWeek =
        _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final day = startOfWeek.add(Duration(days: index));
        final isSelected = _isSameDay(day, _selectedDate);

        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = day;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF2563EB)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  Future<void> _showAddItemSheet() async {
    final titleCtrl = TextEditingController();
    final subtitleCtrl = TextEditingController();
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setStateSheet) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add Reminder',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    controller: subtitleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Location / notes',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () async {
                            final res = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (res != null) {
                              setStateSheet(() {
                                startTime = res;
                              });
                            }
                          },
                          icon: const Icon(Icons.schedule),
                          label: Text(
                            startTime == null
                                ? 'Start time'
                                : startTime!.format(context),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () async {
                            final res = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (res != null) {
                              setStateSheet(() {
                                endTime = res;
                              });
                            }
                          },
                          icon: const Icon(Icons.schedule_outlined),
                          label: Text(
                            endTime == null
                                ? 'End time'
                                : endTime!.format(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        if (titleCtrl.text.trim().isEmpty ||
                            startTime == null ||
                            endTime == null) {
                          return;
                        }
                        final list =
                            _itemsByDate[_dateKey(_selectedDate)] ?? [];
                        list.add(
                          _ScheduleItem(
                            title: titleCtrl.text.trim(),
                            subtitle: subtitleCtrl.text.trim(),
                            start: startTime!,
                            end: endTime!,
                            tag: 'Reminder',
                            tagColor: const Color(0xFF10B981),
                          ),
                        );
                        _itemsByDate[_dateKey(_selectedDate)] = list;
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class _ScheduleItem {
  final String title;
  final String subtitle;
  final TimeOfDay start;
  final TimeOfDay end;
  final String tag;
  final Color tagColor;

  _ScheduleItem({
    required this.title,
    required this.subtitle,
    required this.start,
    required this.end,
    required this.tag,
    required this.tagColor,
  });
}

class _ScheduleCard extends StatelessWidget {
  final _ScheduleItem item;

  const _ScheduleCard({required this.item});

  String _formatTimeRange(BuildContext context) {
    return '${item.start.format(context)} - ${item.end.format(context)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الوقت على اليسار
          SizedBox(
            width: 60,
            child: Text(
              item.start.format(context),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border(
                  left: BorderSide(
                    color: item.tagColor,
                    width: 4,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان + التاج
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: item.tagColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.tag,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: item.tagColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTimeRange(context),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
