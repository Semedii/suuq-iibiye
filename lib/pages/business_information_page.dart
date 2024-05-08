

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:suuq_iibiye/components/app_textfield.dart';
@RoutePage()
class BusinessInformationPage extends StatelessWidget {
  const BusinessInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Business Information"),),

      body: Column(
        children: [
          AppTextField(hintText: "hintText", label: "Business Name", isDisabled: true,),
           AppTextField(hintText: "hintText", label: "Business Address"),
           AppTextField(hintText: "hintText", label: "Phone number"),
          AppTextField(hintText: "hintText", label: "Email", isDisabled: true),
          AppTextField(hintText: "hintText", label: "Joined Date", isDisabled: true),
          
         
        ],
      ),
    );
  }
}