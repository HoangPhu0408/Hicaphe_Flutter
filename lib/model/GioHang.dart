import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class GioHangKH {
  final double donGia;
  final String id;
  final String idCate;
  final double soluong;
  final double thanhTien;
  final String uid; // Thêm trường mới này

  GioHangKH(
    this.donGia,
    this.id,
    this.idCate,
    this.soluong,
    this.thanhTien,
    this.uid, // Thêm vào constructor
  );

  static Future<void> moveCartToBill(String uid) async {
    double tonghoadon = 0;
    CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('Cart');
    CollectionReference billCollection =
        FirebaseFirestore.instance.collection('Bill');

    try {
      QuerySnapshot cartSnapshot = await cartCollection.where('uid',isEqualTo: uid).get();

      if (cartSnapshot.docs.isNotEmpty) {
        // Tạo một document mới trong collection "Bill"
        DocumentReference billDocRef =
            billCollection.doc(); // Sử dụng documentID mới

        for (QueryDocumentSnapshot doc in cartSnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          tonghoadon += data['thanhTien'];
          // Thêm dữ liệu sản phẩm vào subcollection 'products' của document Bill
          await billDocRef.collection('products').add({
            'donGia': data['donGia'],
            'id': data['id'],
            'idCate': data['idCate'],
            'soluong': data['soluong'],
            'thanhTien': data['thanhTien'],
          });
        }

        // Thêm thông tin chung của đơn hàng vào document Bill
        String ngaydathang =
            DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now());
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
        DocumentSnapshot Users =
            await firestore.collection("Users").doc(uid).get();
        String Uid = uid;
        final trangthai = "Đã đặt hàng";
        final phuongThucThanhToan = "Tiền mặt";

        await billDocRef.set({
          'ngayDH': ngaydathang,
          'uid': Uid,
          'tinhTrang': trangthai,
          'phuongThucThanhToan': phuongThucThanhToan,
          'tongHoaDon': tonghoadon,
        });

        // Xóa tất cả dữ liệu từ bảng Cart
        for (QueryDocumentSnapshot doc in cartSnapshot.docs) {
          await doc.reference.delete();
        }

        // In thông báo hoặc thực hiện các bước tiếp theo sau khi chuyển dữ liệu
        print('Chuyển dữ liệu từ Cart sang Bill thành công!');
      } else {
        // Xử lý trường hợp giỏ hàng trống
        print('Giỏ hàng trống!');
      }
    } catch (e) {
      // Xử lý lỗi
      print('Có lỗi xảy ra: $e');
    }
  }

  factory GioHangKH.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return GioHangKH(
      data['donGia'],
      data['id'],
      data['idCate'],
      data['soluong'],
      data['thanhTien'],
      data['uid'],
    );
  }
}

Future<List<GioHangKH>> getCartData() async {
  CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('Cart');
  QuerySnapshot cartSnapshot = await cartCollection.get();

  List<GioHangKH> gioHangList = [];

  for (QueryDocumentSnapshot doc in cartSnapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    gioHangList.add(GioHangKH(
      data['donGia'],
      data['id'],
      data['idCate'],
      data['soluong'],
      data['thanhTien'],
      data['uid'],
    ));
  }
  return gioHangList;
}
