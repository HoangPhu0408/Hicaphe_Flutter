import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/page-1/QuanLyKH.dart';
import 'package:myapp/utils.dart';

import '../model/YeuThich.dart';
import 'ChiTietSanPhamKH.dart';

class DanhMucSanPhamKH extends StatefulWidget {
  const DanhMucSanPhamKH({super.key});

  @override
  State<DanhMucSanPhamKH> createState() => _DanhMucSanPhamKHState();
}

class _DanhMucSanPhamKHState extends State<DanhMucSanPhamKH> {
  Future addnewFavorite( CaPheYeuThich capheyeuthich) async {
    final String newId = DateTime.now().millisecondsSinceEpoch.toString(); // Ham lien ket vao cloud firebase
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Xử lý trường hợp người dùng chưa đăng nhập
      return;
    }
    String uid = user.uid;
    DocumentSnapshot Users = await firestore.collection("Users").doc(uid).get();
    String Uid = Users.id;
    try {
      await firestore.collection("FavoriteProduct").doc(newId).set({
        "idCate": capheyeuthich.idCate,
        "id": capheyeuthich.idSP,
        "uid": Uid,
      });
      Fluttertoast.showToast(msg: 'Đã thêm vào danh sách yêu thích!');
    }
    catch (e) {
      Fluttertoast.showToast(msg: 'Thêm thất bại', backgroundColor: Colors.red);
    }
  }
  void addToCart(DocumentSnapshot product) async {
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
        .where("id", isEqualTo: product.id)
        .get();

    if (cartProducts.docs.isNotEmpty) {
      // Nếu sản phẩm đã tồn tại, cập nhật số lượng
      // Nếu sản phẩm đã tồn tại, cập nhật số lượng
      final DocumentSnapshot existingProduct = cartProducts.docs[0];
      final  currentQuantity = existingProduct.get("soluong");
      final currentTotal = existingProduct.get("thanhTien");
      // Cập nhật số lượng và tổng tiền
      final  newQuantity = currentQuantity + 1;
      final  newTotal = newQuantity * product.get("donGia");

      await firestore.collection("Cart").doc(existingProduct.id).update({
        "soluong": newQuantity,
        "thanhTien": newTotal,
      });
    }
    else {
      await firestore.collection("Cart").add({
        "donGia": product['donGia'],
        "soluong": 1,
        "thanhTien": product['donGia'],
        "idCate": product['idCate'],
        "id": product.id,
        "uid": Uid,
      });

      // Nếu sản phẩm chưa tồn tại, thêm sản phẩm mới
      Fluttertoast.showToast(msg: 'Đã thêm vào giỏ hàng của bạn!');
      final QuerySnapshot snapshot = await firestore.collection("Cart").get();
      double total = 0.0;
      for (final QueryDocumentSnapshot doc in snapshot.docs) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final int thanhTien = data['thanhTien'];
        total += thanhTien;
      }
      setState(() {
        tonghoadonKH = total;
      });
    }

  }


  double tonghoadonKH = 0.0;
  String selectedIdCateKH = '';// Thêm trường này để lưu idCate được chọn
  // hàm lọc danh sức từ Category
  void filterProductsByCate(String idCate) {
    setState(() {
      productStreamKH = updataKH
          .where('idCate', isEqualTo: idCate)
          .snapshots();
    });
  }
  final TextEditingController searchKH = TextEditingController();
  String searchKeyKH = '';
  List<DocumentSnapshot> filteredSearchKH = [];
  String normalizeString(String input) {
    return input.toLowerCase(); // Chuyển hết sang chữ thường
  }
  void searchValue() {
    String normalizedKeyword = normalizeString(searchKeyKH);
    setState(() {
      productStreamKH = updataKH
          .where('tenSP', isGreaterThanOrEqualTo: normalizedKeyword)
          .where('tenSP', isLessThan: '${normalizedKeyword}z')
          .snapshots();
    });
  }
