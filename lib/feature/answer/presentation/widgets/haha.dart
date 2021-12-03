import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:painter/painter.dart';
import 'dart:typed_data';

import 'package:flutter/material.Dart';
import 'Dart:async';
import 'Dart:typed_data';
import 'Dart:ui' as ui;
import 'package:flutter/material.Dart';
import 'package:flutter/rendering.Dart';
import 'package:flutter/services.Dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';
import 'package:photo_view/photo_view.dart';
import 'package:uri_to_file/uri_to_file.dart';

class ExamplePage extends StatefulWidget {
  final String? urlImage;
  static const String routeName = "/ExamplePage";

  const ExamplePage({Key? key, this.urlImage}) : super(key: key);

  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  bool _finished = false;
  PainterController _controller = _newController();
  static GlobalKey previewContainer = new GlobalKey();
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  static PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.transparent;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_finished) {
      actions = <Widget>[
        new IconButton(
          icon: new Icon(Icons.content_copy),
          tooltip: 'New Painting',
          onPressed: () => setState(() {
            _finished = false;
            _controller = _newController();
          }),
        ),
      ];
    } else {
      actions = <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.undo,
            ),
            tooltip: 'Undo',
            onPressed: () {
              if (_controller.isEmpty) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        new Text('Nothing to undo'));
              } else {
                _controller.undo();
              }
            }),
        new IconButton(
            icon: new Icon(Icons.delete),
            tooltip: 'Clear',
            onPressed: _controller.clear),
        new IconButton(
            icon: new Icon(Icons.check),
            onPressed: () {
              return _show(_controller.finish(), context);
            }),
      ];
    }
    return RepaintBoundary(
      key: previewContainer,
      child: new Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: new AppBar(
              title: const Text('Edit Image'),
              actions: actions,
              bottom: new PreferredSize(
                child: new DrawBar(_controller),
                preferredSize:
                    new Size(MediaQuery.of(context).size.width, 30.0),
              )),
          body: Stack(
            children: [
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(widget.urlImage!)),

              ///content://media/external/images/media/70
              //child: Image.network(widget.urlImage!)),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Center(child: new Painter(_controller)),
              ),
            ],
          )),
    );
  }

  //Image.asset("assets/images/avatar.jpg")

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  void _show(PictureDetails picture, BuildContext context) {
    setState(() {
      _finished = true;
    });
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: new AppBar(
          title: const Text('View your image'),
          actions: [
            IconButton(
              icon: Icon(Icons.download),
              onPressed: () async {
                var image = await screenshotController.capture();

                if (image == null) return;
                await saveImage(image);

                Navigator.pop(context);
                Navigator.pop(context, "Save photo successfully");
              },
            ),
          ],
        ),
        body: new Container(
            alignment: Alignment.center,
            child: new FutureBuilder<Uint8List>(
              future: picture.toPNG(),
              builder:
                  (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return new Text('Error: ${snapshot.error}');
                    } else {
                      return Screenshot(
                        controller: screenshotController,
                        child: Stack(
                          children: [
                            Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Image.network(widget.urlImage!)),
                            Center(
                                child: Image.memory(
                              snapshot.data!,
                            )),
                          ],
                        ),
                      );
                    }
                  default:
                    return new Container(
                        child: new FractionallySizedBox(
                      widthFactor: 0.1,
                      child: new AspectRatio(
                          aspectRatio: 1.0,
                          child: new CircularProgressIndicator()),
                      alignment: Alignment.center,
                    ));
                }
              },
            )),
      );
    }));
  }
}

Future<String> saveImage(Uint8List bytes) async {
  await [Permission.storage].request();
  final time = DateTime.now()
      .toIso8601String()
      .replaceAll(".", "-")
      .replaceAll(":", "-");
  final name = 'screenshot_$time';
  final result = await ImageGallerySaver.saveImage(bytes, name: name);
  // prefs?.setString("path", result['filePath']);
  // print("fasdf ${result['filePath']} ");
  return result['filePath'];
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(child: new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new Container(
              child: new Slider(
            value: _controller.thickness,
            onChanged: (double value) => setState(() {
              _controller.thickness = value;
            }),
            min: 1.0,
            max: 20.0,
            activeColor: Colors.white,
          ));
        })),
        new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new RotatedBox(
              quarterTurns: _controller.eraseMode ? 2 : 0,
              child: IconButton(
                  icon: new Icon(Icons.create),
                  tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
                      ' eraser',
                  onPressed: () {
                    setState(() {
                      _controller.eraseMode = !_controller.eraseMode;
                    });
                  }));
        }),
        new ColorPickerButton(_controller, false),
        new ColorPickerButton(_controller, true),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  ColorPickerButton(this._controller, this._background);

  @override
  _ColorPickerButtonState createState() => new _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return new IconButton(
        icon: new Icon(_iconData, color: _color),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new Scaffold(
                  appBar: new AppBar(
                    title: const Text('Pick color'),
                  ),
                  body: new Container(
                      alignment: Alignment.center,
                      child: new ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: (Color c) => pickerColor = c,
                      )));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      //  widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
