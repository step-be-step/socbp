class AppwriteConstants {
  static const String databaseId = '63f0f476d6fac842369c';
  static const String projectId = '63f0efe638bfc236c869';
  // для правильной работы на андроид нужно сделать следующее в CMD:
  // 1. cd C:\Users\<YOUR PC USER NAME>\AppData\Local\Android\Sdk\platform-tools
  // 2. adb root
  // 3. adb reverse tcp:80 tcp:80
  // либо использовать ip: 192.168.0.104
  static const String endPoint = 'http://192.168.0.104:80/v1';

  static const String usersCollection = '63f783d88a64d12410ce';
  static const String postCollection = '640dd17e5aab28f5716c';

  static const String imageBucket = '64059354c7bd0c388860';

  static String imageUrl(String imageId) => '$endPoint/storage/buckets/$imageBucket/files/$imageId/view?project=$projectId&mode=admin';
}