import 'dart:io';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:todoapp/export_all.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userId;
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descTextController = TextEditingController();

  @override
  void initState() {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // Now you can use your decoded token
    // print(decodedToken);
    userId = decodedToken["_id"];
    // bool isTokenExpired = JwtDecoder.isExpired(token);

    // if (!isTokenExpired) {
    //   Navigator.of(context).pushNamedAndRemoveUntil('/LoginScreen', (Route<dynamic> route) => false);
    // }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleTextController.dispose();
    descTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const  BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage("https://thumbs.dreamstime.com/b/todo-list-seamless-pattern-universal-background-66678083.jpg",), fit: BoxFit.fill)
        
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xffF64F59),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r))),
          centerTitle: true,
          title: Text(
            'Todo',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18.sp),
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          height: 60.0,
          color: Color(0xffF64F59),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'MainButton',
          onPressed: () {
            showDialog(
                context: context,
    
                // user must tap button!
                builder: (BuildContext context) {
                  return Material(
                    type: MaterialType.transparency,
                    child: Container(
                      padding: EdgeInsets.all(20.r),
                      margin:
                          EdgeInsets.symmetric(horizontal: 30.r, vertical: 180.r),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // 30.verticalSpace,
                          Text(
                            'Add Todo',
                            style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
    
                          TextWidget(
                            controller: titleTextController,
                            fillColor: Color.fromARGB(255, 238, 222, 227),
                            hintText: "Title",
                          ),
                          TextWidget(
                            controller: descTextController,
                            fillColor: Color.fromARGB(255, 238, 222, 227),
                            hintText: "Description...",
                            maxlines: 5,
                          ),
                          Platform.isAndroid
                              ? ButtonWidgetAndroid(
                                  buttonText: "Add".toUpperCase(),
                                  width: 362.w,
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                    titleTextController.text = "";
                                    descTextController.text = "";
                                  },
                                )
                              : ButtonWidgetIOS(
                                  buttonText: "Add".toUpperCase(),
                                  width: 362.w,
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                    titleTextController.text = "";
                                    descTextController.text = "";
                                  },
                                )
                        ],
                      ),
                    ),
                  );
                });
          },
          backgroundColor: const Color.fromARGB(209, 119, 51, 48),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // fluter 1.x
        resizeToAvoidBottomInset: false,
        body: ListView(
                padding: EdgeInsets.all(15.r),
    
          children: [
            Slidable(
                // Specify a key if the Slidable is dismissible.
                key: const ValueKey(0),
    
                // The start action pane is the one at the left or the top side.
                
    
                // The end action pane is the one at the right or the bottom side.
                endActionPane: ActionPane(
                  // A motion is a widget used to control how the pane animates.
                  motion: const ScrollMotion(),
                  extentRatio: 0.3,
                  // A pane can dismiss the Slidable.
                  // dismissible: DismissiblePane(onDismissed: () {}),
    
                  // All actions are defined in the children parameter.
                  children:  [
                    // A SlidableAction can have an icon and/or a label.
                    SlidableAction(
                      onPressed: (context){},
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.red,
                      icon: Icons.delete,
                      flex: 3,
                      label: 'Delete',
                    ),
                    
                  ],
                ),
    
                // The child of the Slidable is what the user sees when the
                // component is not dragged.
                child:  Card(
              clipBehavior: Clip.none,
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r)
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: IconButton(onPressed: (){}, icon: Icon(Icons.check_box_outline_blank)),
                title: Text('Todo title', style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                
                ),
                
                ),
                subtitle: Text("subtitle", style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black
                ),),
                trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit, size: 18.r,)),
              ),
            )
          
              ),
           ],
        ),
      ),
    );
  }
}