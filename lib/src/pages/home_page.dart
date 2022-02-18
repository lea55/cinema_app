import 'package:cinema_app/src/data/data.dart';
import 'package:cinema_app/src/pages/cinema_page.dart';
import 'package:cinema_app/src/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true, //Con esto el body ocupa todo
      appBar: getAppbar(),
      body: getBody(context),
    );
  }

  Widget getAppbar() {
    return AppBarWidget(
      title: 'Concierto de Nicky Jam Verano X Sanber',
      subtitle: 'Miércoles 22-04-21 18:00',
      onPressed: () {},
    );
  }

  Widget getBody(context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: double.infinity,
      color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getCinemaView(size, context),
          _getListViewIn(),
        ],
      ),
    );
  }

  Widget _getCinemaView(Size size, context) {
    return Expanded(
      flex: 6,
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
          child: Container(
            // color: Colors.blue,
            color: Colors.grey[100],

            child: Column(
              children: [
                _titleCinema(size),
                SizedBox(height: 10),
                _getAsientosCurve(),
                SizedBox(height: 10),
                _bottomTitle(size, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleCinema(Size size) {
    return Container(
      width: size.width * 0.4,
      height: 40,
      decoration: BoxDecoration(color: Colors.black),
      child: Center(
        child: Text(
          'ESCENARIO',
          style: TextStyle(
              color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _getAsientosCurve() {
    return Expanded(
      child: Container(
        color: Colors.grey[100],
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            for (int i = 0; i < asientos3.length; i++)
              Positioned(
                top: i.toDouble() * 5.5,
                child: Container(
                  padding: EdgeInsets.only(top: 0),
                  child: Row(
                    children: [
                      for (int j = 0; j < asientos3[i].length; j++)
                        Padding(
                          padding: j <= (asientos3.length / 2)
                              ? EdgeInsets.only(top: j.toDouble() * 1) // 1!
                              : EdgeInsets.only(
                                  bottom: j.toDouble() * 1.5 - 21.5,
                                  top: 18), // 1! - 10!, 12! // formato U
                          // padding: EdgeInsets.only(
                          //     top: j.toDouble() * 1.5), //Bajada
                          // padding: EdgeInsets.only(
                          //     bottom: j.toDouble() * 1.5), //Subida
                          child: Container(
                            height: 4.5,
                            width: 4.5,
                            decoration: BoxDecoration(
                              color: asientos3[i][j] == 0
                                  ? Colors.red
                                  : asientos3[i][j] == 1
                                      ? Colors.grey[400]
                                      : asientos3[i][j] == 2
                                          ? Colors.blue
                                          : asientos3[i][j] == 5
                                              ? Colors.green
                                              : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            margin: EdgeInsets.only(top: 2, right: 2),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _bottomTitle(Size size, context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                animation = CurvedAnimation(
                    parent: animation, curve: Curves.easeInOutQuint);
                return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child);
              },
              pageBuilder: (context, animation, secondaryAnimation) {
                return CinemaPage();
              },
            ));
      },
      child: Container(
        width: size.width * 0.50,
        height: 30,
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Text(
            'Comprar en mapa',
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _getListViewIn() {
    return Expanded(
      flex: 6,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getTitleListView(),
              SizedBox(height: 20),
              _getListItems(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitleListView() {
    return Padding(
      padding: EdgeInsets.only(left: 30, top: 30),
      child: Text('Entradas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }

  Widget _getListItems() {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
            color: Colors.grey,
            indent: 25,
            endIndent: 25,
          );
        },
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _getItemIn(index);
        },
        itemCount: listaEntradas.length);
  }

  Widget _getItemIn(int index) {
    return Container(
      child: ListTile(
        minLeadingWidth: 30,
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.only(left: 30),
        leading: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: listaEntradas[index]['color'],
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          '${listaEntradas[index]['title']}',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '\$ ${listaEntradas[index]['price']}',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        trailing: _getTrailingItemList(),
      ),
    );
  }

  Widget _getTrailingItemList() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[200]),
              child: Text('-'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Text('${0}'),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[200]),
              child: Text('+'),
            ),
          ),
        ],
      ),
    );
  }
}
