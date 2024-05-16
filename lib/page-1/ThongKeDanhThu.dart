import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:myapp/utils.dart';

class ThongKeDoanhThu extends StatefulWidget {
  const ThongKeDoanhThu({super.key});

  @override
  State<ThongKeDoanhThu> createState() => _ThongKeDoanhThuState();
}

class _ThongKeDoanhThuState extends State<ThongKeDoanhThu> {
  List<String> fieldValues = [];
  double fieldSum = 0;
  int cartCount = 0;

  @override
  void initState() {
    super.initState();
    loadFieldValues();
  }

  Future<int> loadCategoryValues() async {
    var collectionRef = FirebaseFirestore.instance.collection('Bill');
    var querySnapshot = await collectionRef.get();
    cartCount = querySnapshot.size;
    return cartCount;
  }

  void loadFieldValues() async {
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('Bill').get();

    List<String> values = querySnapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['tongHoaDon']?.toString() ?? '').toList();

    setState(() {
      fieldValues = values;
      fieldSum = calculateFieldSum();
    });
  }

  double calculateFieldSum() {
    double sum = fieldValues
        .map((value) => double.tryParse(value) ?? 0)
        .fold(0, (total, value) => total + value);
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Container(
              // thongkedoanhthupqP (385:1752)
              padding:
              EdgeInsets.fromLTRB(6 * fem, 16 * fem, 6 * fem, 52 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/page-1/images/hinhnen1-bg.png',
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // autogroupmkex1Q5 (WXgHrLzoHS7H8qqqMHMkEX)
                    margin: EdgeInsets.fromLTRB(
                        10 * fem, 0 * fem, 13 * fem, 53 * fem),
                    width: double.infinity,
                    height: 143 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // logomau6wK (385:1754)
                          left: 114 * fem,
                          top: 16 * fem,
                          child: Align(
                            child: SizedBox(
                              // width: 100 * fem,
                              height: 100 * fem,
                              child: Image.asset(
                                'assets/page-1/images/logomau.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // caukhauhieuDFF (385:1755)
                          left: 3 * fem,
                          top: 114 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 322 * fem,
                              height: 29 * fem,
                              child: Text(
                                'Thưởng thức vị ngon trọn vẹn',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Dancing Script',
                                  fontSize: 24 * ffem,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2 * ffem / fem,
                                  letterSpacing: 1 * fem,
                                  color: Color(0xff993300),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // vector5oF (385:1756)
                          left: 0 * fem,
                          top: 0 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 32 * fem,
                              height: 32 * fem,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Image.asset(
                                  'assets/page-1/images/vector.png',
                                  width: 32 * fem,
                                  height: 32 * fem,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // tnghanxutz9X (385:1757)
                    margin: EdgeInsets.fromLTRB(
                        14 * fem, 0 * fem, 0 * fem, 1 * fem),
                    child: Text(
                      'Tổng hóa đơn đã xuất:',
                      style: SafeGoogleFont(
                        'Quicksand',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.25 * ffem / fem,
                        letterSpacing: 1 * fem,
                        color: Color(0xff007373),
                      ),
                    ),
                  ),
                  Container(
                    // autogrouptrbzrSd (WXgJ3kqTAJPoRQM2pptRbZ)
                    margin: EdgeInsets.fromLTRB(
                        14 * fem, 0 * fem, 30 * fem, 24 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // BUu (385:1762)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 110 * fem, 0 * fem),
                          child: FutureBuilder<int>(
                            future: loadCategoryValues(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  '${snapshot.data}',
                                  style: SafeGoogleFont(
                                    'Quicksand',
                                    fontSize: 24 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.25 * ffem / fem,
                                    letterSpacing: 1 * fem,
                                    color: Color(0xff993300),
                                  ),
                                );
                              } else {
                                return CircularProgressIndicator(); // Hoặc bất kỳ tiến trình tải nào khác bạn muốn hiển thị
                              }
                            },
                          ),
                        ),
                        Text(
                          // hant8R (385:1763)
                          'hóa đơn',
                          style: SafeGoogleFont(
                            'Quicksand',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.25 * ffem / fem,
                            letterSpacing: 1 * fem,
                            color: Color(0xff007373),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // doanhthutcQMf (385:1758)
                    margin: EdgeInsets.fromLTRB(
                        14 * fem, 0 * fem, 0 * fem, 4 * fem),
                    child: Text(
                      'Doanh thu đạt được:',
                      style: SafeGoogleFont(
                        'Quicksand',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.25 * ffem / fem,
                        letterSpacing: 1 * fem,
                        color: Color(0xff007373),
                      ),
                    ),
                  ),
                  Container(
                    // autogrouplkwqhLm (WXgJCvErNn4tgpKvNgLKwq)
                    margin: EdgeInsets.fromLTRB(
                        14 * fem, 0 * fem, 57 * fem, 21 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // 2dw (385:1764)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 58 * fem, 0 * fem),
                          child: Text(
                            '${fieldSum}',
                            style: SafeGoogleFont(
                              'Quicksand',
                              fontSize: 24 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.25 * ffem / fem,
                              letterSpacing: 1 * fem,
                              color: Color(0xff993300),
                            ),
                          ),
                        ),
                        Text(
                          // vndjoF (385:1765)
                          'VND',
                          style: SafeGoogleFont(
                            'Quicksand',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.25 * ffem / fem,
                            letterSpacing: 1 * fem,
                            color: Color(0xff007373),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // thuphitrG2V (385:1759)
                    margin: EdgeInsets.fromLTRB(
                        14 * fem, 0 * fem, 0 * fem, 7 * fem),
                    child: Text(
                      'Thuế phải trả:',
                      style: SafeGoogleFont(
                        'Quicksand',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.25 * ffem / fem,
                        letterSpacing: 1 * fem,
                        color: Color(0xff007373),
                      ),
                    ),
                  ),
                  Container(
                    // autogroup5stzxAD (WXgJJFRJY9SafEpoTW5sTZ)
                    margin: EdgeInsets.fromLTRB(
                        14 * fem, 0 * fem, 57 * fem, 18 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // Gwb (385:1761)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 79 * fem, 0 * fem),
                          child: Text(
                            '${fieldSum * 0.1}',
                            style: SafeGoogleFont(
                              'Quicksand',
                              fontSize: 24 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.25 * ffem / fem,
                              letterSpacing: 1 * fem,
                              color: Color(0xffff0000),
                            ),
                          ),
                        ),
                        Text(
                          // vndCKT (385:1766)
                          'VND',
                          style: SafeGoogleFont(
                            'Quicksand',
                            fontSize: 24 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.25 * ffem / fem,
                            letterSpacing: 1 * fem,
                            color: Color(0xff007373),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // biudoanhthutheoloiY8R (385:1760)
                    margin: EdgeInsets.fromLTRB(
                        14 * fem, 0 * fem, 0 * fem, 7 * fem),
                    constraints: BoxConstraints(
                      maxWidth: 223 * fem,
                    ),
                    child: Text(
                      'Biểu đồ doanh thu theo loại:',
                      style: SafeGoogleFont(
                        'Quicksand',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w700,
                        height: 1.25 * ffem / fem,
                        letterSpacing: 1 * fem,
                        color: Color(0xff007373),
                      ),
                    ),
                  ),
                  Container(
                    // autogroup6axt2ZP (WXgJTVeu35jMX4kWvu6AxT)
                    margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 9 * fem, 0 * fem),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart2(),
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

class PieChart2 extends StatefulWidget {
  const PieChart2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChart2> {
  int touchedIndex = -1;
  var color;

  Future<List<Map<String, dynamic>>> getCombinedData() async {
    try {
      Map<String, Map<String, dynamic>> combinedDataMap =
          {}; // Dùng Map thay vì List
      Set<String> uniqueIdCates = Set<String>();

      QuerySnapshot billSnapshot =
          await FirebaseFirestore.instance.collection('Bill').get();
      List<DocumentSnapshot> billDocs = billSnapshot.docs;

      for (int index = 0; index < billDocs.length; index++) {
        Map<String, dynamic> billData =
            billDocs[index].data() as Map<String, dynamic>;

        QuerySnapshot productsSnapshot =
            await billDocs[index].reference.collection('products').get();
        List<DocumentSnapshot> productDocs = productsSnapshot.docs;

        for (int i = 0; i < productDocs.length; i++) {
          String idCate = productDocs[i]['idCate'];

          // Kiểm tra xem idCate đã được xử lý chưa
          if (!uniqueIdCates.contains(idCate)) {
            uniqueIdCates.add(idCate);
            combinedDataMap[idCate] =
                {}; // Tạo một entry mới trong Map nếu idCate chưa tồn tại
            combinedDataMap[idCate]?['thanhTien'] =
                0; // Khởi tạo giá trị thanhTien
          }

          // Lấy tổng giá trị thanhTien cho idCate
          double thanhTien =
              double.tryParse(productDocs[i]['thanhTien']?.toString() ?? '') ??
                  0;
          combinedDataMap[idCate]?['thanhTien'] += thanhTien;
        }
      }

      // Truy vấn collection "Category" và lấy thông tin quan trọng
      await Future.forEach(combinedDataMap.keys, (idCate) async {
        DocumentSnapshot categorySnapshot = await FirebaseFirestore.instance
            .collection('Category')
            .doc(idCate)
            .get();
        Map<String, dynamic> categoryData =
            categorySnapshot.data() as Map<String, dynamic>;
        combinedDataMap[idCate]?['importantFieldValue'] = categoryData['Name'];
      });

      // Chuyển dữ liệu từ Map sang List
      List<Map<String, dynamic>> combinedDataList =
          combinedDataMap.values.toList();

      return combinedDataList;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }



  List<Color> getColors() {
    return [
      Colors.black,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      // Add more colors if needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: FutureBuilder(
                      // Truy vấn dữ liệu từ collection "Cart" và "Category"
                      future: getCombinedData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map<String, dynamic>>>
                          combinedDataSnapshot) {
                        if (combinedDataSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        if (combinedDataSnapshot.hasError) {
                          return Text('Error: ${combinedDataSnapshot.error}');
                        }

                        List<Map<String, dynamic>> combinedDataList =
                            combinedDataSnapshot.data ?? [];

                        // Trả về PieChart với dữ liệu từ hàm showingSections
                        return PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(combinedDataList),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  // width: 28,
                ),
                Container(
                  width: 166,
                  child: FutureBuilder(
                    // Truy vấn dữ liệu từ collection "Cart" và "Category"
                    future: getCombinedData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Map<String, dynamic>>>
                        combinedDataSnapshot) {
                      if (combinedDataSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (combinedDataSnapshot.hasError) {
                        return Text('Error: ${combinedDataSnapshot.error}');
                      }

                      List<Map<String, dynamic>> combinedDataList =
                          combinedDataSnapshot.data ?? [];

                      // Trả về ListView từ dữ liệu Cart và Category
                      return ListView.builder(
                        itemCount: combinedDataList.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> combinedData =
                          combinedDataList[index];

                          // Lấy giá trị quan trọng
                          var importantFieldValue =
                          combinedData['importantFieldValue'];

                          // Lấy màu từ danh sách màu
                          color = getColors()[index % getColors().length];

                          // Trả về ListTile từ dữ liệu Category
                          return ListTile(
                            title: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: color,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '$importantFieldValue',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(
      List<Map<String, dynamic>> combinedDataList) {
    int totalValues = combinedDataList.length;

    double sum = 0;

    // Tính tổng giá trị của tất cả thanhTien
    for (int i = 0; i < combinedDataList.length; i++) {
      sum += combinedDataList[i]['thanhTien'] as double;
    }

    return List.generate(totalValues, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      // Lấy giá trị thanhTien cho idCate hiện tại
      double thanhTien = combinedDataList[i]['thanhTien'] as double;

      // Tính giá trị của từng phần dựa trên tỷ lệ so với tổng giá trị
      double sectionValue = (thanhTien / sum) * 100;

      return PieChartSectionData(
        color: getColors()[i % getColors().length],
        value: sectionValue,
        title:
        '${sectionValue.toStringAsFixed(2)}%', // Thay đổi tiêu đề theo giá trị thực
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
          decoration: TextDecoration.none,
        ),
      );
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: ThongKeDoanhThu(),
  ));
}
