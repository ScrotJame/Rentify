import 'package:flutter/material.dart';

class RoomManagementPage extends StatelessWidget {
  static const String route = 'room-management';
  const RoomManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Management'),
      ),
      body: const RoomManagementBody(),
    );
  }
}

class RoomManagementBody extends StatelessWidget {
  const RoomManagementBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage("https://picsum.photos/400"),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFBDBDBD),
                      width: 1,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Title room",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                "Available",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            const Text(
                              "● Price: \$200/month",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFBDBDBD),
                    width: 1,
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Thông tin phòng",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 20)
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Loại phòng: ",
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16)
                          ),
                          Text("data")
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Giá phòng: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)
                          ),
                          Text("data")
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Số người ở: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)
                          ),
                          Text("data")
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ngày nhận phòng: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)
                          ),
                          Text("data")
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Thời gian thuê đến: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)
                          ),
                          Text("data")
                        ],
                      ),
                    ]
                  ),
                ),
                ),
            ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFBDBDBD),
                  width: 1,
                ),
              ),
              child: Padding(
                padding:const EdgeInsets.all(16),
                child:
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Người thuê",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16)
                    ),
                    SizedBox(
                      height: 120,
                      child: PageView(
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        image: const DecorationImage(
                                          image: NetworkImage("https://picsum.photos/400"),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:EdgeInsets.all(6),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Name",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Join in: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)
                                            ),
                                            Text("data")
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Lease expires: ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)
                                            ),
                                            Text("data")
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ]
                            ),
                          ),

                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          PaymentHistory(context),
          const SizedBox(height: 16),
          MaintenanceRequests(context),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
              child: OutlinedButton(
                onPressed: (){
                  print("Nhan tin nhom");
                  },
                  child: const Text("Nhắn tin"),
              ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: (){
                    print("Xem hop dong phong");
                  },
                  child: const Text("Xem hợp đồng"),
                ),
              ),
            ],
          ),
          )
        ],
      ),
    );
  }
}

Widget PaymentHistory(BuildContext context){
  return InkWell(
    onTap: (){
      print("Chuyen den trang lich su giao dich");
    },
    child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFBDBDBD),
            width: 1,
        ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                child: Text("Lịch sử thanh toán",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("5-2024",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)
                          ),
                          Text("Trả vào: 15-5",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10, color: Colors.grey,
                              )
                          ),
                        ],
                      ),
                      Text("3.500.000",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16)
                      ),
                    ]
                  )
                ],
              ),
            ],
          ),
        ),
      )
    ),
  );
}

Widget MaintenanceRequests(BuildContext context){
  return InkWell(
    onTap: (){
      print("Chuyen den trang yeu cau khach thue");
    },
    child:Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFD1D1D1),
            width: 1,
          ),
        ),
        child:Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text("Yêu cầu bảo trì",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              )
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFBDBDBD),
              ),
            ),
              child: Padding(
                  padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Tên yêu cầu",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("Ngày yêu cầu",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            Text("Status",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.yellow,
                              ),
                            ),
                            Text("Nội dung",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),)
                          ],
                        ),
                      ),
                  ),
                ],
              ),
              ),
              ),
            ),
          ]
        )
      ),
    )
  );
}