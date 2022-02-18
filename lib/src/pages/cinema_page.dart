import 'package:cinema_app/src/data/data.dart';
import 'package:cinema_app/src/widgets/appbar_widget.dart';
import 'package:cinema_app/src/widgets/item_circle_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CinemaPage extends StatefulWidget {
  const CinemaPage({Key key}) : super(key: key);

  @override
  State<CinemaPage> createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage>
    with SingleTickerProviderStateMixin {
  final controller = TransformationController();
  TapDownDetails tapDownDetails;
  AnimationController animationController;
  Animation<Matrix4> animation;
  //
  @override
  void initState() {
    super.initState();
    animationInit();
  }

  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }

  void animationInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    )..addListener(() {
        controller.value = animation?.value;
      });
  }

  void reset() {
    final animationReset = Matrix4Tween(
      begin: controller.value,
      end: Matrix4.identity(),
    ).animate(animationController);

    animationReset.addListener(() {
      controller.value = animationReset?.value;
    });
    animationController.reset();
    animationController.forward();
  }

  void zoom() {
    final double scale = 2.5;
    final zoomed = Matrix4.identity()
      ..translate(-300.11, -300.09)
      ..scale(scale);

    final value = zoomed;
    controller.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getBody(context),
    );
  }

  Widget getAppbar() {
    return AppBarWidget(
      title: 'Concierto de Nicky Jam Verano X Sanber',
      subtitle: 'Miércoles 22-04-21 18:00',
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget getBody(context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _getContainerCinema(context),
          _getBottomSheetBuy(),
        ],
      ),
    );
  }

  Widget _getContainerCinema(context) {
    var size = MediaQuery.of(context).size;

    return Expanded(
      flex: 9,
      child: Stack(
        children: [
          _getCinemaView(size),
          _getButtonsColumn(),
        ],
      ),
    );
  }

  Widget _getCinemaView(Size size) {
    return GestureDetector(
      onDoubleTapDown: (details) => tapDownDetails = details,
      onDoubleTap: actionZoomInZoom,
      child: InteractiveViewer(
        transformationController: controller,
        minScale: 0.5,
        maxScale: 20,
        boundaryMargin: EdgeInsets.all(double.infinity),
        child: Container(
          color: Colors.grey[100],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
            child: Container(
              color: Colors.grey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Container(), flex: 2),
                  _titleCinema(size),
                  Expanded(child: Container(), flex: 1),
                  SizedBox(height: 10),
                  _getAsientosCurve(),
                  Expanded(child: Container(), flex: 9),
                ],
              ),
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
      flex: 8,
      child: Container(
        // color: Colors.white,
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
                        ItemCircleWidget(i: i, j: j),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getButtonsColumn() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getItemButton(CupertinoIcons.minus, () {
            reset();
          }),
          SizedBox(height: 25),
          _getItemButton(CupertinoIcons.add, () {
            zoom();
          }),
        ],
      ),
    );
  }

  Widget _getItemButton(IconData icon, Function accion) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: accion,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 2,
            ),
          ],
        ),
        child: Padding(
            padding: EdgeInsets.all(12),
            child: FittedBox(
              child: Icon(
                icon,
                color: Colors.black,
              ),
            )),
      ),
    );
  }

  Widget _getBottomSheetBuy() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _getButtonTextCarrito(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('\$137,02'),
                SizedBox(width: 20),
                _getButtonBuy(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _getButtonTextCarrito() {
    return Container(
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Positioned(
              top: 15,
              right: 10,
              child: Container(
                padding: EdgeInsets.all(2),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: FittedBox(
                    child: Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                )),
              )),
          CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0,
            onPressed: () {},
            child: Row(
              children: [
                Text(
                  'Ver Carrito',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15),
                ),
                SizedBox(width: 5),
                Icon(CupertinoIcons.chevron_compact_down,
                    size: 11, color: Colors.black)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getButtonBuy() {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.amber[400],
          borderRadius: BorderRadius.circular(20),
        ),
        child: FittedBox(
          child: Text(
            'Comprar',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void actionZoomInZoom() {
    final position = tapDownDetails?.localPosition;

    final double scale = 3;
    final x = -position.dx * (scale - 1);
    final y = -position.dy * (scale - 1);
    final zoomed = Matrix4.identity()
      ..translate(x, y)
      ..scale(scale);

    // final value =
    final end = controller.value.isIdentity() ? zoomed : Matrix4.identity();
    // controller.value = value;
    animation = Matrix4Tween(
      begin: controller.value,
      end: end,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(animationController),
    );
    animationController.forward(from: 0);
  }
}
