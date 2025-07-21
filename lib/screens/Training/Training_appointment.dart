import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinic Appointment',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const AppointmentScreen(),
    );
  }
}

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  // The actual date selected by the user for the appointment
  DateTime? _selectedAppointmentDate = DateTime(2025, 7, 24);

  // The month currently displayed in the calendar widget
  late DateTime _displayedMonth;

  final TextEditingController _serviceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize _displayedMonth to the first day of the month of the selected appointment date
    _displayedMonth = DateTime(
      _selectedAppointmentDate!.year,
      _selectedAppointmentDate!.month,
      1,
    );
  }

  @override
  void dispose() {
    _serviceController.dispose();
    super.dispose();
  }

  String _monthName(int month) {
    const List<String> monthNames = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month];
  }

  Widget _buildDateCell(DateTime date) {
    final bool isThisDateSelected =
        _selectedAppointmentDate != null &&
        _selectedAppointmentDate!.year == date.year &&
        _selectedAppointmentDate!.month == date.month &&
        _selectedAppointmentDate!.day == date.day;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAppointmentDate = date; // Update the full DateTime object
        });
        debugPrint('Selected date: $_selectedAppointmentDate');
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: isThisDateSelected
            ? const BoxDecoration(color: Colors.orange, shape: BoxShape.circle)
            : null,
        child: Center(
          child: Text(
            '${date.day}', // Display only the day number
            style: TextStyle(
              color: isThisDateSelected ? Colors.white : Colors.black,
              fontWeight: isThisDateSelected
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  List<TableRow> _buildCalendarGrid() {
    final List<TableRow> rows = [];
    final DateTime firstDayOfDisplayedMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month,
      1,
    );
    final int daysInMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month + 1,
      0,
    ).day;

    // Flutter's DateTime.weekday: Monday = 1, Sunday = 7.
    // We want Sunday to be the first day of the week (index 0).
    // So, adjust: 1 (Mon) -> 1, ..., 6 (Sat) -> 6, 7 (Sun) -> 0.
    final int firstWeekdayOffset =
        firstDayOfDisplayedMonth.weekday %
        7; // 0 for Sunday, 1 for Monday, etc.

    final List<Widget> dayCells = [];

    // Add leading empty cells for days before the 1st of the month
    for (int i = 0; i < firstWeekdayOffset; i++) {
      dayCells.add(
        const SizedBox.shrink(),
      ); // Use SizedBox.shrink for empty cells
    }

    // Add day cells for the current month
    for (int day = 1; day <= daysInMonth; day++) {
      dayCells.add(
        _buildDateCell(
          DateTime(_displayedMonth.year, _displayedMonth.month, day),
        ),
      );
    }

    // Pad with trailing empty cells to complete the last row if necessary
    while (dayCells.length % 7 != 0) {
      dayCells.add(const SizedBox.shrink());
    }

    // Group cells into rows (7 cells per row)
    for (int i = 0; i < dayCells.length; i += 7) {
      rows.add(TableRow(children: dayCells.sublist(i, i + 7)));
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Section
              const Text(
                'Service',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _serviceController,
                decoration: InputDecoration(
                  hintText: 'Select Service',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Select Date Section
              const Text(
                'Select date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(
                        (Colors.grey.alpha * 0.1).round(),
                      ),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              _displayedMonth = DateTime(
                                _displayedMonth.year,
                                _displayedMonth.month - 1,
                                1, // Set to day 1 for the new month
                              );
                            });
                          },
                        ),
                        Text(
                          '${_monthName(_displayedMonth.month)} ${_displayedMonth.year}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            setState(() {
                              _displayedMonth = DateTime(
                                _displayedMonth.year,
                                _displayedMonth.month + 1,
                                1, // Set to day 1 for the new month
                              );
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Table(
                      children: <TableRow>[
                        // Day of the week headers
                        TableRow(
                          children: ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa']
                              .map<Widget>(
                                (day) => Center(
                                  child: Text(
                                    day,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        // Dynamically generated calendar rows
                        ..._buildCalendarGrid(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Select Time Section
              const Text(
                'Select time',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'e.g., 10:00 AM - 11:00 AM',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              const SizedBox(height: 32),

              // Confirm Appointment Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle confirm appointment logic
                    debugPrint('Confirm Appointment pressed!');
                    debugPrint('Service: ${_serviceController.text}');
                    debugPrint('Selected Date: $_selectedAppointmentDate');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirm appointment',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: const Icon(Icons.home), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () {},
            ),
            const SizedBox(
              width: 48,
            ), // The space for the floating action button
            IconButton(icon: const Icon(Icons.shopping_bag), onPressed: () {}),
            IconButton(icon: const Icon(Icons.person), onPressed: () {}),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the plus button action
        },
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 2.0,
        child: const Icon(Icons.add),
      ),
    );
  }
}
