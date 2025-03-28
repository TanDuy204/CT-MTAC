import 'package:flutter/material.dart';
import 'package:partner/views/calendar/calendar_screen.dart';
import 'package:partner/views/home/home_screen.dart';
import 'package:partner/views/notifications/notification_screen.dart';
import 'package:partner/views/person/person_screen.dart';
import 'package:partner/views/time/time_screen.dart';

class BottomNavigationBars extends StatefulWidget {
  const BottomNavigationBars({super.key});

  @override
  State<BottomNavigationBars> createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CalendarScreen(),
    const TimeScreen(),
    const NotificationScreen(),
    const PersonScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 80),
              painter: BNBCustomPainer(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => _onItemTapped(1),
                    icon: Icon(Icons.calendar_today,
                        color: _currentIndex == 1 ? Colors.blue :  Color(0xFF787486)),
                  ),
                  IconButton(
                    onPressed: () => _onItemTapped(2),
                    icon: Icon(Icons.timer_outlined,
                        color: _currentIndex == 2 ? Colors.blue :  Color(0xFF787486)),
                  ),
                  Container(
                    width: 50,
                  ),
                  IconButton(
                    onPressed: () => _onItemTapped(3),
                    icon: Icon(Icons.notifications_none_outlined,
                        color: _currentIndex == 3 ? Colors.blue :  Color(0xFF787486)),
                  ),
                  IconButton(
                    onPressed: () => _onItemTapped(4),
                    icon: Icon(Icons.person_outline,
                        color: _currentIndex == 4 ? Colors.blue : Color(0xFF787486)),
                  ),
                ],
              ),
            ),
            Center(
              heightFactor: 0.8,
              child: FloatingActionButton(
                onPressed: () => _onItemTapped(0),
                backgroundColor: Color(0xFF3E9AFE).withOpacity(0.47),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
                child: Icon(
                  Icons.home_outlined,
                  size: 35,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BNBCustomPainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black.withOpacity(0.7), 30, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
