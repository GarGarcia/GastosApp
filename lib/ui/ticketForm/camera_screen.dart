import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

enum CameraState { none, loading, loaded, error }

class _CameraScreenState extends State<CameraScreen> {
  CameraState _cameraState = CameraState.none;
  late List<CameraDescription> _cameras;
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();

    initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    switch (_cameraState) {
      case CameraState.none:
        return _buildScaffold(
          context,
          Center(child: CircularProgressIndicator()),
        );
      case CameraState.loading:
        return _buildScaffold(
          context,
          Center(child: CircularProgressIndicator()),
        );
      case CameraState.loaded:
        return _buildScaffold(context, CameraPreview(_cameraController));
      case CameraState.error:
        return _buildScaffold(
          context,
          Center(child: Text("La camara no esta disponible 😥")),
        );
    }
  }

  Widget _buildScaffold(BuildContext context, body) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Camara"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final XFile image = await _cameraController.takePicture();
          print("Picture saved at: ${image.path}");
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future initializeCamera() async {
    _cameraState = CameraState.loading;
    if (mounted) setState(() {});

    _cameras = await availableCameras();

    _cameraController = CameraController(_cameras[0], ResolutionPreset.max);

    await _cameraController.initialize();

    if (_cameraController.value.hasError) {
      _cameraState = CameraState.error;
      if (mounted) setState(() {});
    } else {
      _cameraState = CameraState.loaded;
      if (mounted) setState(() {});
    }
  }
}
