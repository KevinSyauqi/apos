import 'package:apos/src/bloc/bloc.dart';
import 'package:apos/src/models/pegawaiModels.dart';
import 'package:apos/src/ui/kelola_pegawai_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class KelolaListPegawai extends StatefulWidget {
  @override
  _KelolaListPegawaiState createState() => _KelolaListPegawaiState();
}

class _KelolaListPegawaiState extends State<KelolaListPegawai> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 90),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: BlocBuilder(
          bloc: BlocProvider.of<PegawaiBloc>(context),
          builder: (context, state){
            if(state is FetchingAllPegawaiStore){
              return Center(child: CircularProgressIndicator());
            }
            if(state is PegawaiListLoaded){
              final listPegawai = state.listPegawai;
              return buildPegawaiList(listPegawai);
            }
            return Center(child: CircularProgressIndicator());
          })
    );
  }

  void _showAlertDelete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text("Anda yakin akan menghapusnya?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'CircularStd-Bold')),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(children: <Widget>[
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                      color: Color.fromRGBO(54, 58, 155, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                      child: Text("Hapus",
                          style: TextStyle(
                            color: Colors.white,
                          ))),
                  SizedBox(width: 10),
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                      color: Color.fromRGBO(234, 234, 234, 1),
                      elevation: 5,
                      onPressed: () => Navigator.pop(context),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0))),
                      child: Text("Batal",
                          style: TextStyle(
                            color: Colors.black,
                          ))),
                ]),
              )
            ],
          );
        });
  }

  Widget buildPegawaiList(List<Pegawai> listPegawai) {
    return ListView.separated(
        itemCount: listPegawai.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index){
          Pegawai pegawai = listPegawai[index];
          return Container(
           decoration: BoxDecoration(
             border: Border(
                 bottom: BorderSide(
                     color: Color.fromRGBO(224, 224, 224, 1), width: 1.0)),
             color: Color.fromRGBO(250, 250, 250, 1),
           ),
           width: double.infinity,
           height: 80,
           margin: EdgeInsets.symmetric(horizontal: 25),
           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 width: 55,
                 height: 55,
                 margin: EdgeInsets.only(right: 15),
                 decoration: BoxDecoration(
                   color: Color.fromRGBO(234, 234, 234, 1),
                   borderRadius: BorderRadius.circular(20),
                 ),
               ),
               Expanded(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text(pegawai.name_employee,
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 15.0,
                             fontFamily: 'CircularStd-Bold')),
                     Text(pegawai.role,
                         style: TextStyle(
                             color: Colors.black,
                             fontSize: 14.0,
                             fontFamily: 'CircularStd-Book')),
                   ],
                 ),
               ),
               Expanded(
                 child: Container(
                   margin: EdgeInsets.only(top: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: <Widget>[
                       Container(
                         width: 32,
                         height: 32,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Color.fromRGBO(54, 58, 155, 1),
                             borderRadius: BorderRadius.circular(13)),
                         child: IconButton(
                           icon: Icon(Icons.edit),
                           iconSize: 17,
                           color: Colors.white,
                           onPressed: () {
                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => EditKelolaPegawai()),
                             );
                           },
                         ),
                       ),
                       SizedBox(width: 5),
                       Container(
                         width: 32,
                         height: 32,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                             color: Color.fromRGBO(54, 58, 155, 1),
                             borderRadius: BorderRadius.circular(13)),
                         child: IconButton(
                           icon: Icon(Icons.delete),
                           iconSize: 17,
                           color: Colors.white,
                           onPressed: () {
                             _showAlertDelete();
                           },
                         ),
                       ),
                     ],
                   ),
                 ),
               )
             ],
           ),
         );
        }
    );
  }
}
