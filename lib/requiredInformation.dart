import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

class RequiredInformationPage extends StatefulWidget {
  const RequiredInformationPage({Key? key}) : super(key: key);

  @override
  State<RequiredInformationPage> createState() =>
      _RequiredInformationPageState();
}

class _RequiredInformationPageState extends State<RequiredInformationPage> {
  final _Fmkey = GlobalKey<FormState>();
  List<Widget> phoneFields = [];
  List<Widget> addressFields = [];
  bool _isFieldInvalid = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController workspaceController = TextEditingController();
  final TextEditingController secondarynumberController = TextEditingController();
  final TextEditingController secondaryAddressController = TextEditingController();
  bool isVisible = true;
  bool isoptvisible = false;
  Map<String, dynamic> BusinessInfo = {};

  @override
  void initState() {
    super.initState();
    phoneFields.add(
        _buildRequiredInfoRow("Phone", "Enter your contact number",secondarynumberController));
    addressFields.add(_buildRequiredInfoRow("Address", "Enter your address",secondaryAddressController));
    fetchBusinessProfile();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _Fmkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: width / 9.99,
                    padding: EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFF3D7CF9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.headset_mic_outlined,
                              color: Color(0xFF3D7CF9)),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Support',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(color: Colors.black, thickness: 0.5),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Setup your Business Profile',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF3D7CF9),
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Required Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border:
                              Border.all(  color: isoptvisible?Colors.green:Color(0xFFD38119), width: 1),
                              color:isoptvisible? Color(0xFFD5FFE6):Color(0xFFFBE2AA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:  Text(
                            isoptvisible?'Completed':  'In Progress',
                              style: TextStyle(
                                color: isoptvisible?Colors.green:Color(0xFFD38119),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                              ),
                              child: Icon(
                                isVisible
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Provide Required Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black26,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              if (isVisible) ...[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: width / 1,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        _buildRequiredInfoRow("Business Name",
                            "This name will be visible to your users",nameController),

                        // Phone Fields
                        ...phoneFields,
                        // Render dynamically added phone fields
                        TextButton(
                          onPressed: () {
                            setState(() {
                              phoneFields.add(
                                  _buildRequiredInfoRow(
                                      "Phone", "Enter your contact number",phoneController));
                            });
                          },
                          child: Text(
                            'Add Another Phone Number', textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF3D7CF9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),),
                        ),

                        // Address Fields
                        ...addressFields,
                        // Render dynamically added address fields
                        TextButton(
                          onPressed: () {
                            setState(() {
                              addressFields.add(
                                  _buildRequiredInfoRow(
                                      "Address", "Enter your address",addressController));
                            });
                          },
                          child: Text(
                            'Add Another Address', textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF3D7CF9),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),),
                        ),
                        // Workspace Name Row
                        _buildRequiredInfoRow(
                            "Create Workspace Name",
                            "Enter your unique workspace name",workspaceController),
                      ],
                    ),
                  ),
                ),],

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Optical Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border:
                              Border.all(  color:isoptvisible? Color(0xFFD38119):Colors.black,

                                  width: 1),
                              color:isoptvisible?Color(0xFFFBE2AA):Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:  Text(
                              isoptvisible?
                              'In Progress':'Incomplete',
                              style: TextStyle(
                                color:isoptvisible? Color(0xFFD38119):Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                GestureDetector(
                onTap: () {
                setState(() {
                isoptvisible = !isoptvisible;
                });
                },
                child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
                ),
                child: Icon(
            isoptvisible    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.white,
                ),
                ),
                ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Provide Optical Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black26,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if(isoptvisible)...[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: width / 1,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                color: Colors.grey[100],
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Icon(Icons.add_photo_alternate_outlined,color: Colors.black,),
                                  Text("512 × 512 png",style: TextStyle(color: Colors.grey,fontSize: 12),)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Drop or upload your clinic logo",style:TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w400)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),

                        _buildOpticalInfoRow("Business Description",
                            "Provide a short overview of your health care family"),
                        _buildOpticalInfoRow("Website",
                            "eg:https://website.com"),
                        _buildOpticalInfoRow("Primary Email",
                            "eg:example@abc.com"),
                        _buildOpticalInfoRow("GPS Coordinates",
                            "Enter the coordinates"),
                        _buildOpticalInfoRow("Legal Name",
                            "Business legal name"),
                        _buildOpticalInfoRow("GST Number",
                            "eg:24UDG5365DCU"),
                      ],
                    ),
                  ),
                )],
                Padding(
                  padding: const EdgeInsets.only(right: 20.0,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                     Container(
                       height: height/14,
                       width: width/12,
                       alignment: Alignment.center,
                       decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1),color: Colors.white,
                       borderRadius: BorderRadius.circular(20)),
                       child: Text("Cancel",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                     ),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: (){
                          if (_Fmkey.currentState?.validate() ?? false) {
                            setState(() {
                              _isFieldInvalid = false;
                            });
                          } else {
                            setState(() {
                              _isFieldInvalid = nameController.text.isEmpty;
                            });
                          }
                        },
                        child: Container(
                          height: height/14,
                          width: width/12,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1),color: Colors.black,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("Create Profile",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequiredInfoRow(String label, String hint,TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label Text
          SizedBox(
            width: 300,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 100,
            child: Text(
              ":",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 800, // Use 90% of the screen width
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                    fillColor: _isFieldInvalid ? Colors.red[50] : Colors.grey[100],

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.grey.shade50, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.grey.shade50, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.grey.shade50, width: 1),
                  ),
                  labelText: hint,
                  labelStyle: TextStyle(
                    color: Colors.black45,
                    fontSize: 13,
                  ),
                  suffixIcon: label == "Phone"
                      ? Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 5),
                      width: 100,

                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enquiry No",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: Colors.black),
                        ],
                      ),
                    ),
                  )
                      : null,
                  prefixIcon: label == "Create Workspace Name"
                      ? Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 8, right: 5),
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "https://healthcare.io/",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  )
                      : null,
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black12,
                  fontWeight: FontWeight.w400,
                ),
                validator: (value) {
                  if (controller == nameController && (value == null || value.isEmpty)) {
                      return 'This field cannot be empty';
                        }
                          return null;
                          },
            ),
          ),)

        ],
      ),
    );
  }

  Widget _buildOpticalInfoRow(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label Text
          SizedBox(
            width: 300,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 100,
            child: Text(
              ":",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 800, // Use 90% of the screen width
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.grey.shade50, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.grey.shade50, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: Colors.grey.shade50, width: 1),
                  ),
                  labelText: hint,
                  labelStyle: TextStyle(
                    color: Colors.black45,
                    fontSize: 13,
                  ),
                  suffixIcon: label == "GPS Coordinates"
                      ? Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 5),
                      width: 100,
                      // Adjust the width of the container
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        // Ensure the row doesn't take more space than needed
                        children: [
                          Icon(Icons.location_searching_sharp,
                              color: Colors.black),
                          SizedBox(width: 20,),
                          Text(
                            "Find",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
                      : null,
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black12,
                  fontWeight: FontWeight.w400,
                ),

              ),
            ),
          )

        ],
      ),
    );
  }


  Future<void> fetchBusinessProfile() async {
    print("ygygyggyt");

    final response = await http.get(Uri.parse( "https://cors-anywhere-master-wyynhb4exq-uc.a.run.app/"+"https://mrishab.pythonanywhere.com/api/?format=json"));
    print('jdjsad  '+response.statusCode.toString());

    print("new test" + response.body);

    if (response.statusCode == 200) {
      print("bbhbhb"+response.body+"hnjjnjn"+response.statusCode.toString());

      setState(() {
        BusinessInfo = json.decode(response.body);

        phoneFields.add(_buildRequiredInfoRow(
            "Phone", BusinessInfo['phone'] ?? "Enter your contact number",phoneController));
        addressFields.add(_buildRequiredInfoRow(
            "Address", BusinessInfo['address'] ?? "Enter your address",addressController));
      });
    } else {

      print("Failed to load business profile");
    }
  }
}
