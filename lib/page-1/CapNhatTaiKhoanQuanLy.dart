import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/page-1/TrangChuNew.dart';
import 'package:myapp/utils.dart';
class CapNhatTaiKhoanQuanLy extends StatefulWidget {
  CapNhatTaiKhoanQuanLy({super.key,required this.email, required this.hinhanh, required this.displayName,required this.sdt, required this.calam, required this.luong, required this.ngaysinh, required this.gioitinh, required this.uid});
  String hinhanh, displayName,sdt, calam, luong, gioitinh, ngaysinh, uid,email;
  @override
  State<CapNhatTaiKhoanQuanLy> createState() => _CapNhatTaiKhoanQuanLyState();
}

class _CapNhatTaiKhoanQuanLyState extends State<CapNhatTaiKhoanQuanLy> {

  Future<void> updateUserInfo() async {
    try {
      // Tìm tài liệu dựa trên trường uid
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: widget.uid)
          .get();

      // Kiểm tra xem có tài liệu nào khớp với uid hay không
      if (querySnapshot.docs.isNotEmpty) {
        // Lấy ID của tài liệu cần cập nhật
        String documentId = querySnapshot.docs.first.id;

        // Tạo một Map chứa dữ liệu cập nhật
        Map<String, dynamic> dataToUpdate = {
          'email': widget.email,
          'hinhAnh': hinhanhQL,
          'displayName': displayName.text,
          'sdt': sdt.text,
          'calam': calam,
          'luong': luong.text,
          'gioitinh': gioitinh,
          'ngaysinh': ngaysinh.text,
        };

        // Cập nhật tài liệu
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(documentId)
            .update(dataToUpdate);

        Fluttertoast.showToast(msg: 'Cập nhật thông tin thành công!');
      } else {
        // Không tìm thấy tài liệu với uid tương ứng
        Fluttertoast.showToast(
          msg: 'Không tìm thấy người dùng để cập nhật',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Cập nhật thông tin thất bại',
        backgroundColor: Colors.red,
      );
    }
  }


  DateTime selectedDate = DateTime.now();
  Future<void> _selectDateupdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        ngaysinh.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
  final TextEditingController displayName = TextEditingController();
  final TextEditingController sdt= TextEditingController();
  final TextEditingController luong= TextEditingController();
  final TextEditingController ngaysinh= TextEditingController();
  final TextEditingController email= TextEditingController();

  String calam = "Sáng";
  String gioitinh = "Khác";
  String hinhanhQL = "";
  // hàm hiện thông tin sản phầm lên giao diện chỉnh sửa

  final ImagePicker pickersupdateKH = ImagePicker();
  XFile? imagesupdateQL;
  UploadImage() async {
    final storageRef = FirebaseStorage.instance.ref().child("quanLy"); // Ham lien ket vao storage
    try {
      final imageRef = storageRef.child(imagesupdateQL!.name);
      await imageRef.putFile(File(imagesupdateQL!.path));
      return hinhanhQL = await imageRef.getDownloadURL();
    } on FirebaseException catch(e) {
      print(e);
      return '';
    }
  }
  Future<void> uploadImage(XFile newImages) async {
    setState(() {
      imagesupdateQL = newImages;
    });
    hinhanhQL = await UploadImage();
  }

