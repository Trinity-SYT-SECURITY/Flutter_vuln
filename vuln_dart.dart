import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// M1: Improper Platform Usage
// 在 Android 平台上啟動相機並沒有對 iOS 平台進行處理
// 如果執行此程式碼的設備不支持 Android 平台，程式將崩潰
void openCamera() {
  if (Platform.isAndroid) {
    ImagePicker.pickImage(source: ImageSource.camera);
  }
}

// M2: Insecure Data Storage
// 將密碼以明文形式存儲在本地設備上，容易被竊取
void savePassword(String password) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('password', password);
}

// M3: Insecure Communication
// 使用 HTTP 協議進行網路請求，可能被攔截或篡改
Future<List<User>> getUsers() async {
  final response = await http.get('http://example.com/users');
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    return (jsonData['data'] as List)
        .map((user) => User.fromJson(user))
        .toList();
  } else {
    throw Exception('Failed to load users');
  }
}

// M4: Insecure Authentication
// 實現自己的身份驗證機制，但存儲密碼時沒有使用適當的加密算法
// 密碼以明文形式存儲在本地設備上，容易被竊取
class AuthService {
  Future<String> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedPassword = prefs.getString('password');
    if (password == savedPassword) {
      return 'token';
    } else {
      throw Exception('Invalid username or password');
    }
  }
}

// M5: Insufficient Cryptography
// 使用容易被攻擊者破解的加密算法加密敏感數據
String encrypt(String plaintext) {
  final key = 'my_secret_key';
  final iv = 'my_secret_iv';
  final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc),
      iv: IV.fromUtf8(iv));
  return encrypter.encrypt(plaintext).base64;
}

// M6: Insecure Authorization
// 在使用者登錄後，未進行角色權限檢查，導致未經授權的用戶可以訪問敏感功能或資源
void viewAdminDashboard() {
  if (currentUser.role == 'admin') {
    Navigator.pushNamed(context, '/admin_dashboard');
  } else {
    throw Exception('Unauthorized access');
  }
}

// M7: Poor Code Quality
// 使用 eval() 函數執行來自網路的字串，可能被惡意用戶利用
// 不良寫法 1：使用不必要的變數
void calculateSum(List<int> numbers) {
  int sum = 0;
  for (int i = 0; i < numbers.length; i++) {
    sum += numbers[i];
  }
  print(sum); // 印出 sum
}

// 不良寫法 2：使用硬編碼的數據
void processUserData(String username) {
  if (username == "admin") {
    // ...
  }
}

// 不良寫法 3：忽略錯誤處理
void readFile(String filePath) {
  var file = File(filePath);
  var contents = file.readAsStringSync();
  print(contents);
}

// 不良寫法 4：過度依賴 eval 或 Function()
void executeDynamicCode(String code) {
  var result = eval(code); // 這裡 eval 會執行任意的 Dart 代碼
  print(result);
}


// M8: Code Tampering - 未對應用程式進行代碼簽名或校驗，使得攻擊者能夠修改應用程式的代碼
// 不正確的寫法：未進行代碼簽名驗證
void verifyAppIntegrity() {
  // 在此示例中，假設將應用程式的代碼簽名存儲在變數中
  String appSignature = "0123456789abcdef";

  // 攻擊者可能會修改應用程式的代碼
  // 這裡只是模擬攻擊者修改代碼的行為
  String modifiedCode = "print('Hello, world!');";

  // 未進行代碼簽名驗證，導致攻擊者修改的代碼被執行
  if (appSignature == modifiedCode) {
    eval(modifiedCode);
  } else {
    print("Invalid app integrity");
  }
}

// M9: Reverse Engineering - 未對原始碼進行適當的保護措施，使得攻擊者能夠輕鬆地進行逆向工程

// 不正確的寫法：未實施代碼混淆
class SecretKey {
  // 密鑰在原始碼中以明文形式存儲
  static final String key = "supersecretkey";
}

void useSecretKey() {
  // 攻擊者可以輕易地查看原始碼並獲取密鑰
  print("Secret Key: ${SecretKey.key}");
}

// M10: Extraneous Functionality - 在生產環境中啟用除錯模式，使得攻擊者可以獲取更多敏感信息或利用漏洞

// 不正確的寫法：在生產環境中保留除錯日誌
void enableDebugMode() {
  // 在此示例中，假設 DEBUG_MODE 是一個全局變數，用於控制除錯功能
  const DEBUG_MODE = true;

  // 不應該在生產環境中啟用除錯模式
  if (DEBUG_MODE) {
    print("Debug information: ...");
  }
}
