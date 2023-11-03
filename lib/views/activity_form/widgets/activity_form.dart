import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_dyma_training_exercice/models/activity.model.dart';
import 'package:training_dyma_training_exercice/provider/city_provider.dart';

import 'activity_form_autocomplete.dart';
import 'activity_form_image_picker.dart';

class ActivityForm extends StatefulWidget {
  final String? cityName;

  ActivityForm({super.key, this.cityName});

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FocusNode? _priceFocusNode;
  FocusNode? _urlFocusNode;
  FocusNode? _addressFocusNode;
  bool? _isLoading;
  Activity? _newActivity;
  late String? _nameInputAsync;
  final TextEditingController _urlController = TextEditingController();
  @override
  void initState() {
    _newActivity = Activity(
        city: widget.cityName,
        image: null,
        name: null,
        price: 0,
        location:
            LocationActivity(address: null, longititude: null, latitude: null),
        status: ActivityStatus.ongoing);
    _urlFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _addressFocusNode!.addListener(() async {
      if (_addressFocusNode!.hasFocus) {
        var location = await showInputAutoComplete(context);
      } else {
        print('no focus');
      }
    });
    super.initState();
  }

  Future<void> submitForm() async {
    // formkey.currentState.s
    try {
      CityProvider cityProvider = Provider.of<CityProvider>(
        context,
        listen: false,
      );
      form.save();
      setState(() => _isLoading = true);
      _nameInputAsync = await cityProvider.verifyIfActivityNameIsUnique(
          widget.cityName, _newActivity!.name);
      if (form.validate()) {
        await cityProvider.addActivityTocity(_newActivity!);
        if (mounted) Navigator.pop(context);
      } else {
        setState(() => _isLoading = false);
      }
    } catch (e) {
      print('error $e');
    }
  }

  FormState get form {
    return _formkey.currentState!;
  }

  void updateUrlField(String url) {
    setState(() {
      _urlController.text = url;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _urlFocusNode!.dispose();
    _priceFocusNode!.dispose();
    _urlFocusNode!.dispose();
    _urlController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Nom'),
                onSaved: (value) => _newActivity!.name = value,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Remplisser le nom';
                  } else if (_nameInputAsync != null) {
                    return _nameInputAsync;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                decoration: const InputDecoration(hintText: 'Prix'),
                onSaved: (value) => _newActivity!.price = double.parse(value!),
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_urlFocusNode),
                validator: (value) {
                  if (value!.isEmpty) return 'Remplisser le prix';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              TextFormField(
                focusNode: _addressFocusNode,
                decoration: InputDecoration(hintText: 'Adresse'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                controller: _urlController,
                focusNode: _urlFocusNode,
                decoration: const InputDecoration(hintText: 'Url image'),
                onSaved: (value) => _newActivity!.image = value,
                onFieldSubmitted: (_) => submitForm,
                validator: (value) {
                  if (value!.isEmpty) return 'Remplisser l\'Url';
                },
              ),
              const SizedBox(height: 30),
              ActivityFormImagePicker(
                updateUrl: updateUrlField,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('annuler'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                      onPressed: submitForm, child: const Text('sauvegarder'))
                ],
              )
            ],
          )),
    );
  }
}