  @override
  void initState() {
    displayName.text = widget.displayName;
    sdt.text = widget.sdt;
    hinhanhQL = widget.hinhanh;
    calam = widget.calam;
    gioitinh = widget.gioitinh;
    luong.text = widget.luong;
    ngaysinh.text = widget.ngaysinh;
    email.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: double.infinity,
            child: Container(
              // capnhattaikhoankhachhang8tq (385:2130)
              padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 17*fem, 148*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xffffffff),
                image: DecorationImage (
                  fit: BoxFit.cover,
                  image: AssetImage (
                    'assets/page-1/images/hinhnen1-bg.png',
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroup7jcbniV (WXgqhbbUpYQwu2GfWe7JcB)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                    width: double.infinity,
                    height: 143*fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // logomauuYD (385:2132)
                          left: 114*fem,
                          top: 16*fem,
                          child: Align(
                            child: SizedBox(
                              width: 100*fem,
                              height: 100*fem,
                              child: Image.asset(
                                'assets/page-1/images/logomau.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // caukhauhieubvq (385:2133)
                          left: 5*fem,
                          top: 114*fem,
                          child: Align(
                            child: SizedBox(
                              width: 322*fem,
                              height: 29*fem,
                              child: Text(
                                'Thưởng thức vị ngon trọn vẹn',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont (
                                  'Dancing Script',
                                  fontSize: 24*ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2*ffem/fem,
                                  letterSpacing: 1*fem,
                                  color: Color(0xff993300),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // vectorfvh (385:2134)
                          left: 0*fem,
                          top: 30*fem,
                          child: Align(
                            child: SizedBox(
                              width: 32*fem,
                              height: 32*fem,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TrangChuNew()));
                                },
                                child: Image.asset(
                                  'assets/page-1/images/vector.png',
                                  width: 32*fem,
                                  height: 32*fem,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // bieumaudangnhapB8M (385:2135)
                    margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 9*fem, 0*fem),
                    padding: EdgeInsets.fromLTRB(25*fem, 26*fem, 24*fem, 23*fem),
                    width: double.infinity,
                    decoration: BoxDecoration (
                      color: Color(0xb2f5dab1),
                      borderRadius: BorderRadius.circular(30*fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // group32end (385:2136)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 12*fem),
                          width: double.infinity,
                          height: 36*fem,
                          decoration: BoxDecoration (
                            color: Color(0xff007373),
                            borderRadius: BorderRadius.circular(15*fem),
                          ),
                          child: Center(
                            child: Text(
                              'Cập nhật tài khoản',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont (
                                'Quicksand',
                                fontSize: 14*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.25*ffem/fem,
                                color: Color(0xfffcf2d9),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // txspxpJsB (385:2142)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 168*fem, 12*fem),
                          child: Text(
                            'Tải ảnh lên',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont (
                              'Quicksand',

                              fontSize: 16*ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.25*ffem/fem,
                              color: Color(0xff007373),
                            ),
                          ),
                        ),
                        Container(
                          // frame50Chf (385:2143)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 25*fem),
                          width: 259*fem,
                          height: 110*fem,
                          child:  GestureDetector(
                            onTap: () async {
                              final newImages = await pickersupdateKH.pickImage(source: ImageSource.gallery);
                              if (newImages == null) {
                                return;
                              }
                              uploadImage(newImages);
                            },
                            child: imagesupdateQL != null
                                ? Image.file(File(imagesupdateQL!.path), width: 259*fem, height: 110*fem,)
                                : widget.hinhanh != null && widget.hinhanh.isNotEmpty
                                ? Image.network(widget.hinhanh, width: 259*fem, height: 110*fem,)
                                : Image.asset(
                              'assets/page-1/images/image-16.png', // Replace with your default image path
                              width: 200*fem,
                              height: 110*fem,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: SizedBox(height: 50,
                              child: TextFormField(
                                controller: displayName,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xff007373)),
                                    hintText: "Họ và tên",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: SizedBox(height: 50,
                              child: TextFormField(
                                controller: email,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xff007373)),
                                    hintText: "email",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: SizedBox(height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: sdt,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xff007373)),
                                    hintText: "Số điện thoại",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: calam,
                            items: ["Sáng","Chiều", "Tối","Khuya"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                calam = newValue!;
                              });
                            },
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Color(0xff007373)),
                              hintText: "Ca làm",
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: SizedBox(height: 50,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: luong,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xff007373)),
                                    hintText: "lương",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        SizedBox(
                          height: 50,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: gioitinh,
                              items: ["Khác","Nam", "Nữ"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  gioitinh= newValue!;
                                });
                              },
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Color(0xff007373)),
                                hintText: "giới tính",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: SizedBox(
                              height: 30,
                              child: TextFormField(
                                controller: ngaysinh,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: "Ngày sinh",
                                  hintStyle: TextStyle(color: Color(0xff007373)),
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () {
                                      // Mở datetime picker ở đây
                                      _selectDateupdate(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            updateUserInfo();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const TrangChuNew()));
                          },
                          child: Container(
                            // btndangnhapqnZ (385:2156)
                            margin: EdgeInsets.fromLTRB(44*fem, 0*fem, 45*fem, 0*fem),
                            width: double.infinity,
                            height: 40*fem,
                            decoration: BoxDecoration (
                              color: Color(0xff007373),
                              borderRadius: BorderRadius.circular(20*fem),
                            ),
                            child: Center(
                              child: Center(
                                child: Text(
                                  'Xác nhận thay đổi',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont (
                                    'Quicksand',
                                    fontSize: 16*ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2000000477*ffem/fem,
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
          ),
        ),
      ),
    );
  }
}
