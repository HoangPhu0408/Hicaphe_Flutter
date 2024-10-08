import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/page-1/DangKi.dart';
import 'package:myapp/page-1/QuenMatKhau.dart';
import 'package:myapp/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class DangNhap extends StatefulWidget {
  const DangNhap({super.key});

  @override
  State<DangNhap> createState() => _DangNhap();
}

class _DangNhap extends State<DangNhap> {
  final formKey = GlobalKey<FormState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // bool _isSigning = false;

  bool _passwordVisible = false;

  final FirebaseAuthService _auth = FirebaseAuthService();

  final  TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
              reverse: true,
              physics: ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    // dangnhap3qs (39:445)
                    onPressed: () {},
                    style: TextButton.styleFrom (
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(26, 8, 26, 154),
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
                            // autogroupndguYw3 (HWRLQier6qzom6WaJmNDGu)
                            margin: const EdgeInsets.fromLTRB(4, 0, 2, 93),
                            width: double.infinity,
                            height: 130,
                            child: Stack(
                              children: [
                                Positioned(
                                  // logomaudSh (87:388)
                                  left: 110,
                                  right: 110,
                                  top: 5,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Image.asset(
                                        'assets/page-1/images/logomau.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  // frame36srq (44:675)
                                  left: -20,
                                  right: -20,
                                  top: 99,
                                  child: SizedBox(
                                    width: 360,
                                    height: 31,
                                    child: Center(
                                      child: Text(
                                        'Thưởng thức vị ngon trọn vẹn',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont (
                                          'Dancing Script',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          height: 1.2,
                                          letterSpacing: 1,
                                          color: const Color(0xff993300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // bieumaudangnhapcT3 (39:461)
                            padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                            decoration: BoxDecoration (
                              color: const Color(0xb2f5dab1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogroupa5a14Zw (HWRLdDJ2fgHCm2JWnPA5a1)
                                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 49),
                                  padding: const EdgeInsets.fromLTRB(0, 0, 36.5, 0),
                                  width: double.infinity,
                                  height: 36,
                                  decoration: BoxDecoration (
                                    border: Border.all(color: const Color(0xff007373)),
                                    color: const Color(0xfffcf2d9),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // group32RYu (39:463)
                                        margin: const EdgeInsets.fromLTRB(0, 0, 35.5, 0),
                                        width: 133,
                                        height: double.infinity,
                                        decoration: BoxDecoration (
                                          color: const Color(0xff007373),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Đăng nhập',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont (
                                              'Quicksand',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 1.25,
                                              color: const Color(0xfffcf2d9),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // btndangkiPe9 (39:466)
                                        margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const DangKi()));
                                          },
                                          style: TextButton.styleFrom (
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: Text(
                                            'Đăng kí',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont (
                                              'Quicksand',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              height: 1.25,
                                              color: const Color(0xff007373),
                                            ),

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                const SizedBox(height: 30,),
                                Container(
                                  child: TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return  'Email không được trống';
                                      }
                                      else{
                                        return null;
                                      }
                                    },
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:  BorderRadius.all(
                                            Radius.circular(30.0) , ),
                                          borderSide: const BorderSide(color: Color(0xff007373), width: 1.0),

                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                          borderSide:  BorderSide(color: Color(0xff007373) ),

                                        ),
                                        suffixIcon: const Icon(Icons.email),
                                        suffixIconColor: Color(0xff007373),
                                        hintStyle: new TextStyle(color: Color(0xff007373)),
                                        hintText: "Nhập thư điện tử",
                                        fillColor: Colors.white),
                                  ),
                                ),

                                const SizedBox(height: 30,),
                                Container(
                                  // edtnhapemailaTj (39:467)
                                  // margin: EdgeInsets.fromLTRB(1, 0, 0, 25),
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: TextFormField(
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return  'Mật khẩu không được trống';
                                      }
                                      else{
                                        return null;
                                      }
                                    },
                                    obscureText: !_passwordVisible,
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                        enabledBorder:  OutlineInputBorder(
                                          borderRadius:  BorderRadius.all(
                                            Radius.circular(30.0) ,
                                          ),
                                          // width: 0.0 produces a thin "hairline" border
                                          borderSide: const BorderSide(color: Color(0xff007373), width: 1.0),
                                        ),
                                        focusedBorder: new OutlineInputBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                          borderSide:  BorderSide(color: Color(0xff007373) ),

                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            _passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Color(0xff007373),
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _passwordVisible = !_passwordVisible;
                                            });
                                          },
                                        ),
                                        suffixIconColor: Color(0xff007373),

                                        hintStyle: new TextStyle(color: Color(0xff007373)),
                                        hintText: "Nhập mật khẩu",
                                        fillColor: Colors.white),
                                  ),
                                ),


