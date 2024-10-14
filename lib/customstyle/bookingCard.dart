import 'package:flutter/material.dart';
import 'package:admin_fik_app/customstyle/buttonaccept.dart';
import 'package:admin_fik_app/customstyle/buttonreject.dart';
import 'package:admin_fik_app/pages/peminjaman/detailpeminjaman_page.dart';
import 'package:admin_fik_app/data/dummy_data.dart';

class BookingCard extends StatelessWidget {
  final String ruangan;
  final String studentName;
  final String inputDate;
  final String time;
  final String groupSize;
  final Function onAccept;
  final Function onReject;

  const BookingCard({
    Key? key,
    required this.ruangan,
    required this.studentName,
    required this.inputDate,
    required this.time,
    required this.groupSize,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailpeminjamanPage(
              studentName: DummyData.studentName,
              studentNim: DummyData.studentNim,
              inputDate: DummyData.inputDate,
              ruangan: DummyData.ruangan,
              bookDate: DummyData.bookDate,
              jamMulai: DummyData.jamMulai,
              jamSelesai: DummyData.jamSelesai,
              jumlahPengguna: DummyData.jumlahPengguna,
              keterangan: DummyData.keterangan,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Container(
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    studentName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(inputDate),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: 12),
                          Text(time),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.location_pin),
                          SizedBox(width: 12),
                          Text(ruangan),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.group),
                          SizedBox(width: 12),
                          Text(groupSize),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonAccept(
                        label: 'Terima',
                        onPressed: () => onAccept(),
                      ),
                      SizedBox(height: 12),
                      ButtonReject(
                        label: 'Tolak',
                        onPressed: () => onReject(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}