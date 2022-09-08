import 'dart:isolate';

abstract class IsolateSource {
  Future<dynamic> executeInIsolate(IsolateOperation useCase) async {
    final ReceivePort serviceReceivePort = ReceivePort();
    final ReceivePort isolateReceivePort = ReceivePort();

    Isolate.spawn<SendPort>(initIsolateTask, serviceReceivePort.sendPort);

    final SendPort isolateSendPort = await serviceReceivePort.first;
    isolateSendPort.send(isolateReceivePort.sendPort);
    isolateSendPort.send(useCase);

    final data = await isolateReceivePort.first;
    return data;
  }

  Future<void> initIsolateTask(SendPort serviceSendPort) async {
    ReceivePort isolateReceivePort = ReceivePort();
    serviceSendPort.send(isolateReceivePort.sendPort);
    late SendPort isolateSendPort;
    await for (var message in isolateReceivePort) {
      if (message is SendPort) {
        isolateSendPort = message;
      }
      if (message is IsolateOperation) {
        isolateSendPort.send(await message.execute());
      }
    }
  }
}

abstract class IsolateOperation<Output> {
  Future<Output> execute();
}
