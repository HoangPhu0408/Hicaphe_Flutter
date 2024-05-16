import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:myapp/page-1/ChiTietDonHang.dart';
import 'package:myapp/utils.dart';

class DanhMucDonHang extends StatefulWidget {
  const DanhMucDonHang({super.key});

  @override
  State<DanhMucDonHang> createState() => _DanhMucDonHangState();
}

class _DanhMucDonHangState extends State<DanhMucDonHang> {

  final CollectionReference updatadonHang =FirebaseFirestore.instance.collection('Bill');
  bool sapXepdonhang = true;
  late Stream<QuerySnapshot> productStreamdonhang;
  void updateProductStreamNL() {
    setState(() {
      productStreamdonhang = updatadonHang.orderBy('ngayDH',descending: true).snapshots();
    });
  }
  @override
  void initState() {
    super.initState();
    // Khởi tạo productStream với dữ liệu ban đầu
    productStreamdonhang= updatadonHang.snapshots();
  }
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Center(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Container(
              // giohangnqn (180:274)
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xfff5dab1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // autogroupto4cvSC (3GhWLCmRP8As9nJbVoTo4c)
                    padding: EdgeInsets.fromLTRB(10*fem, 16*fem, 0*fem, 29*fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroupza161Te (3GhQt7M7TfREV1xw3tZA16)
                          margin: EdgeInsets.fromLTRB(6*fem, 0*fem, 0*fem, 0*fem),
                          width: double.infinity,
                          height: 32*fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // vector7ma (180:352)
                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                width: 32*fem,
                                height: 32*fem,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    'assets/page-1/images/vector-QPr.png',
                                    width: 32*fem,
                                    height: 32*fem,
                                  ),
                                ),
                              ),
                              Container(
                                // autogroupx1gcckG (3GhR8GcBhg1HMCfPzPX1Gc)
                                margin: EdgeInsets.fromLTRB(2*fem, 0*fem, 0*fem, 0*fem),

                                height: 20*fem,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // autogroupey1ekrU (3GhRErFZ7vcDDpLfvNeY1e)
                                      padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                      height: double.infinity,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                sapXepdonhang = false; // Đảo ngược trạng thái sắp xếp
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  // btsapxep4FB (5:377)
                                                  margin: EdgeInsets.fromLTRB(200 * fem, 0 * fem, 0* fem, 4 * fem),
                                                  width: 32 * fem,
                                                  height: 32 * fem,
                                                  child: Image.asset(
                                                    'assets/page-1/images/btsapxep.png',
                                                    width: 32 * fem,
                                                    height: 32 * fem,
                                                  ),
                                                ),
                                                Text(
                                                  // txspxpmvH (5:402)
                                                  'Sắp xếp',
                                                  style: SafeGoogleFont(
                                                    'Quicksand',
                                                    fontSize: 16 * ffem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.25 * ffem / fem,
                                                    color: const Color(0xff993300),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                    child:  StreamBuilder<QuerySnapshot>(
                        stream: sapXepdonhang ? productStreamdonhang : updatadonHang.orderBy('ngayDH',descending: true).snapshots(),
                        builder: (context,snapshot) {
                          final donhang = snapshot.data!.docs;
                          // Tính tổng tiền từ dữ liệu Firebase
                          return ListView.builder(
                            // đưa dữ liệu hiển thị lên màn hình
                              itemCount:donhang.length,
                              itemBuilder: (context, document){
                                final DocumentSnapshot documentSnapshotGioHang = donhang[document];
                                final idGiohang = documentSnapshotGioHang['uid'];
                                //final idSP = documentSnapshotGioHang['id'];
                                final dongia = documentSnapshotGioHang['tongHoaDon'];
                                final ngayDH = documentSnapshotGioHang['ngayDH'];
                                final idhoadon = documentSnapshotGioHang.id;
                                final tinhTrang = documentSnapshotGioHang['tinhTrang'];
                                return StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance.collection('Users').doc(idGiohang).snapshots(),
                                    builder: (context, index){
                                      final productData = index.data?.data()
                                              as Map<String, dynamic>? ??
                                          {};
                                      final displayName =
                                          productData['displayName'];
                                      return
                                        Card(
                                          child: ListTile(
                                              visualDensity: VisualDensity(vertical: 4),
                                              tileColor: Color(0xfff5dab1),

                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChiTetDonHang(id: idhoadon, displayName: displayName, dongia: dongia, ngayDH: ngayDH, tinhTrang: tinhTrang,),),);
                                              },
                                              leading: ConstrainedBox(
                                                constraints: const BoxConstraints(
                                                  minWidth: 60,
                                                  minHeight: 55,
                                                  maxWidth: 64,
                                                  maxHeight: 64,
                                                ),
                                                child: Image.asset('assets/page-1/images/safe.png', fit: BoxFit.cover),
                                              ),
                                              title: Text(ngayDH,
                                                style: const TextStyle(
                                                    fontFamily: 'Quicksand',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 26,
                                                    color: Colors.black

                                                ),),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(displayName),
                                                  Text(dongia.toString() + ' VND'),
                                                ],
                                              )
                                          ),
                                        );
                                    });
                              }
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}