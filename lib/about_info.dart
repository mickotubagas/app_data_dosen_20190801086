import 'package:app_data_dosen_20190801086/themeColor.dart';
import 'package:flutter/material.dart';

class AboutInfo extends StatelessWidget {
  const AboutInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Themes.color,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 75,
                child: Text(
                  "About Info",
                  style: TextStyle(
                    fontFamily: 'jaapokkienchance',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      "images/admin.jpg",
                      fit: BoxFit.contain,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: const Text(
                  "App data dosen merupakan aplikasi yang digunakan untuk melakukan fungsi CRUD manajemen data dosen sederhana, di mana menyuguhkan viewing list data dosen yang ada untuk nantinya dapat dimanage sedemikian rupa oleh pengguna app.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'jaapokkienchance',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Text(
                  "Creat By : \nMicko Tubagas [20190801086]",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'jaapokkienchance',
                    color: Colors.white54,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
