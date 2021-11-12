import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mage_flutter_testing/models/leave.dart';
import 'package:mage_flutter_testing/services/data_service.dart';
import 'package:mage_flutter_testing/utils/app_color.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService _dataService = DataService();

  Future<Leave> getLeaveData() async {
    return await _dataService.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_box,
              color: AppColors.blue,
              size: 30,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people_outlined,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 25,
            ),
            label: '',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: Colors.black87,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getLeaveData(),
        builder: (BuildContext context, AsyncSnapshot<Leave> snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text('Loading...'),
            );

          return Stack(children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: AppColors.skyBlue,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, left: 20, top: 100),
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 7,
                    shadowColor: Colors.black26,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      margin: const EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          children: [
                            const Text(
                              'My Holiday',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                holidayItem(snapshot.data!.totalDay.toString(),
                                    'Total', Colors.black87),
                                const SizedBox(
                                  height: 50,
                                  child: VerticalDivider(),
                                ),
                                holidayItem(
                                    snapshot.data!.totalDayUsed.toString(),
                                    'Used',
                                    AppColors.blue),
                                const SizedBox(
                                  height: 50,
                                  child: VerticalDivider(),
                                ),
                                holidayItem(
                                    snapshot.data!.totalDayLeft.toString(),
                                    'Left',
                                    AppColors.orange),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                button(Icons.add_outlined, 'Leave',
                                    AppColors.blue, Colors.white),
                                const SizedBox(
                                  width: 7,
                                ),
                                button(
                                  Icons.shuffle_outlined,
                                  'Switch',
                                  Colors.white,
                                  AppColors.blue,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Request',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 30,
                            child: Icon(
                              Icons.calendar_today_outlined,
                              color: AppColors.blue,
                              size: 17,
                            ),
                          ),
                          Text(
                            'Public holidays',
                            style: TextStyle(color: AppColors.blue),
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: leaveRequests(snapshot.data!.leaveRequests),
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }

  List<Widget> leaveRequests(List<LeaveRequest>? leaveRequests) {
    List<Widget> requests = [];
    for (var leaveRequest in leaveRequests!) {
      requests.add(leaveStatus(leaveRequest));
    }
    return requests;
  }

  Widget leaveStatus(LeaveRequest leaveRequest) {
    late String status;
    late Icon icon;
    late Color textColor = Colors.black87;

    switch (leaveRequest.status) {
      case 'pending':
        status = 'Pending';
        icon = const Icon(
          Icons.timer,
          color: AppColors.orange,
          size: 17,
        );
        break;

      case 'approved':
        status = 'Approved';
        icon = const Icon(
          Icons.check_circle,
          color: AppColors.lightGreen,
          size: 17,
        );
        break;

      case 'canceled':
        status = 'Canceled';
        icon = const Icon(
          Icons.close,
          color: Colors.black45,
          size: 17,
        );
        textColor = Colors.black45;
        break;

      default:
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 7,
          shadowColor: Colors.black26,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Leave',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        for (var request in leaveRequest.requestList!)
                          Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child: Icon(
                                  typeIcon(request.type!),
                                  size: 20,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                (DateFormat('dd MMM yyyy')
                                    .format(request.date!)),
                                style: TextStyle(color: textColor),
                              )
                            ],
                          )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 30, child: icon),
                        Text(
                          status,
                          style: TextStyle(color: textColor),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData typeIcon(String type) {
    switch (type) {
      case 'remote':
        return Icons.computer_outlined;

      case 'personal_leave':
        return Icons.flight_outlined;

      case 'switch_holiday':
        return Icons.shuffle_outlined;

      case 'sick_leave':
        return Icons.sick_outlined;

      default:
        return Icons.star;
    }
  }

  Widget button(
      IconData iconData, String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: bgColor,
        side: const BorderSide(color: AppColors.blue),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Icon(
            iconData,
            color: textColor,
          ),
          const SizedBox(
            width: 3,
          ),
          Text(
            text,
            style: TextStyle(color: textColor),
          )
        ],
      ),
    );
  }

  Widget holidayItem(String val, String title, Color valColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            val,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: valColor),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }
}
