import 'package:fashion/core/error/exception.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordVoice {
  final AudioRecorder _record;
  RecordVoice(this._record);
  recoding(int userID) async {
    try {
      if (await _record.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final path =
            '${directory.path}/${userID}_recording_${DateTime.now().millisecondsSinceEpoch}.wav';

        await _record.start(const RecordConfig(), path: path);
      }
    } catch (e) {
      print(e);
    }
  }

  playRecord() async {}

  // Stop recording...
  Future<String?> stopRecord() async {
    try {
      final path = await _record.stop();
      return path;
    } catch (e) {
      print(e);
      throw NoDataException();
    }
  }

  // ... or cancel it (and implicitly remove file/blob).
  Future<void> cancelRecord() async {
    await _record.cancel();
  }

  Future<void> disposeRecord() async {
    return await _record.dispose();
  }
}
