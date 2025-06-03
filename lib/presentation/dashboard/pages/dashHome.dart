import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:steet/presentation/dashboard/pages/prvRoomsPage.dart';
import 'package:steet/presentation/dashboard/pages/pubRoomsPage.dart';
import 'package:steet/presentation/dashboard/pages/studentsPage.dart';
import 'package:steet/presentation/dashboard/widgets/line_chart_card.dart';
import 'package:steet/presentation/providers/DashboardProvider.dart';
import 'package:steet/presentation/dashboard/widgets/stat_card.dart';

class DashHome extends ConsumerStatefulWidget {
  const DashHome({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashHomeState();
}

class _DashHomeState extends ConsumerState<DashHome> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardProvider.notifier).getStudentCount();
      ref.read(dashboardProvider.notifier).fetchPrvRooms();
      ref.read(dashboardProvider.notifier).fetchPubRooms();
      ref.read(dashboardProvider.notifier).fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardProvider);
    final pubRooms = dashboardState.pubRooms;
    final prvRooms = dashboardState.prvRooms;
    final students = dashboardState.students;
    final countedStudents = 50;
    // final countedStudents = dashboardState.studentCount;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  StatCard(
              icon: Icons.public,
              iconColor: Colors.blue,
              value: '${pubRooms.length}',
              label: 'Total Public Rooms', 
              onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PublicRoomsPage(),
                        ),
                      );
                    },
            ),
            StatCard(
              icon: Icons.lock,
              iconColor: Colors.orange,
              value: '${prvRooms.length}',
              label: 'Total Private Rooms',
              onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivateRoomsPage(),
                        ),
                      );
                    },
            ),
            StatCard(
              icon: Icons.people,
              iconColor: Colors.green,
              value: '${students.length}',
              label: 'Total Students', 
              onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentsPage(),
                        ),
                      );
                    },
            ),
            StatCard(
              icon: Icons.add_box,
              iconColor: Colors.purple,
              value: '$countedStudents',
              label: 'Today\'s Active Participants', 
              onTap: () {
                    },
            ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            LineChartCard(),
          ],
        ),
      ),
    );
  }
}


