# flutter_application_1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

preview for info
step 1: add args in Navigator.pushNamed
                arguments: {
                    'form_id': formId,
                    'edit': true,
                    'appForm': ApplicationFormModel.mapToObject(form!),
                  });
step 2: in info page >> declare var 
    bool edit = false;
    ApplicationFormModel? appForm;
and write bellow in build()
    if (data['edit'] != null && appForm == null ) {
      setState(() {
        edit = data['edit'];
        appForm = data['appForm'];
        nameController.text = nullCheck(appForm!.fullname);
        nrcController.text = nullCheck(appForm!.nrc);
        phoneController.text = nullCheck(appForm!.appliedPhone);
        if (_selectedjob == null) {
          _selectedjob = nullCheck(appForm!.jobType.toString());
        }
        positionController.text = nullCheck(appForm!.position);
        departmentController.text = nullCheck(appForm!.department);
        otherController.text = nullCheck(appForm!.businessName);
        salaryController.text = nullCheck(appForm!.salary.toString());
        buildingTypeController.text = nullCheck(appForm!.appliedBuildingType);
        homeNoController.text = nullCheck(appForm!.appliedHomeNo);
        apartmentController.text = nullCheck(appForm!.appliedBuilding);
        streetController.text = nullCheck(appForm!.appliedStreet);
        laneController.text = nullCheck(appForm!.appliedLane);
        quarterController.text = nullCheck(appForm!.appliedQuarter);
        townController.text = nullCheck(appForm!.appliedTown);

        if (townshipId == null) {
          townshipId = nullCheckNum(appForm!.townshipId);
        }
        if (districtId == null) {
          districtId = nullCheckNum(appForm!.districtId);
        }
        if (divisionId == null) {
          divisionId = nullCheckNum(appForm!.divStateId);
        }
      });
    }

    String nullCheck(String? value) {
    if (value == null || value == '' || value == 'null') {
      return '';
    }
    return value;
  }

  int nullCheckNum(value) {
    if (value == null || value == '' || value == 'null') {
      return 0;
    }
    return int.parse(value);
  }

  bool nullCheckBool(value) {
    if (value == null || value == '' || value == 'null') {
      return false;
    }
    return int.parse(value) > 0 ? true : false;
  }
step 3 : jobField() => set value => value: _selectedjob,

step 4 . in info page >> getTownshipList()
for (var i = 0; i < townshipList.length; i++) {
          if (townshipList[i]['id'] == townshipId) {
            setState(() {
              _selectedTownship = townshipList[i];
              townshipId = _selectedTownship['id'];
              districtId = _selectedTownship['district_id'];
              divisionId = _selectedTownship['division_state_id'];
              districtController.text = _selectedTownship['district_name'];
              divisionController.text =
                  _selectedTownship['division_states_name'];
            });
          }
        }

step 5 : goToNextPage()
if (edit) {
      goToBack();
    } else { ...
    }
--------------------------------------------------------------------------

preview for image
step 1 : bool edit = false;

step 2 : inside >> build >> 
if (data['edit'] != null) {
      setState(() {
        edit = data['edit'];
      });
    }
step 3 : goToNextPage()
if (edit) {
      goToBack();
    } else { ...
    }

--------------------------------------------------------------------------

overview page >>
step 1 : replace Widget mainTitle() [add func parameter, Flexible and condition]
step 2 : sendFile() => 
        startLoading();
        setState(() {
          formId = data['form']['id'];
        });
        setState(() {
          chkSend = false;
          msg = 'သင့်လျှောက်လွှာအား ရုံးသို့ပေးပို့ပြီးဖြစ်ပါသည်။';
          formId = data['form']['id'];
        });
        showSnackBar(context, msg);

step 3 : add new fun 
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(fontFamily: "Pyidaungsu"),
      ),
      action: SnackBarAction(
        label: "ပိတ်မည်",
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }
