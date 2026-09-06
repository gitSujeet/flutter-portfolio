# 🚀 Flutter Portfolio — Sujeet Kumar

A modern, high-performance **Flutter Web Portfolio** showcasing my work as a Flutter & Mobile Engineer, built with animations, clean UI, and scalable architecture.

🌐 **Live Demo:** https://flutter-portfolio-7e0c1.web.app

---

## 👨‍💻 About Me

Flutter Developer with **4+ years of experience** at **Tata Consultancy Services (TCS)**, building production-grade mobile applications for Android and iOS.

- 📱 Cross-platform apps (Flutter, Android, iOS)
- 🤖 AI/ML integration (TFLite, MobileBERT, Azure AI)
- 🔌 IoT & Hardware (BLE, NFC, USB, MQTT)
- ☁️ Cloud & APIs (Firebase, Azure, FHIR)
- 📊 Analytics (Firebase GA4, Crashlytics, Quantum Metric SDK)

---

## ✨ Features

- ⚡ Smooth animations using `flutter_animate`
- 🎯 Interactive UI with hover & magnetic spotlight effects
- 📱 Fully responsive (Mobile, Tablet, Desktop)
- 🌌 Custom particle background engine
- 🔄 Scroll-based active section tracking
- ⌨️ Typewriter animation for role titles
- 📊 Dynamic project & experience showcase

---

## 🧱 Tech Stack

- **Frontend:** Flutter Web
- **State Management:** ChangeNotifier
- **Animations:** flutter_animate
- **Utilities:** url_launcher, visibility_detector
- **Hosting:** Firebase Hosting
- **Architecture:** Feature-based modular structure

---

## 📂 Project Structure

```
lib/
├── main.dart                        # App entry + AppTheme constants
├── data/
│   ├── models.dart                  # ProjectModel, ExperienceModel
│   └── portfolio_data.dart          # All portfolio content
├── state/
│   └── scroll_state.dart            # PortfolioScrollState (ChangeNotifier)
├── pages/
│   └── portfolio_page.dart          # Root page — scroll + cursor logic
└── widgets/
    ├── nav_bar.dart
    ├── hero_section.dart
    ├── stats_row.dart
    ├── project_grid.dart
    ├── experience_section.dart
    ├── skills_section.dart
    ├── contact_section.dart
    ├── content_layer.dart
    └── shared/
        ├── buttons.dart
        ├── particle_background.dart
        └── spotlight_overlay.dart
```

---

## 🚀 Key Projects Showcased

- 📡 Telecom Self-Service App (1M+ users)
- 🏥 AI Healthcare Monitoring System
- ❤️ Portable ECG Monitoring System
- 📶 BLE & NFC SDK (Reusable Library)
- 🧠 On-Device Sentiment AI (MobileBERT)
- 🎨 Flutter UI Elements Package
- 🔐 MQTT Secure Communication App

---

## 💼 Experience

**Flutter Developer**
Tata Consultancy Services · Bangalore, India (May 2022 – Present)

- Migrated native Android & iOS apps to Flutter
- Integrated Firebase GA4, Crashlytics & Quantum Metric SDK
- Built AI healthcare monitoring with TFLite & Azure AI
- Developed reusable BLE/NFC SDKs
- Optimized app performance (~40% faster launch)

🏆 **Awards:**
- TCS Award — Outstanding Technical Contribution
- TCS Award — Innovation & Problem Solving

---

## 🛠 How to Run Locally

```bash
flutter pub get
flutter run -d chrome
```

## 🚢 Deploy to Firebase

```bash
flutter build web --release
firebase deploy --only hosting
```

> See [DEPLOYMENT.md](./DEPLOYMENT.md) for the full deployment guide.

---

## 📬 Contact

- 📧 Email: [sujeetkumarnmd@gmail.com](mailto:sujeetkumarnmd@gmail.com)
- 📞 Phone: +91-7209106002
- 💻 GitHub: https://github.com/gitSujeet
- 🔗 LinkedIn: https://www.linkedin.com/in/sujeet-kumar-ind/

---

## ⭐ Future Improvements

- Dark / light theme toggle
- Blog / technical articles section
- Resume PDF download button
- Backend integration for dynamic content

---

## 📄 License

This project is open-source and available under the MIT License.

---

If you like this project, consider giving it a ⭐ on GitHub!