// Nhưng biến phục vụ chức năng search

  final CollectionReference updataKH =FirebaseFirestore.instance.collection('Product');
  final CollectionReference upCateKH =FirebaseFirestore.instance.collection('Category');
  bool sapXepKH = true;
  late Stream<QuerySnapshot> productStreamKH;
  void updateProductStream() {
    setState(() {
      productStreamKH = updataKH.orderBy('tenSP').snapshots();
    });
  }

  @override
  void initState() {
    super.initState();
    // Khởi tạo productStream với dữ liệu ban đầu
    productStreamKH = updataKH.snapshots();
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
          decoration: const BoxDecoration (
            color: Color(0xfff5dab1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // autogroupd25pQv5 (Nuf1G9zcm6EPhD28Yvd25P)
                padding: EdgeInsets.fromLTRB(13*fem, 48*fem, 0*fem, 12.5*fem),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // group71jBf (5:499)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 13*fem, 31*fem),
                        width: double.infinity,
                        height: 45*fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vectoreZX (5:500)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 11*fem, 0*fem),
                              width: 45*fem,
                              height: 45*fem,
                              child: TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> QuanLyKH()));
                                },
                                child: Image.asset(
                                  'assets/page-1/images/vector.png',
                                  width: 45*fem,
                                  height: 45*fem,
                                ),
                              ),
                            ),
                            Container(
                              // timkiemyLu (5:501)
                              padding: EdgeInsets.fromLTRB(17*fem, 0*fem, 0*fem, 0*fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(width: 270,height: 50,
                                    child: CupertinoSearchTextField(
                                      decoration: BoxDecoration (
                                        border: Border.all(color: const Color(0xff993300)),
                                        color: const Color(0xffffffff),
                                        borderRadius: BorderRadius.circular(30*fem),
                                      ),
                                      placeholder: 'Tìm kiếm',
                                      //thay đổi trạng thái listview lọc sản phẩm khi search
                                      onChanged: (value){
                                        setState(() {
                                          searchKeyKH = value;
                                        });
                                      },
                                      // chuyển kiểu chữ để nhận dạng sản phẩm
                                      // onSubmitted: (value){
                                      //   searchValue();
                                      // },
                                      controller: searchKH,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // frame36Q4q (5:388)
                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 17.5*fem),
                        width: 613*fem,
                        height: 32*fem,
                        decoration: BoxDecoration (
                          color: const Color(0xfffcf2d9),
                          borderRadius: BorderRadius.circular(30.0),

                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xfff5dab1),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: upCateKH.snapshots(),
                                    builder: (context,snapshot) {
                                      final loc = snapshot.data!.docs;
                                      return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: loc.length,
                                          itemBuilder: (context, index){
                                            final DocumentSnapshot documentSnapshot = loc[index];
                                            final id =documentSnapshot.id;
                                            return
                                              Padding(
                                                padding: const EdgeInsets.only(right: 10.0),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      selectedIdCateKH= id;
                                                    });
                                                    filterProductsByCate(id);
                                                  },
                                                  child: Container(
                                                    // width: 135,
                                                    decoration: BoxDecoration(
                                                        color:  const Color(0xff993300),
                                                        borderRadius: BorderRadius.circular(30)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                      child: Center(child: Text(documentSnapshot['Name'],style: const TextStyle(color: Color(0xfffcf2d9),),),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                          }
                                      );
                                    }
                                ),
                              )
                          ),
                        ),
                      ),
                      Container(
                        // autogrouptybbNDw (NuevXdDPScUQ6TNmmXTYBb)
                          margin: EdgeInsets.fromLTRB(12*fem, 0*fem, 23*fem, 0*fem),
                          width: double.infinity,
                          height: 25*fem,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    sapXepKH = false; // Đảo ngược trạng thái sắp xếp
                                  });
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      // btsapxep4FB (5:377)
                                      margin: EdgeInsets.fromLTRB(210 * fem, 0 * fem, 8 * fem, 4 * fem),
                                      width: 20 * fem,
                                      height: 20 * fem,
                                      child: Image.asset(
                                        'assets/page-1/images/btsapxep.png',
                                        width: 20 * fem,
                                        height: 20 * fem,
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
                          )
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: sapXepKH ?  productStreamKH : updataKH.orderBy('tenSP').snapshots(),
                    builder: (context,snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('Không có dữ liệu'),
                        );
                      }
                      final nuoc = snapshot.data!.docs;
                      // điều kiện lọc sản phẩm từ Category
                      // Sử dụng Set để lưu trữ sản phẩm mà không loại bỏ bản ghi trùng lặp
                      Set<String> productNames = {};
                      // Điều kiện lọc sản phẩm từ Category
                      if (selectedIdCateKH.isNotEmpty) {
                        // Duyệt qua tất cả sản phẩm và thêm tên sản phẩm vào Set
                        for (var sanpham in nuoc) {
                          if (sanpham['idCate'] == selectedIdCateKH &&
                              sanpham['tenSP']
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchKeyKH.toLowerCase())) {
                            productNames.add(sanpham['tenSP']);
                          }
                        }
                      }
                      else {
                        // Duyệt qua tất cả sản phẩm và thêm tên sản phẩm vào Set
                        for (var sanpham in nuoc) {
                          if (sanpham['tenSP']
                              .toString()
                              .toLowerCase()
                              .contains(searchKeyKH.toLowerCase())) {
                            productNames.add(sanpham['tenSP']);
                          }
                        }
                      }
                      // Chuyển danh sách Set thành danh sách danh sách
                      List<String> uniqueProductNames = productNames.toList();
                      //thêm dữ liệu vào chuỗi rỗng để lọc sản phẩm phục vụ chức năng tìm kiếm
                      filteredSearchKH = nuoc.where((sanpham) =>
                          sanpham['tenSP'].toString().toLowerCase().contains(searchKeyKH.toLowerCase())
                      ).toList();

                      return ListView.builder(
                        // đưa dữ liệu hiển thị lên màn hình
                          itemCount: uniqueProductNames.length,
                          itemBuilder: (context, document) {
                            // Tìm tất cả các sản phẩm có cùng tên và hiển thị chúng
                            List<DocumentSnapshot> productsWithSameName = nuoc
                                .where((sanpham) =>
                            sanpham['tenSP'] ==
                                uniqueProductNames[document])
                                .toList();

                            return Column(
                              children: productsWithSameName.map((
                                  documentSnapshotSP) {
                                final tenSP = documentSnapshotSP['tenSP'];
                                final hinhAnh = documentSnapshotSP['hinhAnh'];
                                final Size = documentSnapshotSP['kichThuoc'];
                                final donGia = documentSnapshotSP['donGia'];
                                final idCate = documentSnapshotSP['idCate'];
                                final id = documentSnapshotSP.id;
                                return SizedBox(
                                  height: 130,
                                  child: Card(
                                    child: ListTile(
                                      visualDensity: VisualDensity(vertical: 4),
                                      tileColor: Color(0xfff5dab2),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChiTietSanPhamKH(idspKH: id),),
                                        );
                                      },
                                      leading: ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          minWidth: 60,
                                          minHeight: 55,
                                          maxWidth: 64,
                                          maxHeight: 64,
                                        ),
                                        child: ClipRRect (
                                            borderRadius:BorderRadius.circular(10),
                                            child: Image.network(hinhAnh, fit: BoxFit.cover,)
                                        ),
                                      ),
                                      title: Text(tenSP, style: const TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      ),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Kích thước : " + Size),
                                          Text(donGia.toString()),
                                        ],
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () async   {
                                              {
                                                final String newId = DateTime.now().millisecondsSinceEpoch.toString(); // Ham lien ket vao cloud firebase
                                                final FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                QuerySnapshot favoriteProducts = await firestore
                                                    .collection("FavoriteProduct")
                                                    .where("id", isEqualTo: id)
                                                    .get();
                                                print('In ID product ${favoriteProducts}');

                                                if (favoriteProducts.docs.isEmpty) {
                                                  CaPheYeuThich yeuthich = CaPheYeuThich(id, idCate);
                                                  // Nếu sản phẩm chưa tồn tại, thêm vào danh sách yêu thích
                                                  addnewFavorite(yeuthich);
                                                }
                                                else {
                                                  // Nếu sản phẩm đã tồn tại, hiển thị thông báo
                                                  Fluttertoast.showToast(
                                                      msg: 'Sản phẩm đã tồn tại trong danh sách yêu thích',
                                                      backgroundColor: Colors.red);
                                                }
                                              }
                                            },
                                            child: Container(
                                              // bteditbTw (5:459)
                                              margin: EdgeInsets
                                                  .fromLTRB(0 * fem, 0 *
                                                  fem, 0 * fem, 8 *
                                                  fem),
                                              width: 18 * fem,
                                              height: 20 * fem,
                                              child: Image.asset(
                                                'assets/page-1/images/btLike.png',
                                                width:  22 * fem,
                                                height: 22 * fem,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // btxoaWL1 (5:462)
                                            margin: EdgeInsets.fromLTRB(
                                                0 * fem, 0 * fem,
                                                0 * fem, 0 * fem),
                                            width: 40*fem,
                                            height: 35*fem,
                                            child: TextButton(
                                              onPressed: ( )  {
                                                addToCart(documentSnapshotSP);
                                              },
                                              child: Image.asset(
                                                'assets/page-1/images/btAddCart.png',
                                                width: 17*fem,
                                                height: 20*fem,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}