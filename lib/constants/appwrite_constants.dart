class AppwriteConstants {
  static const String databaseId = '63f0f476d6fac842369c';
  static const String projectId = '63f0efe638bfc236c869';
  // для правильной работы на андроид нужно сделать следующее в CMD:
  // 1. cd C:\Users\<YOUR PC USER NAME>\AppData\Local\Android\Sdk\platform-tools
  // 2. adb root
  // 3. adb reverse tcp:80 tcp:80
  // либо использовать ip: 192.168.0.104
  static const String endPoint = 'http://localhost:80/v1';

  static const String usersCollection = '63f783d88a64d12410ce';
}