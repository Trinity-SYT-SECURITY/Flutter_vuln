import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

#M1~M5
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String userInput = getUserInput(); // 假設使用者輸入為 "'; DROP TABLE users; --"

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "Welcome, $userInput!", // M1: Improper Platform Usage - 未對使用者輸入進行適當的驗證和過濾
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  String getUserInput() {
    // M2: Insecure Data Storage - 不安全的數據存儲，將敏感數據明文存儲在本地變數
    String userInput = "'; DROP TABLE users; --";
    return userInput;
  }

  void sendDataOverHttp() {
    String password = "secretpassword";

    // M3: Insecure Communication - 不安全的通信，未使用安全的協議（例如 HTTPS）進行網絡通信
    var url = 'http://example.com/login?password=$password';
    // ...
  }

  void authenticateUser(String username, String password) {
    // M4: Insecure Authentication - 不正確的身份驗證，未正確實施身份驗證機制
    if (username == "admin" && password == "password123") {
      grantAccess();
    } else {
      denyAccess();
    }
  }

  void encryptData(String data) {
    // M5: Insufficient Cryptography - 不足的加密措施，使用不安全的加密算法或弱密鑰
    var encryptedData = weakEncrypt(data);
    // ...
  }

  String weakEncrypt(String data) {
    // 使用不安全的加密算法（僅用於示範）
    return data.replaceAll('a', '1').replaceAll('b', '2');
  }

  void grantAccess() {
    print("Access granted!");
  }

  void denyAccess() {
    print("Access denied!");
  }
}


//M6~M10
import 'dart:convert';

// M6: Insecure Authorization
// 不正確的身份驗證機制，例如簡單的用戶名和密碼驗證
void insecureAuthentication(String username, String password) {
  // 實際場景中，這裡應該是從數據庫或其他安全的存儲中獲取用戶名和密碼
  if (username == "admin" && password == "password") {
    print("Authentication succeeded!");
  } else {
    print("Authentication failed!");
  }
}

// M7: Poor Code Quality
// 密碼直接硬編碼在程式碼中
String getHardcodedPassword() {
  String password = "password123";
  return password;
}

// M8: Code Tampering
// 未對應用程式進行程式簽名或校驗，使得攻擊者能夠修改應用程式的程式
void tamperCode() {
  // 實際場景中，應該對應用程式進行程式簽名或校驗，以檢測代碼是否被修改
  // 以下是示例中的程式簽名部分，供參考
  String originalCodeHash = "ab12cd34ef56"; // 實際場景中，應從可靠的來源獲取原始程式碼的哈希值
  String currentCodeHash = calculateCodeHash(); // 實際場景中，應計算目前程式碼的哈希值

  if (originalCodeHash == currentCodeHash) {
    print("Code integrity verified. The code has not been tampered with.");
  } else {
    print("Warning: Code integrity compromised. The code may have been tampered with!");
  }
 }

// M9: Reverse Engineering
// 程式未經過混淆，容易被反編譯
// 在實際場景中，應該使用專業的工具對程式進行混淆
String getPasswordFromObfuscatedCode() {
  String obfuscatedCode =
      "YXNkZmFzZGZhc2RmYXNkZg=="; // 實際場景中，這裡應該是混淆過的程式
  String decodedPassword = utf8.decode(base64.decode(obfuscatedCode));
  return decodedPassword;
}

// M10: Extraneous Functionality
// 在生產環境中啟用除錯模式，使得攻擊者可以獲取更多敏感資訊或利用漏洞
void enableDebugMode() {
  // 實際場景中，應禁用生產環境中的除錯模式，以減少攻擊面和敏感資訊的洩露
  // 以下是示例中的除錯模式啟用部分，供參考
  bool isDebugModeEnabled = true; // 實際場景中，應從配置或設置中獲取是否啟用除錯模式的值

  if (isDebugModeEnabled) {
    print("Warning: Debug mode is enabled. Sensitive information may be exposed!");
  // 進行除錯相關的操作，例如日誌記錄、顯示敏感資訊等
  } else {
  // 在生產環境中，應該禁用除錯相關的操作
    print("Debug mode is disabled. No sensitive information will be exposed.");
  }
 }
