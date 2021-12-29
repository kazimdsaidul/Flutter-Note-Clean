import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_clean/feature/domain/entities/color_entity.dart';
import 'package:flutter_note_clean/feature/domain/entities/note_entity.dart';
import 'package:flutter_note_clean/feature/presentation/cubit/color/color_cubit.dart';
import 'package:flutter_note_clean/feature/presentation/cubit/note/note_cubit.dart';
import 'package:flutter_note_clean/feature/widgets/common.dart';
import 'package:intl/intl.dart';

import '../../../theme.dart';

class AddNewNotePage extends StatefulWidget {
  final String uid;

  const AddNewNotePage({Key? key, required this.uid}) : super(key: key);

  @override
  _AddNewNotePageState createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  TextEditingController _noteTextController = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _noteTextController.addListener(() {
      setState(() {});
    });

    BlocProvider.of<ColorCubit>(context).getColors();
    super.initState();
  }

  @override
  void dispose() {
    _noteTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        title: Text("Note"),
      ),
      body: BlocBuilder<ColorCubit, ColorState>(
        builder: (context, state) {
          var pageBackgroundColor;
          if (state is ColorSeleted) {
            pageBackgroundColor = HexColor.fromHex(state.note.colorHaxcode);
          } else {
            pageBackgroundColor = Colors.white;
          }

          return Container(
            color: pageBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${_noteTextController.text.length} Characters",
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(.5)),
                ),
                _build_color_section(state),
                Expanded(
                  child: Scrollbar(
                    child: TextFormField(
                      controller: _noteTextController,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "start typing..."),
                    ),
                  ),
                ),
                InkWell(
                  onTap: _submitNewNote,
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _submitNewNote() {
    if (_noteTextController.text.isEmpty) {
      snackBarError(scaffoldState: _scaffoldStateKey, msg: "type something");
      return;
    }
    BlocProvider.of<NoteCubit>(context).addNote(
      note: NoteEntity(
        note: _noteTextController.text,
        time: Timestamp.now(),
        uid: widget.uid,
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(context);
    });
  }

  _build_color_section(ColorState state) {
    if (state is ColorInitial) {
      return Container(child: Text("ColorInitial"));
    } else if (state is ColorLoading) {
      return Container(child: Text("ColorLoading....."));
    } else if (state is ColorFailure) {
      return Container(child: Text("ColorFailure....."));
    } else if (state is ColorLoaded) {
      return buildList(state.notes);
    } else if (state is ColorSeleted) {
      return buildList(state.notes);
    } else {
      return Container(child: Text("....else state....."));
    }
  }

  buildList(List<ColorEntity> notes) {
    return Container(
      height: 44.0,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: notes.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return Center(
              child: InkWell(
            onTap: () {
              setState(() {
                // _value = !_value;
                BlocProvider.of<ColorCubit>(context).seltedColors(index);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: HexColor.fromHex(notes[index].colorHaxcode)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: notes[index].isSeleted
                    ? Icon(
                        Icons.check,
                        size: 30.0,
                        color: CustomColor.white,
                      )
                    : Container(),
              ),
            ),
          ));
        },
      ),
    );
  }
}
