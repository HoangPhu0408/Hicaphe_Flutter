import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/utils.dart';
import 'ChiTietSanPham.dart';

class ChiTetDonHang extends StatefulWidget {
  final String id, displayName, ngayDH, tinhTrang;
  final double dongia;
  const ChiTetDonHang ({super.key, required this.id, required this.displayName, required this.dongia, required this.ngayDH, required this.tinhTrang});

  @override
  State<ChiTetDonHang > createState() => _ChiTetDonHangState();
}

class _ChiTetDonHangState extends State<ChiTetDonHang> {
  String? tinhtrang;
  String selectCheckin = 'Tiền mặt';
  String selectedTrangThai = "Đã đặt hàng";
  // Add a variable to hold the displayed order status
  late String displayedOrderStatus;

  // Add a variable to check if the order is canceled
  bool isOrderCanceled = false;
  @override
  void initState() {
    super.initState();
    displayedOrderStatus =widget.tinhTrang;
    isOrderCanceled = widget.tinhTrang.toLowerCase() == 'đơn đã hủy';
    selectedTrangThai = isOrderCanceled ? 'Đã hủy đơn' : 'Đã đặt hàng';
  }
  final CollectionReference updataDatHang =FirebaseFirestore.instance.collection('Bill');
  Future<void> updateTrangThai(String newTrangThai) async {
    try {
      // Check if the order is already canceled
      if (!isOrderCanceled) {
        await FirebaseFirestore.instance
            .collection('Bill')
            .doc(widget.id)
            .update({'tinhTrang': newTrangThai, 'isCanceled':  newTrangThai.toLowerCase() == 'đơn đã hủy'});

        // Set the displayed order status after the update
        setState(() {
          displayedOrderStatus = newTrangThai;
          isOrderCanceled = newTrangThai.toLowerCase() == 'đơn đã hủy';

        });

        // Check if the order is canceled after the update
        if (newTrangThai == 'đơn đã hủy') {
          setState(() {
            isOrderCanceled = true;

          });
        }

        Fluttertoast.showToast(msg: 'Cập nhật thành công');
      } else {
        Fluttertoast.showToast(msg: 'Đơn đã bị hủy, không thể cập nhật trạng thái.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Cập nhật thất bại');
      print(e.toString());
    }
  }
  Future<void> updatePaymentMethod(String newPaymentMethod) async {
    try {
      await FirebaseFirestore.instance
          .collection('Bill')
          .doc(widget.id)
          .update({'phuongThucThanhToan': newPaymentMethod});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return  Material(
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
                // chitietsanpham2tR (301:495)
                width: double.infinity,
                decoration: BoxDecoration (
                  color: Color(0xfff5dab1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //đây
                    Container(
                      // autogrouphjqtK6q (SivAximhhNxvjZBaCZHjqT)
                      padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 0*fem, 20*fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              // vectorcrd (301:496)
                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11*fem),
                              width: 32*fem,
                              height: 32*fem,
                              child: Image.asset(
                                'assets/page-1/images/vector.png',
                                width: 32*fem,
                                height: 32*fem,
                              ),
                            ),
                          ),
                          Container(
                            // autogroupd6nv95s (SivAhZYJ3rzgkR9CBXd6nV)
                            margin: EdgeInsets.fromLTRB(8*fem, 0*fem, 0*fem, 21*fem),
                            width: double.infinity,
                            height: 90*fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // safes1s (301:510)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 22*fem, 0*fem),
                                  width: 90*fem,
                                  height: 90*fem,
                                  child: Image.asset(
                                    'assets/page-1/images/safe.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  // autogroupj3bwB2Z (SivAoPhuuz4UHKK2ocj3Bw)
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // txcphenvVw (301:497)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 15*fem),
                                        child: Text(
                                          widget.id,
                                          style: SafeGoogleFont (
                                            'Quicksand',
                                            fontSize: 16*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.25*ffem/fem,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // ctZ (301:498)
                                        widget.ngayDH,
                                        style: SafeGoogleFont (
                                          'Quicksand',
                                          fontSize: 16*ffem,
                                          fontWeight: FontWeight.w700,
                                          height: 1.25*ffem/fem,
                                          color: Color(0xff993300),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // group889Nh (301:499)
                            margin: EdgeInsets.fromLTRB(8*fem, 0*fem, 0*fem, 17*fem),
                            width: 900*fem,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogroupct2hsZb (SivBknHHd9BRqrvViTCT2h)
                                  padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 5*fem),
                                  // width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // autogroup8mrqzeD (SivBFYd125Epax8UgU8Mrq)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 2*fem, 0*fem),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // tnkhchhngXe9 (301:500)
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 30*fem, 0*fem),
                                              child: Text(
                                                'Tên khách hàng',
                                                style: SafeGoogleFont (
                                                  'Quicksand',
                                                  fontSize: 16*ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff007373),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              // nguynvnadhB (301:501)
                                              widget.displayName,
                                              style: SafeGoogleFont (
                                                'Quicksand',
                                                fontSize: 16*ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.25*ffem/fem,
                                                color: Color(0xff993300),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5*fem,
                                      ),
                                      SizedBox(
                                        height: 5*fem,
                                      ),
                                      Container(
                                        // autogroupdsnv5hb (SivBT3HrBQ92TvaW5ZDSNV)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 0*fem),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // thnhtin1r9 (301:507)
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 72*fem, 0*fem),
                                              child: Text(
                                                'Thành tiền',
                                                style: SafeGoogleFont (
                                                  'Quicksand',
                                                  fontSize: 16*ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff007373),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              // j1T (301:503)
                                              widget.dongia.toString(),
                                              style: SafeGoogleFont (
                                                'Quicksand',
                                                fontSize: 16*ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.25*ffem/fem,
                                                color: Color(0xff993300),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5*fem,
                                      ),
                                      Container(
                                        // autogrouprbayTTF (SivBYCoumrHMFXBjKHrBay)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 30*fem, 0*fem),
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // phngthcthanhtono1K (301:508)
                                              margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 8*fem, 0*fem),
                                              child: Text(
                                                'Phương thức thanh toán',
                                                style: SafeGoogleFont (
                                                  'Quicksand',
                                                  fontSize: 14*ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.25*ffem/fem,
                                                  color: Color(0xff007373),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: SizedBox(
                                                width: 134,
                                                child: DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder( // Set border to remove the underline
                                                      borderSide: BorderSide(color: Colors.transparent), // Set color to transparent
                                                    ),
                                                    focusedBorder: OutlineInputBorder( // Set focusedBorder to remove the underline when focused
                                                      borderSide: BorderSide(color: Colors.transparent),
                                                    ),
                                                  ),
                                                  value: selectCheckin,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      selectCheckin = newValue!;
                                                      // Update the trangThai field in Firestore here
                                                    });
                                                  },
                                                  items: ['Tiền mặt', 'Google Pay']
                                                      .map<DropdownMenuItem<String>>((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value, style: TextStyle(fontSize: 12),),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // autogroupixpwpx1 (SivBdhekW8tQQmaGFCiXPw)
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // tnhtrngnhngB1s (301:509)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 30*fem, 0*fem),
                                        child: Text(
                                          'Tình trạng đơn hàng',
                                          style: SafeGoogleFont (
                                            'Quicksand',
                                            fontSize: 14*ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.25*ffem/fem,
                                            color: Color(0xff007373),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: SizedBox(
                                          width: 136,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder( // Set border to remove the underline
                                                borderSide: BorderSide(color: Colors.transparent), // Set color to transparent
                                              ),
                                              focusedBorder: OutlineInputBorder( // Set focusedBorder to remove the underline when focused
                                                borderSide: BorderSide(color: Colors.transparent),
                                              ),
                                            ),
                                            value: selectedTrangThai,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedTrangThai = newValue!;
                                                // Update the trangThai field in Firestore here
                                              });
                                            },
                                            items: ['Đã đặt hàng', 'Đã thanh toán', 'Đang giao', 'Đã nhận hàng', 'Đã hủy đơn']
                                                .map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                  style: TextStyle(fontSize: 12),),
                                              );
                                            }).toList(),
                                            enableFeedback: !isOrderCanceled,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              updateTrangThai(selectedTrangThai);
                              updatePaymentMethod(selectCheckin);
                            },
                            child: Container(
                              // opt6RS1 (301:556)
                              margin: EdgeInsets.fromLTRB(53*fem, 0*fem, 55.96*fem, 0*fem),
                              width: double.infinity,
                              height: 32*fem,
                              decoration: BoxDecoration (
                                color: Color(0xff993300),
                                borderRadius: BorderRadius.circular(30*fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Lưu trạng thái đơn hàng',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont (
                                      'Quicksand',
                                      fontSize: 15*ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.3333333333*ffem/fem,
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
                    stream:  updataDatHang
                        .doc(widget.id)
                        .collection('products')
                        .snapshots(),
                    builder: (context,snapshot) {
                      final giohang = snapshot.data!.docs;
                      // Tính tổng tiền từ dữ liệu Firebase
                      return ListView.builder(
                        // đưa dữ liệu hiển thị lên màn hình
                          itemCount: giohang.length,
                          itemBuilder: (context, document){
                            final DocumentSnapshot documentSnapshotGioHang = giohang[document];
                            final idSP = documentSnapshotGioHang['id'];
                            final soluong = documentSnapshotGioHang['soluong'];
                            return StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance.collection('Product').doc(idSP).snapshots(),
                                builder: (context, index){
                                  if (!index.hasData || index.data == null) {
                                    // Handle the case where no data is available for the given idSP
                                    return Text('Không có dữ liệu cho idSP: $idSP');
                                  }
                                  final productData = index.data?.data() as Map<String, dynamic>? ?? {};
                                  if (productData.isEmpty) {
                                    // Handle the case where the product data is empty
                                    return Text('Dữ liệu sản phẩm trống cho idSP: $idSP');
                                  }
                                  final tensp = productData['tenSP'];
                                  final hinhanh = productData['hinhAnh'];
                                  final kichthuoc = productData['kichThuoc'];
                                  final dongia = productData['donGia'];
                                  return SizedBox(
                                    height: 120,
                                    child: Card(
                                      child: ListTile(
                                        visualDensity: VisualDensity(vertical: 4),
                                        tileColor: Color(0xfff5dab1),

                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChiTietSanPham(productId: idSP),),);                                        },
                                        leading: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                            minWidth: 60,
                                            minHeight: 55,
                                            maxWidth: 64,
                                            maxHeight: 64,
                                          ),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(hinhanh, fit: BoxFit.cover)),
                                        ),
                                        title: Text(tensp,
                                          style: const TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 26,
                                              color: Colors.black

                                          ),),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Kích thước : " + kichthuoc),
                                            Text("Số lượng : " + soluong.toString()),
                                            Text( "Đơn giá : " + dongia.toString() + ' VND'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
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
