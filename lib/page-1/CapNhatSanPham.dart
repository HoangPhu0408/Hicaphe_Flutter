// hỗ trợ cho File
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/model/DanhMucCaPhe.dart';
import 'package:myapp/page-1/danhmucsanpham.dart';
import 'package:myapp/utils.dart';

class CapNhatSanPham extends StatefulWidget {
  const CapNhatSanPham({super.key, required this.tensp, required this.soluong, required this.masp, required this.kichthuoc, required this.mota, required this.dongia, required this.hinhanh, required this.id});
  final String tensp, soluong, masp, kichthuoc, mota, dongia, hinhanh,id;
  @override
  State<CapNhatSanPham> createState() => _CapNhatSanPhamState();
}

class _CapNhatSanPhamState extends State<CapNhatSanPham> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController price = TextEditingController();
  final TextEditingController quantity = TextEditingController();
  final TextEditingController idCate = TextEditingController();
  final TextEditingController descrip= TextEditingController();
  final TextEditingController name = TextEditingController();
  String size = ""; // Giá trị ban đầu
  String imageURL = " ";

  Future updateCaPhe(CaPhe caphe, String id) async
  {
    Map<String, dynamic> dulieucf = {
      'donGia' : caphe.donGia,
      'donVitinh': caphe.donviTinh,
      'hinhAnh': imageURL,
      'idCate' :caphe.idCate,
      'kichThuoc': size,
      'moTa': caphe.motaCaphe,
      'tenSP': caphe.tenCaphe
    };

    // Kiểm tra nếu có ảnh URL, thì thêm nó vào dữ liệu cập nhật
    try{
      await FirebaseFirestore.instance.collection('Product').doc(id).update(dulieucf);
      Fluttertoast.showToast(msg: 'Cập nhật thành công!');
    }
    catch (e){
      Fluttertoast.showToast(msg: 'Thêm thất bại', backgroundColor: Colors.red);
    }
  }

  final ImagePicker pickers = ImagePicker();
  XFile? images;
  Future<void> uploadImage(XFile newImages) async {
    setState(() {
      images = newImages;
    });
    imageURL = await UploadImage();
  }

  // hàm đưa đưa dữ liệu lên Storage
  UploadImage() async {
    final storageRef = FirebaseStorage.instance.ref().child("sanPham"); // Ham lien ket vao storage
    try {
      final imageRef = storageRef.child(images!.name);
      await imageRef.putFile(File(images!.path));
      return imageURL = await imageRef.getDownloadURL();
    } on FirebaseException catch(a) {
      return '';
    }
  }

  // hàm hiện thông tin sản phầm lên giao diện chỉnh sửa
  @override
  void initState() {
    name.text = widget.tensp;
    idCate.text = widget.masp;
    size = widget.kichthuoc;
    price.text = widget.dongia.toString();
    quantity.text = widget.soluong;
    descrip.text = widget.mota;
    imageURL = widget.hinhanh;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              // capnhatsanpham5sf (5:233)
              padding: EdgeInsets.fromLTRB(16*fem, 16*fem, 19*fem, 0*fem),
              width: double.infinity,
              decoration: const BoxDecoration (
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
                    // autogroupz5ayBA1 (NueqSrWtAdDXKP2deuZ5Ay)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                    width: double.infinity,
                    height: 143*fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // logomauVgV (5:235)
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
                          // caukhauhieuQoT (5:262)
                          left: 3*fem,
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
                                  color: const Color(0xff993300),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // vectorZpm (5:263)
                          margin: EdgeInsets.fromLTRB(0*fem, 20*fem, 291*fem, 53*fem),
                          child: Align(
                            child: SizedBox(
                              width: 75*fem,
                              height: 75*fem,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  'assets/page-1/images/vector-32y.png',
                                  width: 50*fem,
                                  height: 50*fem,
                                ),
                              ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // bieumaudangnhap5YD (5:236)
                    margin: EdgeInsets.fromLTRB(10*fem, 0*fem, 7*fem, 0*fem),
                    padding: EdgeInsets.fromLTRB(25*fem, 26*fem, 24*fem, 28*fem),
                    width: double.infinity,
                    decoration: BoxDecoration (
                      color: const Color(0xb2f5dab1),
                      borderRadius: BorderRadius.circular(30*fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // group32Lyw (5:237)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 12*fem),
                          width: double.infinity,
                          height: 36*fem,
                          decoration: BoxDecoration (
                            color: const Color(0xff007373),
                            borderRadius: BorderRadius.circular(15*fem),
                          ),
                          child: Center(
                            child: Text(
                              'Thay đổi thông tin sản phẩm',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont (
                                'Quicksand',
                                fontSize: 14*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.25*ffem/fem,
                                color: const Color(0xfffcf2d9),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // txspxp1KP (5:242)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 130*fem, 12*fem),
                          child: TextButton(
                            onPressed: (){},
                            child: TextButton(
                                onPressed: () async {},
                                child: Text(
                                    'Tải ảnh lên',
                                    style: SafeGoogleFont (
                                      'Quicksand',
                                      fontSize: 16*ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.25*ffem/fem,
                                      color: const Color(0xff007373),))
                            ),
                          ),
                        ),
                        Container(
                          // frame497dK (5:258)
                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 34*fem),
                          width: 259*fem,
                          height: 110*fem,
                          child: TextButton(
                            onPressed: () async {
                              final newImages = await pickers.pickImage(source: ImageSource.gallery);
                              if (newImages == null) {
                                return;
                              }
                              uploadImage(newImages);
                            },
                            child:
                            images != null ? Image.file(File(images!.path),width: 259*fem,
                              height: 110*fem,) :  Image.network( widget.hinhanh,
                              width: 259*fem,
                              height: 110*fem,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: SizedBox(height: 30,
                              child: TextFormField(

                                controller: idCate,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintStyle:  TextStyle(color: Color(0xff007373)),
                                    hintText: "Mã sản phẩm",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: SizedBox(height: 30,
                              child: TextFormField(
                                controller: name,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xff007373)),
                                    hintText: "Tên sản phẩm",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0), // Thêm khoảng trống ở đầu
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: size,
                              items: ["","L", "N"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  size = newValue!;
                                });
                              },
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Color(0xff007373)),
                                hintText: "Kích thước",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: SizedBox(height: 30,
                              child: TextFormField(
                                controller: quantity,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Color(0xff007373)),
                                    hintText: "Số lượng",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: SizedBox(height: 50,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Vui lòng nhập giá sản phẩm';
                                  } else if (value.length > 5) {
                                    return 'Nhập trong khoảng từ 1000VND - 99999VND';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                controller: price,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    hintStyle:  TextStyle(color: Color(0xff007373)),
                                    hintText: "Giá sản phẩm",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: SizedBox(height: 30,
                              child: TextFormField(
                                maxLines: 2,
                                controller: descrip,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    isDense: true,
                                    hintStyle:  TextStyle(color: Color(0xff007373)),
                                    hintText: "Mô tả",
                                    fillColor: Colors.white),
                              ),)
                        ),
                        Container(
                          // btndangnhap5kV (5:240)
                          margin: EdgeInsets.fromLTRB(25*fem, 0*fem, 25*fem, 0*fem),
                          width: 300,
                          height: 50*fem,
                          decoration: BoxDecoration (
                            color: const Color(0xff007373),
                            borderRadius: BorderRadius.circular(90*fem),
                          ),
                          child: Center(
                            child: Center(
                              child: TextButton(
                                onPressed: (){},
                                child: GestureDetector(
                                  onTap: (){
                                    if(formKey.currentState!.validate()){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const DanhMucSanPham()));
                                      double donGia = double.parse(price.text);
                                      final edit = CaPhe(donGia, quantity.text, imageURL, idCate.text, size, descrip.text, name.text);
                                      updateCaPhe(edit, widget.id);
                                    }

                                  },
                                  child: Text( 'Xác nhận thay đổi',
                                      textAlign: TextAlign.center,
                                      style: SafeGoogleFont (
                                        'Quicksand',
                                        fontSize: 16*ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.2000000477*ffem/fem,
                                        color: const Color(0xfffcf2d9),)

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

