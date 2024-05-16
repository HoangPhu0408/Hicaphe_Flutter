import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:myapp/page-1/ChiTietSanPhamKH.dart';
import 'package:myapp/page-1/DatHang.dart';
import 'package:myapp/utils.dart';

class GioHang extends StatefulWidget {
  const GioHang({super.key});

  @override
  State<GioHang> createState() => _GioHangState();
}

final CollectionReference updataGioHang =
    FirebaseFirestore.instance.collection('Cart');
late Stream<QuerySnapshot> productStreamgiohang;
Future<double> calculateTotalAmount(String uid) async {
  double total = 0.0;
  final QuerySnapshot snapshot =
      await updataGioHang.where('uid', isEqualTo: uid).get();
  for (final QueryDocumentSnapshot doc in snapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final thanhTien = data['thanhTien'];
    total += thanhTien;
  }
  return total;
}

class _GioHangState extends State<GioHang> {
  double tonghoadon = 0.0;

  // Gọi hàm để lấy ID của Cart
  bool sapXepNguyenLieu = true;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;

    productStreamgiohang = FirebaseFirestore.instance
        .collection('Cart')
        .where('uid', isEqualTo: userID)
        .snapshots();
    calculateTotalAmount(userID!).then((double total) {
      setState(() {
        tonghoadon = total;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Center(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          child: Container(
            // giohangnqn (180:274)
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xfff5dab1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // autogroupto4cvSC (3GhWLCmRP8As9nJbVoTo4c)
                  padding: EdgeInsets.fromLTRB(
                      10 * fem, 16 * fem, 17.06 * fem, 29 * fem),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // autogroupza161Te (3GhQt7M7TfREV1xw3tZA16)
                        margin: EdgeInsets.fromLTRB(
                            6 * fem, 0 * fem, 0 * fem, 23 * fem),
                        width: double.infinity,
                        height: 32 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                // vector7ma (180:352)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 30 * fem, 0 * fem),
                                width: 32 * fem,
                                height: 32 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/vector-QPr.png',
                                  width: 32 * fem,
                                  height: 32 * fem,
                                ),
                              ),
                            ),
                            Container(
                              // opt4cyE (180:275)
                              width: 223.05 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xff993300),
                                borderRadius: BorderRadius.circular(30 * fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Giỏ hàng ',
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
                      Container(
                        // autogroup6gk2s8U (3GhR2gw9gvnYbYL38w6GK2)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 1.94 * fem, 7 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // tngtinthanhtonc64 (180:356)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 20 * fem, 0 * fem),
                              child: Text(
                                'Tổng tiền thanh toán',
                                style: SafeGoogleFont(
                                  'Quicksand',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.25 * ffem / fem,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            Text(
                              // UPA (180:357)
                              ' ${tonghoadon.toStringAsFixed(0)} \t VND',
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
                      Container(
                        // autogroupx1gcckG (3GhR8GcBhg1HMCfPzPX1Gc)
                        margin: EdgeInsets.fromLTRB(
                            2 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: double.infinity,
                        height: 32 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // autogroupey1ekrU (3GhRErFZ7vcDDpLfvNeY1e)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 6 * fem, 38 * fem, 4 * fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [],
                              ),
                            ),
                            Container(
                              // opt56or (180:278)
                              width: 195 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xff993300),
                                borderRadius: BorderRadius.circular(30 * fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const DatHang()));
                                    },
                                    child: Text(
                                      'Đặt hàng ',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont(
                                        'Quicksand',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1 * ffem / fem,
                                        color: Color(0xfffcf2d9),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: productStreamgiohang,
                      builder: (context, snapshot) {
                        final giohang = snapshot.data!.docs;
                        // Tính tổng tiền từ dữ liệu Firebase
                        return ListView.builder(
                            // đưa dữ liệu hiển thị lên màn hình
                            itemCount: giohang.length,
                            itemBuilder: (context, document) {
                              final DocumentSnapshot documentSnapshotGioHang =
                                  giohang[document];
                              final dongia = documentSnapshotGioHang['donGia'];
                              final id = documentSnapshotGioHang.id;
                              final idSP = documentSnapshotGioHang['id'];
                              final soluong =
                                  documentSnapshotGioHang['soluong'];
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
                                      child: SizedBox(
                                        height: 105,
                                        child: ListTile(
                                          tileColor: Color(0xfff5dab2),
                                          visualDensity:
                                              VisualDensity(vertical: 4),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChiTietSanPhamKH(
                                                        idspKH: idSP),
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
                                              Text(dongia.toString() + ' VND'),
                                            ],
                                          ),
                                          trailing: SingleChildScrollView(
                                            child: Column(
                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                _tanggiamsoluong(
                                                    id, soluong, dongia,
                                                    documentSnapshotGioHang[
                                                        'uid']),
                                                Container(
                                                  // btxoaWL1 (5:462)
                                                  margin: EdgeInsets.only(
                                                      bottom: 0 * fem,
                                                      top: 0 * fem),
                                                  width: 29 * fem,
                                                  height: 29 * fem,
                                                  child: TextButton(
                                                    onPressed: () {
                                                      confirmDeleteDialoggiohang(
                                                          updataGioHang.doc(
                                                              documentSnapshotGioHang
                                                                  .id));
                                                    },
                                                    child: Image.asset(
                                                      'assets/page-1/images/btxoa.png',
                                                      width: 32 * fem,
                                                      height: 32 * fem,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
      ),
    );
  }

  Widget _tanggiamsoluong(String documentId, int quantity, int dongia, String uid) {
    return FittedBox(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              // Tăng số lượng
              if (quantity > 1) {
                FirebaseFirestore.instance
                    .collection('Cart')
                    .doc(documentId)
                    .update({
                  'soluong': quantity - 1,
                  'thanhTien': dongia * (quantity - 1),
                });
                setState(() {
                  calculateTotalAmount(uid);
                });
              }
            },
            icon: Icon(Icons.remove),
          ),
          Text(quantity.toString()),
          IconButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Cart')
                  .doc(documentId)
                  .update({
                'soluong': quantity + 1,
                'thanhTien': dongia * (quantity + 1),
              });
              setState(() {
                calculateTotalAmount(uid);
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Future confirmDeleteDialoggiohang(DocumentReference dele) async {
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
                    'Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy'),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GioHang()));
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
                    MaterialPageRoute(builder: (context) => const GioHang()));
              },
            ),
          ],
        );
      },
    );
  }
}
