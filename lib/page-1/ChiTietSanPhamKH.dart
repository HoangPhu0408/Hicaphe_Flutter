import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/utils.dart';
class ChiTietSanPhamKH extends StatefulWidget {
  final String idspKH;
  const ChiTietSanPhamKH({super.key, required this.idspKH});

  @override
  State<ChiTietSanPhamKH> createState() => _ChiTietSanPhamKHState();
}

class _ChiTietSanPhamKHState extends State<ChiTietSanPhamKH> {
  double tonghoadonKH = 0.0;
  late String tenSP;
  late String hinhAnh;
  late String kichThuoc;
  late String donGia;
  late String donVitinh;
  late String moTa;
  late String idCate;
  late String id;


  @override
  void initState() {
    super.initState();
    fetchThongTinSanPham(widget.idspKH);
  }

  Future<void> fetchThongTinSanPham(String productId) async {
    final DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection('Product')
        .doc(productId)
        .get();

    if (docSnapshot.exists) {
      final thongTinSanPham = docSnapshot.data() as Map<String, dynamic>;
      setState(() {
        tenSP = thongTinSanPham['tenSP'];
        hinhAnh = thongTinSanPham['hinhAnh'];
        kichThuoc = thongTinSanPham['kichThuoc'];
        donGia = thongTinSanPham['donGia'].toString();
        donVitinh = thongTinSanPham['donVitinh'];
        moTa = thongTinSanPham['moTa'];
        idCate = thongTinSanPham['idCate'];
        id = docSnapshot.id;
      });
    } else {
      print('Không tìm thấy sản phẩm');
    }
  }


