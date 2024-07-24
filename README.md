
#app
- ##features
    - auth
    - service_providers (contain list of service providers and details screen for each one)

#src
- ##components
    - app_button.dart 
    - custom_text_field 
    - loading_widget

- ##extensions 
    - ###iterable_extension.dart (for iterable widget like Column, Row in most case)
        - expanded(List<int> element) 
            - take a list of flex number to add it to the children of iterable widget

        - addSpaces({double? height,double? width})
            - for add sizes between the children of iterable widget, we assign a width in horizontal direction widget (for example Row)
            - and height in vertical direction widget (for example Column)

    - ###widget_extension.dart 
        - center() (to center the widget)
        - pOnly({double t = 0.0, double e = 0.0, double b = 0.0, double s = 0.0}) (to add padding to specific side) 
        - pSymmetric({double h = 0.0, double v = 0.0}) (to add padding to a direction case)
        - pAll(double value) (to add padding to all sides) 
        - size({double? h, double? w}) (to put the widget in a specific size)
        - inCircle({required double radius,required Color bgColor}) (to put the widget in a circle) 
        - align(AlignmentDirectional alignment) (to align the widget directionally) 
        - bgColor({Color color = AppColors.white}) (to add background color to the widget) () 
        - inkWell(VoidCallback action)=>InkWell(onTap: action,child: this,) (to make widget clickable with process its functionality) 

    - ##routing (a folder contains the files that handel the app routing and navigation)
    - ##di (folder where we inject our services and initialize our app)
  
    - ##theme (a folder that contains the theme files and app colors)
  
    - ##validation (add this directory and its dart files)
        - base_validator.dart (this is the abstract validate class which has)
            - msgKey (all the classes use give a value for this attribute depends on its massage key)
            - valid(String? input) (that is the function which check if the data valid with this validator)
            - validator(String? input) (that is the output of msgKey and valid function together)
        - email_validator (for email)
        - password_validator (for password)
        - phone_validator (for phone number)
        - required_validator (for required fields)
        - username_validator (for the field in login that takes phone or email)