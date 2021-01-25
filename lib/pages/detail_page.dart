import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_plans/models/plan_model.dart';
import 'package:my_plans/services/design_service.dart';
import 'package:my_plans/services/pref_service.dart';
import 'package:my_plans/services/rtdb_service.dart';
import 'package:my_plans/services/store_service.dart';

class DetailPage extends StatefulWidget {

  static final String id = 'detail_page';

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var isLoading = false;
  File _image;
  final picker = ImagePicker();

  var contentController = TextEditingController();
  var dateController = TextEditingController();
  var titleController = TextEditingController();

  void _createPlan() {
    String content = contentController.text.toString();
    String date = dateController.text.toString();
    String title = titleController.text.toString();
    bool isDone = false;
    if(content.isEmpty || date.isEmpty || title.isEmpty) return;

    if(_image == null) {
      _apiAddPlan(title, content, date, null, isDone);
    } else {
      _apiUploadImage(content, title, date, isDone);
    }
  }

  _apiUploadImage(String content, String title, String date, bool isDone) {
    setState(() {
      isLoading = true;
    });
    StoreService.uploadImage(_image).then((imgUrl) => {
      _apiAddPlan(title, content, date, imgUrl, isDone)
    });
  }

  _apiAddPlan (String title, String content, String date, String imgUrl, bool isDone) async{
    var id = await Prefs.loadUserId();
    RTDBService.addNewPlan(new Plan(id, title, date, content, imgUrl, isDone)).then((value) => {
      Navigator.of(context).pop({'data' : 'done'})
    });
  }

  Future _getImage() async {
    final pikcedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pikcedFile != null) {
        _image = File(pikcedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 25,
        title: Text('Create Plan', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 1),),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ]),
                      child: _image != null ?
                      Image.file(_image, fit: BoxFit.cover,):
                      Image.asset('assets/images/ic_gallery1.png', ),
                    ),
                    onTap: _getImage,
                  ),
                  SizedBox(height: 35,),

                  // #title
                  DesignsContainer.textField(titleController, 'Title'),
                  SizedBox(height: 25,),

                  // #content
                  DesignsContainer.textField(contentController, 'Content'),
                  SizedBox(height: 25,),

                  // #date
                  DesignsContainer.textField(dateController, 'Date'),
                  SizedBox(height: 25,),

                  // #create
                  DesignsContainer.flatButton(_createPlan, "Create")
                ],
              ),
            ),
          ),
          isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : SizedBox.shrink()
        ],
      ),
    );
  }
}
