import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flexing Container'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  static const _itemCount =10;
  int filas = 1;
  int columnas = 1;

  PageController _filasController;
  PageController _columnasController;

  @override
  void initState(){
    super.initState();
    _filasController = PageController();
    _columnasController=PageController();
    _filasController.addListener(() {_establecerFC();});
    _columnasController.addListener(() {_establecerFC();});
  }

  void _establecerFC(){
    setState(() {
      filas=_filasController.page.floor()+1;
      columnas = _columnasController.page.floor()+1;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
          
          children: <Widget>[
            SizedBox(
              height:60,
              child:PageView.builder(
                controller: _filasController,
                itemBuilder: (context, page){ 
                  return Center(child:Text('${page+1}'));
                },
                itemCount: _itemCount
                )
              
              ),
            Divider(),
            SizedBox(
              height:60,
              child:PageView.builder(
                controller: _columnasController,
                itemBuilder: (context, page){ 
                  return Center(child:Text('${page+1}'));
                },
                itemCount: _itemCount
                )
              
              ),
            Divider(),
            for(int f=0 ;f<filas;f++)...{
              Expanded(child:Row(children: [
              for(int c =0;c<columnas;c++)...{
                Expanded(child:
                Container(
                height: MediaQuery.of(context).size.height,
                child:Center(child:Text('$f$c',style: TextStyle(fontSize: 20),)),
                decoration: BoxDecoration(border:Border.all(color:Colors.blue),color: Colors.grey[400]),
                ))
              }
              ])),
            }

          ],
        ),
      ),
      
    );
  }
}
