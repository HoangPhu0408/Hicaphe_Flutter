import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/GioHang.dart';
import 'package:myapp/page-1/GioHang.dart';
import 'package:myapp/page-1/QuanLyKH.dart';
import 'package:myapp/utils.dart';
import 'package:pay/pay.dart';
import '../method/google_api.dart';
import 'ChiTietSanPhamKH.dart';

class DatHang extends StatefulWidget {
  const DatHang({super.key});

  @override
  State<DatHang> createState() => _DatHangState();
}

class _DatHangState extends State<DatHang> {
  Map<String, dynamic> userInfo = {}; // Lưu thông tin người dùng
  Future<void> getUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid;

      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userSnapshot.exists) {
        setState(() {
          userInfo = userSnapshot.data() as Map<String, dynamic>;
        });
      }
    }
  }

  String defaultNgaySinh =
      DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
  double tonghoadon = 0.0;
  Future<double> calculateTotalAmount(String uid) async {
    final QuerySnapshot snapshot = await updataDatHang.get();
    double total = 0.0;
    for (final QueryDocumentSnapshot doc in snapshot.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final thanhTien = data['thanhTien'];
      if (uid == data['uid']) {
        total += thanhTien;
      }
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;
    productStreamdathang = FirebaseFirestore.instance
        .collection('Cart')
        .where('uid', isEqualTo: userID)
        .snapshots();
    getUserInfo();
    calculateTotalAmount(userID!).then((value) {
      setState(() {
        tonghoadon = value;
      });
    });
  }

  final CollectionReference updataDatHang =
      FirebaseFirestore.instance.collection('Cart');
  late Stream<QuerySnapshot> productStreamdathang;
  String os = Platform.operatingSystem;
  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [],
    width: double.infinity,
    height: 50,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15),
    onPaymentResult: (result) async {
      debugPrint('Payment Result $result');
      Fluttertoast.showToast(msg: 'Thanh toán thành công');
      // showNotification(); // Hiển thị thông báo sau khi thanh toán thành công
      // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const DanhMucSanPhamKH()));
    },
    onPressed: () {},
    loadingIndicator: const Center(child: CircularProgressIndicator()),
  );
  DocumentSnapshot? hoadon;
  // Widget buildGooglePayButton() {
  //   return GooglePayButton(
  //     paymentConfiguration:
  //         PaymentConfiguration.fromJsonString(defaultGooglePay),
  //     paymentItems: const [],
  //     width: double.infinity,
  //     type: GooglePayButtonType.buy,
  //     margin: const EdgeInsets.only(top: 15),
  //     onPaymentResult: (result) async {
  //       debugPrint('Payment Result $result ');
  //       Fluttertoast.showToast(msg: 'Thanh toán thành công');
  //       Navigator.of(context)
  //           .push(MaterialPageRoute(builder: (context) => QuanLyKH()));
  //       try {
  //         await GioHangKH.moveCartToBill();
  //       } catch (e) {
  //         // Xử lý lỗi
  //         Fluttertoast.showToast(msg: 'Có lỗi xảy ra: $e');
  //         print(e);
  //       }
  //     },
  //     loadingIndicator: const Center(child: CircularProgressIndicator()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: double.infinity,
        child: Container(
          // danhmucsanphamtB3 (5:376)
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xfff5dab1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // autogroupkjqyXCc (3GheGUYVWus9sBvWxaKJQY)
                width: double.infinity,
                height: 323 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      // autogroupfyncT6G (3GhYgDh7nUpd3xwt3LfYnC)
                      left: 16 * fem,
                      top: 16 * fem,
                      child: Container(
                        width: 285.05 * fem,
                        height: 32 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vector7Ri (180:443)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 30 * fem, 0 * fem),
                              width: 32 * fem,
                              height: 32 * fem,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const GioHang()));
                                },
                                child: Image.asset(
                                  'assets/page-1/images/vector-KvY.png',
                                  width: 32 * fem,
                                  height: 32 * fem,
                                ),
                              ),
                            ),
                            Container(
                              // opt4Qfi (180:369)
                              width: 223.05 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xff993300),
                                borderRadius: BorderRadius.circular(30 * fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Thanh toán',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Quicksand',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3333333333 * ffem / fem,
                                      color: Color(0xfffcf2d9),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // autogroupx2hnS6c (3GhYsP3BoyG6ZHcbkFX2hN)
                      left: 10 * fem,
                      top: 71 * fem,
                      child: Container(
                        width: 350 * fem,
                        height: 20 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // tngtinthanhtonmPn (180:444)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 70 * fem, 0 * fem),
                              child: Text(
                                'Tổng tiền thanh toán',
                                style: SafeGoogleFont(
                                  'Quicksand',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25 * ffem / fem,
                                  color: Color(0xff007373),
                                ),
                              ),
                            ),
                            Text(
                              // fzx (180:445)
                              ' ${tonghoadon.toStringAsFixed(0)}VND',
                              style: SafeGoogleFont(
                                'Quicksand',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.25 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // autogroupg9mzDWg (3GhYziAJnMQAmcoJz8g9mz)
                      left: 10 * fem,
                      top: 99 * fem,
                      child: Container(
                        width: 350 * fem,
                        height: 20 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // tnkhchhng87r (180:456)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 50 * fem, 0 * fem),
                              child: Text(
                                'Tên khách hàng: ',
                                style: SafeGoogleFont(
                                  'Quicksand',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25 * ffem / fem,
                                  color: Color(0xff007373),
                                ),
                              ),
                            ),
                            Text(
                              // nguyntrngtneM6 (180:457)
                              '${userInfo['displayName'] ?? ''}',
                              style: SafeGoogleFont(
                                'Quicksand',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.25 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // achgiaohngxcg (180:458)
                      left: 10 * fem,
                      top: 155 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 150 * fem,
                          height: 20 * fem,
                          child: Text(
                            'Địa chỉ giao hàng:',
                            style: SafeGoogleFont(
                              'Quicksand',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.25 * ffem / fem,
                              color: Color(0xff007373),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // autogroupbfklSGx (3GhZ8YGbTVELYReymHBfkL)
                      left: 10 * fem,
                      top: 127 * fem,
                      child: Container(
                        width: 350 * fem,
                        height: 20 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // sinthoiZsN (180:459)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 125 * fem, 0 * fem),
                              child: Text(
                                'Số điện thoại:',
                                style: SafeGoogleFont(
                                  'Quicksand',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.25 * ffem / fem,
                                  color: Color(0xff007373),
                                ),
                              ),
                            ),
                            Text(
                              // 6MW (180:460)
                              '${userInfo['sdt'] ?? ''}',
                              style: SafeGoogleFont(
                                'Quicksand',
                                fontSize: 16 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.25 * ffem / fem,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // tnxun6xtnxunhhcmnpoJ (180:461)
                      left: 10 * fem,
                      top: 181 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 408 * fem,
                          height: 20 * fem,
                          child: Text(
                            '${userInfo['diaChi'] ?? ''}',
                            style: SafeGoogleFont(
                              'Quicksand',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.25 * ffem / fem,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // autogroupkcvntoA (3GhZF7uxsjqGR3LFhGKCVN)
                      left: 30 * fem,
                      top: 235 * fem,
                      child: Container(
                        width: 320 * fem,
                        height: 70 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // frame82E6L (180:462)
                              margin: EdgeInsets.fromLTRB(
                                  2 * fem, 10 * fem, 30 * fem, 5 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  10 * fem, 0 * fem, 9 * fem, 6 * fem),
                              height: 50,
                              width: 135,
                              decoration: BoxDecoration(
                                color: Color(0xff993300),
                                borderRadius: BorderRadius.circular(360 * fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // eurosj36 (180:463)
                                    margin: EdgeInsets.fromLTRB(
                                        5 * fem, 8 * fem, 9 * fem, 3 * fem),
                                    width: 20 * fem,
                                    height: 20 * fem,
                                    child: Image.asset(
                                      'assets/page-1/images/euros.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Center(
                                    // tinmtpaL (180:464)
                                    child: GestureDetector(
                                      onTap: () async {
                                        try {
                                          await GioHangKH.moveCartToBill(userInfo['uid'] ?? '');
                                        } catch (e) {
                                          // Xử lý lỗi
                                          Fluttertoast.showToast(
                                              msg: 'Có lỗi xảy ra: $e');
                                          print(e);
                                        }
                                        Fluttertoast.showToast(
                                            msg:
                                                'Bạn đã đặt hàng thành công, chờ thanh toán bằng tiền mặt');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    QuanLyKH()));
                                      },
                                      child: Text(
                                        'Tiền mặt',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Quicksand',
                                          fontSize: 12 * ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 2 * ffem / fem,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  10 * fem, 0 * fem, 1 * fem, 6.5 * fem),
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0 * fem),
                              height: 70,
                              width: 150, // Điều chỉnh kích thước theo nhu cầu

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .end, // Điều chỉnh căn giữa hoặc căn đều theo ý muốn
                                children: [
                                  //buildGooglePayButton(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // phngthcthanhtonukC (180:468)
                      left: 10 * fem,
                      top: 209 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 200 * fem,
                          height: 20 * fem,
                          child: Text(
                            'Phương thức thanh toán:',
                            style: SafeGoogleFont(
                              'Quicksand',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.25 * ffem / fem,
                              color: Color(0xff007373),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // danhschsnphmcnthanhtonn3J (180:469)
                      left: 10 * fem,
                      top: 300 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 315 * fem,
                          height: 20 * fem,
                          child: Text(
                            'Danh sách sản phẩm cần thanh toán:',
                            style: SafeGoogleFont(
                              'Quicksand',
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.25 * ffem / fem,
                              color: Color(0xff007373),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: productStreamdathang,
                    builder: (context, snapshot) {
                      final giohang = snapshot.data!.docs;
                      return ListView.builder(
                          // đưa dữ liệu hiển thị lên màn hình
                          itemCount: giohang.length,
                          itemBuilder: (context, document) {
                            // print("Number of filtered items: ${giohang.length}"); // Add this line
                            // for (var item in giohang) {
                            //   print('Item ID: ${item.id}, idSP: ${item['id']}');
                            // }
                            final DocumentSnapshot documentSnapshotGioHang =
                                giohang[document];
                            final thanhTien =
                                documentSnapshotGioHang['thanhTien'];
                            final id = documentSnapshotGioHang.id;
                            final idSP = documentSnapshotGioHang['id'];
                            final soluong = documentSnapshotGioHang['soluong'];
                            return StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Product')
                                    .doc(idSP)
                                    .snapshots(),
                                builder: (context, index) {
                                  if (!index.hasData || index.data == null) {
                                    // Handle the case where no data is available for the given idSP
                                    return Text(
                                        'Không có dữ liệu cho idSP: $idSP');
                                  }
                                  final productData = index.data?.data()
                                          as Map<String, dynamic>? ??
                                      {};
                                  if (productData.isEmpty) {
                                    // Handle the case where the product data is empty
                                    return Text(
                                        'Dữ liệu sản phẩm trống cho idSP: $idSP');
                                  }
                                  final tensp = productData['tenSP'];
                                  final hinhanh = productData['hinhAnh'];
                                  final kichthuoc = productData['kichThuoc'];
                                  return Card(
                                    child: ListTile(
                                      tileColor: Color(0xfff5dab2),
                                      visualDensity: VisualDensity(vertical: 4),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChiTietSanPhamKH(idspKH: idSP),
                                          ),
                                        );
                                      },
                                      leading: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 60,
                                          minHeight: 55,
                                          maxWidth: 64,
                                          maxHeight: 64,
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(hinhanh,
                                                fit: BoxFit.cover)),
                                      ),
                                      title: Text(
                                        tensp,
                                        style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26,
                                            color: Colors.black),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Kích thước : " + kichthuoc),
                                          Text(thanhTien.toString() + ' VND'),
                                        ],
                                      ),
                                      trailing: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("× " + soluong.toString()),
                                          Container(
                                            // btxoaWL1 (5:462)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 0 * fem),
                                            width: 30 * fem,
                                            height: 30 * fem,
                                            child: TextButton(
                                              onPressed: () {
                                                confirmDeleteDialog(
                                                    updataDatHang.doc(
                                                        documentSnapshotGioHang
                                                            .id));
                                              },
                                              child: Image.asset(
                                                'assets/page-1/images/btxoa.png',
                                                width: 22 * fem,
                                                height: 22 * fem,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future confirmDeleteDialog(DocumentReference dele) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Ngăn người dùng đóng hộp thoại bằng cách bấm ngoài
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận xóa sản phẩm'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Bạn có chắc chắn muốn xóa sản phẩm này khỏi danh sách yêu thích không?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const DatHang()));
              },
            ),
            TextButton(
              child: const Text('Xóa'),
              onPressed: () async {
                try {
                  await dele.delete();
                  Fluttertoast.showToast(msg: 'Xóa thành công!');
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: 'Xóa thất bại', backgroundColor: Colors.red);
                }
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const DatHang()));
              },
            ),
          ],
        );
      },
    );
  }
}
