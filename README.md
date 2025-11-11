# 🌍 Where Am I (UI Mock App)

A modern **Flutter-based accessibility navigation app**, designed as a **mock UI prototype** for indoor navigation assistance.  
This project visualizes the interaction flow for visually impaired users — including speech rate adjustment, UI color modes, and voice feedback simulation.

---

## ✨ Features
- 🏠 **Home Screen** — Quick access to "Where Am I", Navigation, Favorites, and Emergency functions  
- 🔍 **Search Screen** — Type or simulate voice input to find ECSW building classrooms (e.g., *ECSW 1.355, 1.365, 1.385*)  
- 🧭 **Navigation Screen** — Mock step-by-step directions with sonar ping simulation  
- ⚙️ **Settings Screen** — Customize **Speech Rate**, **Voice Type**, **Voice Intensity**, and **UI color themes** (colorblind-friendly)  
- ❤️ **Favorites Screen** — Save frequently visited classrooms  
- 🚨 **Emergency Screen** — Accessible button layout for quick response

---

## 🖼️ UI Preview
*(Designed in Figma, implemented in Flutter)*  

| Home Screen | Search | Settings | Navigation |
|--------------|---------|-----------|-------------|
| ![Home](https://github.com/SE4351group/where_am_i_ui/blob/main/Home%20Screen.png) | ![Search](https://github.com/SE4351group/where_am_i_ui/blob/main/Search%20Screen.png) | ![Settings](https://github.com/SE4351group/where_am_i_ui/blob/main/Settings%20Screen.png) | ![Nav](https://github.com/SE4351group/where_am_i_ui/blob/main/Navigation%20Screen.png) |

> 💡 *UI shown above is mockup only — no real navigation or GPS logic is implemented.*

---

## ⚙️ Installation
### Prerequisites
- Flutter SDK (>=3.6.0)
- Dart SDK
- Android Studio / VS Code with Flutter extension

### Clone & Run
```bash
git clone https://github.com/SE4351group/where_am_i_ui.git
cd where_am_i_ui
flutter pub get
flutter run
