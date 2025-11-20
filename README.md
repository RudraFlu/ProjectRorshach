# Rorschach Test App 🖤

![Flutter](https://img.shields.io/badge/Flutter-3.0-blue?logo=flutter) ![Dart](https://img.shields.io/badge/Dart-3.0-blue?logo=dart)  

A Flutter app that presents a **Rorschach test**, collects user responses, and provides **AI-generated interpretations** (for entertainment purposes).  

---

## 📸 Demo
![WhatsApp Image 2025-09-13 at 20 51 11_ebbc32fe](https://github.com/user-attachments/assets/5bd49e90-372a-4309-becf-ad148ca21cb0)
![WhatsApp Image 2025-09-13 at 20 51 12_9145bf12](https://github.com/user-attachments/assets/4763333e-6319-419a-bf3b-d81e22304790)
![WhatsApp Image 2025-09-13 at 20 51 12_ab4fa321](https://github.com/user-attachments/assets/964eff0b-e0e2-4867-9a14-0c33a9e5ba42)
![WhatsApp Image 2025-09-13 at 20 54 20_04ab0ea9](https://github.com/user-attachments/assets/40a7e9a0-8c50-4127-99e4-e5ac9306a76a)


---

## ⚡ Features

- Displays 10 Rorschach images sequentially  
- Stores user responses locally in a text file  
- Shows AI-generated symbolic interpretations  
- Custom fonts and styled result text  
- Inline images in the analysis (manually added)  
---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK ≥ 3.0  
- Dart ≥ 3.0  
- Android Studio / VS Code  

### Installation

git clone https://github.com/RudraFlu/ProjectRorshach.git
cd ProjectRorshach-app
flutter pub get

### Run the app
flutter run

### Build APK
flutter build apk --release


# Optionally, split APK per architecture for smaller files:

flutter build apk --split-per-abi

# 📂 Project Structure
lib/
 ├── main.dart
 ├── screens/
 │    ├── image_screen.dart
 │    └── analysis_screen.dart
 ├── widgets/                # reusable UI widgets
assets/
 ├── images/                 # Rorschach images
 ├── fonts/                  # Custom fonts

# ⚠️ Notes

The app is for entertainment purposes only — not a medical or psychological tool.


# 📄 License

MIT License – see 
