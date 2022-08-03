import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mosquito_alraming_app/const/colors.dart';
import 'package:mosquito_alraming_app/const/data.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String region = '서울';
  int? level;
  ScrollController scrollController = ScrollController();

  TextStyle main_style = GoogleFonts.notoSansKharoshthi(
    fontWeight: FontWeight.w700,
    color: Colors.brown[400],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LIGHT_COLOR,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: LIGHT_COLOR,
        title: Text(
          '모기모기',
          style: main_style.copyWith(
              color: Colors.brown, fontWeight: FontWeight.w900, fontSize: 30),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<int>(
            future: fetchLevel(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              level = snapshot.data;

              return Container(
                color: colors[level! - 1],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('asset/$level.png'))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      region,
                      style: main_style.copyWith(
                          fontSize: 55,
                          color: (level == 4 || level == 3 || level == 2)
                              ? Colors.white
                              : Colors.brown[400]),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '$level단계, ${LEVEL_STAGE[level! - 1]}',
                      style: main_style.copyWith(
                          fontSize: 40,
                          color: (level == 4 || level == 3 || level == 2)
                              ? Colors.white
                              : Colors.brown[400]),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LEVEL_TEXT[level! - 1],
                          style: main_style.copyWith(
                              fontSize: 40,
                              color: (level == 4 || level == 3 || level == 2)
                                  ? Colors.white
                                  : Colors.brown[400]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: REGION
                          .map(
                            (region) => renderRegion(region: region),
                          )
                          .toList(),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<int> fetchLevel() async {
    Map<String, dynamic> data;

    if (region == '서울') {
      data = SEOUL_DATA;
    } else if (region == '오송') {
      data = OSONG_DATA;
    } else if (region == '울산') {
      data = ULSAN_DATA;
    } else {
      data = JEJU_DATA;
    }

    const url = 'http://127.0.0.1:5000';

    await http.post(Uri.parse(url),
        body:
            json.encode({'temp': data['temp'], 'rainFall': data['rainFall']}));
    final response = await http.get(Uri.parse(url));
    final result = jsonDecode(response.body);

    return result['result'];
  }

  Widget renderRegion({required String region}) {
    Map<String, dynamic> data;

    if (region == '서울') {
      data = SEOUL_DATA;
    } else if (region == '오송') {
      data = OSONG_DATA;
    } else if (region == '울산') {
      data = ULSAN_DATA;
    } else {
      data = JEJU_DATA;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          this.region = region;
        });
      },
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0.3,
              spreadRadius: 0.1,
            ),
          ],
          border: Border.all(color: MAIN_COLOR),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              region,
              style: main_style,
            ),
            const SizedBox(
              height: 9,
            ),
            Text(
              '기온: ${data['temp']},',
              style: main_style,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              '강수량: ${data['rainFall']}',
              style: main_style,
            ),
          ],
        ),
      ),
    );
  }
}