  Future<String> fetchTenLoaiSanPham(String idCate) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Category')
        .where(FieldPath.documentId, isEqualTo: idCate) // Sử dụng idCate để so sánh với documentId
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final tenLoaiSanPhamData = querySnapshot.docs[0]['Name'];
      print('Ten loai san pham: $tenLoaiSanPhamData'); // Log tên loại sản phẩm
      return tenLoaiSanPhamData;
    } else {
      print('Khong tim thay loai san pham');
      return '';
    }
  }


  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return FutureBuilder<String>(
        future: fetchTenLoaiSanPham(idCate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Hiển thị tiến trình chờ khi đang tải dữ liệu
          }
          else {
            final tenLoaiSanPham = snapshot.data?? "";
            return Scaffold(
              body: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    // chitietsanphamkc9 (5:671)
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 16 * fem, 14 * fem, 12 * fem),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xfff5dab1),
                    ),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              // vectorehX (5:672)
                              margin: EdgeInsets.all(0.0),
                              width: 32 * fem,
                              height: 32 * fem,
                              child: Image.asset(
                                'assets/page-1/images/vector-CmP.png',
                                width: 32 * fem,
                                height: 32 * fem,
                              ),
                            ),
                          ),
                          Container(
                            // autogroupw5nhmn9 (NufAFUrHuEt4KEXhhXw5NH)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 30 * fem, 0 * fem, 50 * fem),

                            height: 110 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // anhsphA1 (5:675)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 19 * fem, 0 * fem),
                                  width: 75 * fem,
                                  height: 110 * fem,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        20 * fem),
                                    child: Image.network(
                                      hinhAnh.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  // autogroupwcxhQq7 (NufAMyfU32sJbSG9hyWCxh)
                                  height: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Container(
                                          // txcphenYwK (5:673)
                                          margin: EdgeInsets.fromLTRB(
                                              0 * fem, 0 * fem, 0 * fem,
                                              15* fem),
                                          child: Text(
                                            tenSP.toString(),
                                            softWrap: true,
                                            maxLines: 2,
                                            style: SafeGoogleFont(
                                              'Quicksand',
                                              fontSize: 21 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.25 * ffem / fem,
                                              color: const Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // cph48y (5:674)
                                        tenLoaiSanPham.toString(),
                                        style: SafeGoogleFont(
                                          'Quicksand',
                                          fontSize: 21 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.25 * ffem / fem,
                                          color: const Color(0xff777777),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroup8xeho6Z (NufAVyS9H5vqZ51ULD8XEH)
                            margin: EdgeInsets.fromLTRB(
                                16 * fem, 0 * fem, 95 * fem, 50 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // kchthcizD (5:676)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 40 * fem, 0 * fem),
                                  child: Text(
                                    'Kích thước:',
                                    style: SafeGoogleFont(
                                      'Quicksand',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.25 * ffem / fem,
                                      color: const Color(0xff007373),
                                    ),
                                  ),
                                ),
                                Text(
                                  // nhe7B (5:677)
                                  kichThuoc.toString(),
                                  style: SafeGoogleFont(
                                    'Quicksand',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.25 * ffem / fem,
                                    color: const Color(0xff993300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupuf5bmhb (NufAc46LzaqfsD1nivuf5b)
                            margin: EdgeInsets.fromLTRB(
                                16 * fem, 0 * fem, 0 * fem, 50 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // ngiJBj (5:678)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 70 * fem, 0 * fem),
                                  child: Text(
                                    'Đơn giá:',
                                    style: SafeGoogleFont(
                                      'Quicksand',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.25 * ffem / fem,
                                      color: const Color(0xff007373),
                                    ),
                                  ),
                                ),
                                Container(
                                  // pQy (5:679)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 5 * fem, 0 * fem),
                                  child: Text(
                                    donGia.toString(),
                                    style: SafeGoogleFont(
                                      'Quicksand',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.25 * ffem / fem,
                                      color: const Color(0xff993300),
                                    ),
                                  ),
                                ),
                                Text(
                                  // wEh (5:680)
                                  'VND',
                                  style: SafeGoogleFont(
                                    'Quicksand',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.25 * ffem / fem,
                                    color: const Color(0xff993300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // autogroupipgvtQq (NufAitEJGDHeX4XYRYiPGV)
                            margin: EdgeInsets.fromLTRB(
                                16 * fem, 0 * fem, 0 * fem, 15 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // slngbnpZP (5:681)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 7 * fem, 0 * fem),
                                  child: Text(
                                    'Số lượng bán:',
                                    style: SafeGoogleFont(
                                      'Quicksand',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.25 * ffem / fem,
                                      color: const Color(0xff007373),
                                    ),
                                  ),
                                ),
                                Text(
                                  // lyM3X (5:682)
                                  donVitinh.toString(),
                                  style: SafeGoogleFont(
                                    'Quicksand',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.25 * ffem / fem,
                                    color: const Color(0xff993300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // mt6Wu (5:683)
                            margin: EdgeInsets.fromLTRB(
                                16 * fem, 0 * fem, 0 * fem, 15 * fem),
                            child: Text(
                              'Mô tả:',
                              style: SafeGoogleFont(
                                'Quicksand',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1 * ffem / fem,
                                color: const Color(0xff007373),
                              ),
                            ),
                          ),
                          Container(
                                // lthcungtruynthngcangidnvitnam1 (5:684)
                                margin: EdgeInsets.fromLTRB(
                                    16 * fem, 0 * fem, 0 * fem, 0 * fem),
                                constraints: BoxConstraints(
                                  maxWidth: 289 * fem,

                                ),
                                child: Text(
                                  moTa.toString(),
                                  style: SafeGoogleFont(
                                    'Quicksand',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.25 * ffem / fem,
                                    color: const Color(0xff993300),
                                  ),
                                ),
                              ),


                          Container(
                            // autogroupbkhnGJ4 (3GhhSDbfXD34jwDFUtbkHn)
                            margin: EdgeInsets.fromLTRB(165*fem, 35*fem, 25.82*fem, 0*fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final String newId = DateTime.now().millisecondsSinceEpoch.toString();
                                    final FirebaseFirestore firestore = FirebaseFirestore.instance;
                                    // Đảm bảo bạn đã có thông tin người dùng đã đăng nhập từ Firebase Authentication
                                    User? user = FirebaseAuth.instance.currentUser;
                                    if (user == null) {
                                      // Xử lý trường hợp người dùng chưa đăng nhập
                                      return;
                                    }

                                    String uid = user.uid;
                                    DocumentSnapshot Users = await firestore.collection("Users").doc(uid).get();
                                    String Uid = Users.id;
                                    // Kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng chưa
                                    QuerySnapshot cartProducts = await firestore
                                        .collection("Cart")
                                        .where("id", isEqualTo: id)
                                        .get();

                                    if (cartProducts.docs.isNotEmpty) {
                                      // Nếu sản phẩm đã tồn tại, cập nhật số lượng
                                      // Nếu sản phẩm đã tồn tại, cập nhật số lượng
                                      final DocumentSnapshot existingProduct = cartProducts.docs[0];
                                      final  currentQuantity = existingProduct.get("soluong");
                                      final currentTotal = existingProduct.get("thanhTien");
                                      // Cập nhật số lượng và tổng tiền
                                      final  newQuantity = currentQuantity + 1;
                                      double Luong = double.parse(donGia);
                                      final  newTotal = newQuantity * Luong;

                                      await firestore.collection("Cart").doc(existingProduct.id).update({
                                        "soluong": newQuantity,
                                        "thanhTien": newTotal,
                                      });
                                    }
                                    else {
                                      double Luong = double.parse(donGia);
                                      await firestore.collection("Cart").add({
                                        "donGia": Luong,
                                        "soluong": 1,
                                        "thanhTien": Luong,
                                        "idCate": idCate,
                                        "id": id,
                                        "uid": Uid,
                                      });

                                      // Nếu sản phẩm chưa tồn tại, thêm sản phẩm mới
                                      Fluttertoast.showToast(msg: 'Đã thêm vào giỏ hàng của bạn!');
                                      final QuerySnapshot snapshot = await firestore.collection("Cart").get();
                                      double total = 0.0;
                                      for (final QueryDocumentSnapshot doc in snapshot.docs) {
                                        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                                        final double thanhTien = data['thanhTien'];
                                        total += thanhTien;
                                      }
                                      setState(() {
                                        tonghoadonKH = total;
                                      });
                                    }
                                  },

                                  child: Container(
                                    // vectorc72 (180:485)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 34.95*fem, 0*fem),
                                    width: 48.92*fem,
                                    height: 53*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/AddCart.png',
                                      width: 48.92*fem,
                                      height: 53*fem,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async   {
                                    {
                                      final String newId = DateTime.now().millisecondsSinceEpoch.toString(); // Ham lien ket vao cloud firebase
                                      final FirebaseFirestore firestore = FirebaseFirestore.instance;
                                      QuerySnapshot favoriteProducts = await firestore
                                          .collection("FavoriteProduct")
                                          .where("id", isEqualTo: id)
                                          .get();
                                      User? user = FirebaseAuth.instance.currentUser;
                                      if (user == null) {
                                        // Xử lý trường hợp người dùng chưa đăng nhập
                                        return;
                                      }
                                      String uid = user.uid;
                                      DocumentSnapshot Users = await firestore.collection("Users").doc(uid).get();
                                      String Uid = Users.id;
                                      if (favoriteProducts.docs.isEmpty) {
                                        // Nếu sản phẩm chưa tồn tại, thêm vào danh sách yêu thích
                                        try {
                                          await firestore.collection("FavoriteProduct").doc(newId).set({
                                            "idCate": idCate,
                                            "id" :id,
                                            "uid": Uid,
                                          });
                                          Fluttertoast.showToast(msg: 'Đã thêm vào danh sách yêu thích!');
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: 'Lỗi khi thêm sản phẩm vào danh sách yêu thích',
                                              backgroundColor: Colors.red);
                                        }
                                      } else {
                                        // Nếu sản phẩm đã tồn tại, hiển thị thông báo
                                        Fluttertoast.showToast(
                                            msg: 'Sản phẩm đã tồn tại trong danh sách yêu thích',
                                            backgroundColor: Colors.red);
                                      }
                                    }
                                  },
                                  child: Container(
                                    // vectorjxL (180:484)
                                    margin: EdgeInsets.fromLTRB(0*fem, 1*fem, 0*fem, 0*fem),
                                    width: 55.3*fem,
                                    height: 48*fem,
                                    child: Image.asset(
                                      'assets/page-1/images/AddFavorite.png',
                                      width: 55.3*fem,
                                      height: 48*fem,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
    );
  }
}
