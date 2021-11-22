import 'package:att_man/Utils/Constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class EditProfileScreen extends StatefulWidget {
  //const EditProfileScreen({ Key? key }) : super(key: key);
  //will use a unique key later incase cross-ID changes occurs, otherwise leave it be.
  static const routeName = '/edit-profile';
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //focus nodes (not so necessary though, but implemented for more fluent data handling)

  final _rollFocusNode = FocusNode();
  final _instituteNameFocusNode = FocusNode();
  final _contactFocusNode = FocusNode();

  final _nameController = TextEditingController();
  final _rollController = TextEditingController();
  final _instituteNameController = TextEditingController();
  final _contactController = TextEditingController();

  final _form = GlobalKey<FormState>();
  final userID = FirebaseAuth.instance.currentUser!.uid.toString();
  


  @override
  void dispose() {
    _rollFocusNode.dispose();
    _instituteNameFocusNode.dispose();
    _contactFocusNode.dispose();
    super.dispose();
  }

  void _updateData() {
    _form.currentState!.save();
   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextPage()));
    Navigator.of(context).pop();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kPrimary0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Edit Profile Details',
          style: GoogleFonts.quicksand(
              fontSize: 22, color: kPrimary0, fontWeight: FontWeight.normal),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: kPrimary0,
            ),
            onPressed: _updateData,
          )
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                maxLines: 1,
                controller: _nameController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_rollFocusNode);
                  //print(userID);
                },
                onSaved: (value) {
                  if(_nameController.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userID)
                        .update({'displayName': _nameController.text});
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Roll Number'),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_instituteNameFocusNode);
                },
                focusNode: _rollFocusNode,
                controller: _rollController,
                onSaved: (value) {
                  if(_rollController.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userID)
                        .update({'enrollmentNumber': _rollController.text});
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Institute Name'),
                keyboardType: TextInputType.name,
                maxLines: 3,
                controller: _instituteNameController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_contactFocusNode);
                },
                onSaved: (value) {
                  if(_instituteNameController.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userID)
                        .update(
                            {'instituteName': _instituteNameController.text});
                  }
                },
                focusNode: _instituteNameFocusNode,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.number,
                focusNode: _contactFocusNode,
                controller: _contactController,
                onFieldSubmitted: (_) {
                  _updateData();
                },
                onSaved: (value) {
                  if(_contactController.text.isNotEmpty) {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(userID)
                        .update({'contactNumber': _contactController.text});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