                                Container(
                                  // txquenmatkhauw7F (39:476)
                                  margin: const EdgeInsets.fromLTRB(154, 0, 0, 10),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> QuenMatKhau()));
                                    },
                                    style: TextButton.styleFrom (
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: Text(
                                      'Quên mật khẩu',
                                      style: SafeGoogleFont (
                                        'Quicksand',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        height: 1.25,
                                        color: const Color(0xff007373),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _signIn,
                                  // onTap: () {
                                  //   Navigator.push(context,
                                  //       MaterialPageRoute(builder: (context) => TrangChu()));
                                  // },
                                  child: Container(
                                    // btndangnhap177 (39:477)
                                    margin: const EdgeInsets.fromLTRB(50, 0, 39, 0),
                                    width: double.infinity,
                                    height: 40,
                                    decoration: BoxDecoration (
                                      color: const Color(0xff007373),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Center(
                                        child: Text(
                                          'Đăng nhập',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont (
                                            'Quicksand',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2000000477,
                                            color: const Color(0xfffcf2d9),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: ElevatedButton.icon(
                                    onPressed: _signInWithGoogle,
                                    icon: Icon(Icons.login),
                                    label: Text('Đăng nhập bằng Google'),
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
              )
          ),
        ),
      ),
    );
  }
  //đăng nhập bằng google
  void _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          // Perform role-based navigation here
          // For example, check user's role in Firestore and navigate accordingly
          Fluttertoast.showToast(msg: 'Đăng nhập thành công!');
        } else {
          Fluttertoast.showToast(msg: 'Đăng nhập thất bại!');
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Đăng nhập thất bại!');
    }
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    if(formKey.currentState!.validate()){
      // Fluttertoast.showToast(msg: 'Bạn chưa điền thông tin');
    }
    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Bạn chưa điền thông tin');
      return; // Dừng việc thực thi hàm nếu thông tin nhập vào trống
    }
    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {

      // Đọc thông tin người dùng từ Firestore
      FirebaseFirestore.instance
          .collection('Users')
          .where('uid', isEqualTo: user.uid)
          .get()
          .then((docs) {
        if (docs.docs.isNotEmpty) {
          String role = docs.docs[0]['role'];
          if (role == 'admin') {
            // Đăng nhập với vai trò admin
            Navigator.pushReplacementNamed(context, "/admin");
          } else if (role == 'nhanvien') {
            // Đăng nhập với vai trò nhân viên
            Navigator.pushReplacementNamed(context, "/nhanvien");
          } else {
            // Đăng nhập với vai trò khách hàng
            Navigator.pushReplacementNamed(context, "/khachhang");
          }
        } else {
          Fluttertoast.showToast(msg: 'Email hoặc mật khẩu không tồn tại');
          print("User's document not found in Firestore");
        }
        Fluttertoast.showToast(msg: 'Đăng nhập thành công!');
      });
    } else {
      print("Some error happened");
      Fluttertoast.showToast(msg: 'Đăng nhập thất bại!');
      Fluttertoast.showToast(msg: 'Mật khẩu hoặc tài khoản không chính xác, vui lòng nhập lại');

    }
  }
}