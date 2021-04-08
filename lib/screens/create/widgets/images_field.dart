import 'package:flutter/material.dart';
import 'package:xlo/screens/create/widgets/image_source_sheet.dart';

class ImagesField extends StatelessWidget {

  final FormFieldSetter<List> onSaved;
  final List initialValue;

  ImagesField({this.onSaved, this.initialValue});

  @override
  Widget build(BuildContext context) {
    return FormField<List>(
      initialValue: initialValue,
      onSaved: onSaved,
      validator: (images) {
        if (images.isEmpty)
          return 'Campo obrigatório';
        else
          return null;
      },
      builder: (state){
        return Column(
          children: <Widget>[
            Container(
              color: Colors.grey[200],
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.value.length + 1,
                itemBuilder: (context, index){
                  if(index == state.value.length)
                    return GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ImageSourceSheet((image) {
                            if (image != null)
                              state.didChange(state.value..add(image));
                            Navigator.of(context).pop();
                          }),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 52,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 50,
                              ),
                              Text(
                                '+ inserir',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: CircleAvatar(
                        backgroundImage: FileImage(
                          state.value[index],
                        ),
                        radius: 52,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.file(state.value[index]),
                              TextButton(
                                child: const Text('Excluir'),
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(Colors.red),
                                ),
                                onPressed: () {
                                  state.didChange(state.value..removeAt(index));
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (state.hasError)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
