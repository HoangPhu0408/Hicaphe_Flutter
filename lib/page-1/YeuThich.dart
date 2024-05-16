import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/page-1/QuanLyKH.dart';
import 'package:myapp/utils.dart';
import 'ChiTietSanPhamKH.dart';

class YeuThich extends StatefulWidget {
  const YeuThich({super.key});

  @override
  State<YeuThich> createState() => _YeuThichState();
}

//final user = FirebaseAuth.instance.currentUser;
final CollectionReference updataYeuThich =
      FirebaseFirestore.instance.collection('FavoriteProduct');
class _YeuThichState extends State<YeuThich> {
  final TextEditingController searchYeuThich = TextEditingController();
  String searchKeyYeuThich = '';
  List<DocumentSnapshot> filteredSearchYeuThich = [];
  String normalizeString(String input) {
    return input.toLowerCase(); // Chuyển hết sang chữ thường
  }

  void searchValue() {
    String normalizedKeyword = normalizeString(searchKeyYeuThich);
    setState(() {
      productStreamYeuThich = updataYeuThich
          .where('tenSP', isGreaterThanOrEqualTo: normalizedKeyword)
          .where('tenSP', isLessThan: '${normalizedKeyword}z')
          .snapshots();
    });
  }
// Nhưng biến phục vụ chức năng search

  
  bool sapXepYeuThich = true;
  late Stream<QuerySnapshot> productStreamYeuThich;

  @override
  void initState() {
    super.initState();
    // Khởi tạo productStream với dữ liệu ban đầu
    User? user = FirebaseAuth.instance.currentUser;
    String? userID = user?.uid;

    // Truy vấn các sản phẩm yêu thích dựa trên uid của người dùng
    productStreamYeuThich = FirebaseFirestore.instance
        .collection('FavoriteProduct')
        .where('uid', isEqualTo: userID) // Truy vấn dựa trên uid của người dùng
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
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
                // autogroupd25pQv5 (Nuf1G9zcm6EPhD28Yvd25P)
                padding: EdgeInsets.fromLTRB(
                    13 * fem, 48 * fem, 0 * fem, 12.5 * fem),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // group71jBf (5:499)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 13 * fem, 31 * fem),
                        width: double.infinity,
                        height: 45 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vectoreZX (5:500)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 11 * fem, 0 * fem),
                              width: 45 * fem,
                              height: 45 * fem,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QuanLyKH()));
                                },
                                child: Image.asset(
                                  'assets/page-1/images/vector.png',
                                  width: 45 * fem,
                                  height: 45 * fem,
                                ),
                              ),
                            ),
                            Container(
                              // timkiemyLu (5:501)
                              padding: EdgeInsets.fromLTRB(
                                  17 * fem, 0 * fem, 0 * fem, 0 * fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 270,
                                    height: 50,
                                    child: CupertinoSearchTextField(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff993300)),
                                        color: const Color(0xffffffff),
                                        borderRadius:
                                            BorderRadius.circular(30 * fem),
                                      ),
                                      placeholder: 'Tìm kiếm',
                                      //thay đổi trạng thái listview lọc sản phẩm khi search
                                      onChanged: (value) {
                                        setState(() {
                                          searchKeyYeuThich = value;
                                        });
                                      },
                                      controller: searchYeuThich,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // opt4jZi (180:200)
                        margin: EdgeInsets.fromLTRB(
                            59 * fem, 0 * fem, 51.95 * fem, 16 * fem),
                        width: double.infinity,
                        height: 32 * fem,
                        decoration: BoxDecoration(
                          color: Color(0xff993300),
                          borderRadius: BorderRadius.circular(30 * fem),
                        ),
                        child: Center(
                          child: Center(
                            child: Text(
                              'Sản phẩm đã thích',
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
                      Container(
                          // autogrouptybbNDw (NuevXdDPScUQ6TNmmXTYBb)
                          margin: EdgeInsets.fromLTRB(
                              12 * fem, 0 * fem, 23 * fem, 0 * fem),
                          width: double.infinity,
                          height: 25 * fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sapXepYeuThich =
                                        false; // Đảo ngược trạng thái sắp xếp
                                  });
                                },
                                child: Row(
                                  children: [],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: sapXepYeuThich
                        ? productStreamYeuThich
                        : updataYeuThich.orderBy('tenSP').snapshots(),
                    builder: (context, snapshot) {
                      final nuoc = snapshot.data!.docs;
                      return ListView.builder(
                          // đưa dữ liệu hiển thị lên màn hình
                          itemCount: nuoc.length,
                          itemBuilder: (context, document) {
                            print(
                                "Number of filtered items: ${nuoc.length}"); // Add this lin
                            final DocumentSnapshot documentSnapshotYeuThich =
                                nuoc[document];
                            final IDsp = documentSnapshotYeuThich['id'];

                            return StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Product')
                                    .doc(IDsp)
                                    .snapshots(),
                                builder: (context, index) {
                                  if (!index.hasData || index.data == null) {
                                    // Handle the case where no data is available for the given idSP
                                    return Text(
                                        'Không có dữ liệu cho idSP: $IDsp');
                                  }

                                  final sanphamyeuthich = index.data?.data()
                                          as Map<String, dynamic>? ??
                                      {};
                                  if (sanphamyeuthich.isEmpty) {
                                    // Handle the case where the product data is empty
                                    return Text(
                                        'Dữ liệu sản phẩm trống cho idSP: $IDsp');
                                  }

                                  final hinhanh = sanphamyeuthich['hinhAnh'];
                                  final tenSP = sanphamyeuthich['tenSP'];
                                  final kichthuoc =
                                      sanphamyeuthich['kichThuoc'];
                                  final dongia = sanphamyeuthich['donGia'];
                                  final donvitinh =
                                      sanphamyeuthich['donVitinh'];
                                  // Check if the product matches the search criteria
                                  bool matchesSearch = tenSP
                                      .toLowerCase()
                                      .contains(
                                          searchKeyYeuThich.toLowerCase());

                                  // If the product doesn't match the search, return an empty container
                                  if (!matchesSearch) {
                                    return Container();
                                  }
                                  return Card(
                                    child: ListTile(
                                      visualDensity: VisualDensity(vertical: 4),
                                      tileColor: Color(0xfff5dab2),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChiTietSanPhamKH(idspKH: IDsp),
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
                                            child: Image.network(
                                              hinhanh,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      title: Text(
                                        tenSP,
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
                                          Text(dongia.toString() +
                                              "/" +
                                              donvitinh),
                                        ],
                                      ),
                                      trailing: Column(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // btxoaWL1 (5:462)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 0 * fem),
                                            width: 32 * fem,
                                            height: 32 * fem,
                                            child: TextButton(
                                              onPressed: () {
                                                confirmDeleteDialogyeuthich(
                                                    updataYeuThich.doc(
                                                        documentSnapshotYeuThich
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
                                  );
                                });
                          });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future confirmDeleteDialogyeuthich(DocumentReference dele) async {
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
                    MaterialPageRoute(builder: (context) => const YeuThich()));
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
                    MaterialPageRoute(builder: (context) => const YeuThich()));
              },
            ),
          ],
        );
      },
    );
  }
}
