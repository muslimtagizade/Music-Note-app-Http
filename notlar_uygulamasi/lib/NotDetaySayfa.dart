import 'package:flutter/material.dart';
import 'package:notlar_uygulamasi/Notlar.dart';
import 'package:notlar_uygulamasi/main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class NotDetaySayfa extends StatefulWidget {
  Notlar not;

  NotDetaySayfa({this.not});

  @override
  _NotDetaySayfaState createState() => _NotDetaySayfaState();
}

class _NotDetaySayfaState extends State<NotDetaySayfa> {

  var tfDersAdi = TextEditingController();
  var tfnot1 = TextEditingController();
  var tfnot2 = TextEditingController();

  Future<void> sil(int not_id) async {
    var url = "http://kasimadalan.pe.hu/notlar/delete_not.php";
    var veri = {"not_id":not_id.toString()};
    var cevap = await http.post(url,body: veri);
    print("Not sil cevap : ${cevap.body}");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  Future<void> guncelle(int not_id,String ders_adi,int not1,int not2) async {
    var url = "http://kasimadalan.pe.hu/notlar/update_not.php";
    var veri = {"not_id":not_id.toString(),"ders_adi":ders_adi,"not1":not1.toString(),"not2":not2.toString()};
    var cevap = await http.post(url,body: veri);
    print("Not güncelle cevap : ${cevap.body}");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfDersAdi.text = not.ders_adi;
    tfnot1.text = not.not1.toString();
    tfnot2.text = not.not2.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Detay"),
        actions: [
          FlatButton(
            child: Text("Sil",style: TextStyle(color: Colors.white),),
            onPressed: (){
              sil(int.parse(widget.not.not_id));
            },
          ),
          FlatButton(
            child: Text("Güncelle",style: TextStyle(color: Colors.white),),
            onPressed: (){
              guncelle(int.parse(widget.not.not_id), tfDersAdi.text, int.parse(tfnot1.text), int.parse(tfnot2.text));
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfDersAdi,
                decoration: InputDecoration(hintText: "Ders Adı"),
              ),
              TextField(
                controller: tfnot1,
                decoration: InputDecoration(hintText: "1. Not"),
              ),
              TextField(
                controller: tfnot2,
                decoration: InputDecoration(hintText: "2. Not"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
