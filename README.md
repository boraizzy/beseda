## 🎓 Education App

Образователно мобилно приложение, създадено с **Flutter**, което използва **Firebase** за автентикация, съхранение и бази данни.  
Приложението е предназначено за интерактивно обучение и предлага курсове, тестове и мултимедийно съдържание.

---

## 🚀 Технологии

- **Flutter 3.35.4 (stable)**
- **Dart 3.9.2**
- **Android Studio Narwhal | 2025.1.1**
- **Firebase Core / Auth / Firestore / Storage**

---

## 🧩 Изисквания

Преди да стартирате проекта, уверете се, че имате инсталирани следните инструменти:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio)
- Android SDK и емулатор или физическо устройство
- Активиран **Developer Mode** и **USB Debugging** (ако използвате телефон)
- Работеща **интернет връзка**

---

## ⚙️ Инсталация и стартиране

1. **Клонирайте хранилището:**
   ```bash
   git clone https://github.com/your-username/education_app.git
   cd education_app
Инсталирайте зависимостите:

flutter pub get
Добавете Firebase конфигурацията:

Изтеглете своя файл google-services.json от Firebase Console

Поставете го в:

android/app/google-services.json
Стартирайте приложението на Android:

flutter run
👉 Ако имате повече от едно устройство, можете да изберете конкретно:

flutter devices
flutter run -d emulator-5554
📁 Структура на проекта

lib/
 ├── app/                # Основна логика и навигация
 ├── features/           # Модули: курсове, тестове, профил и др.
 ├── common_widgets/     # Общи UI компоненти
 ├── core/               # Константи, ресурси и помощни класове
 ├── main.dart           # Начална точка на приложението

---

## 🧭 Как да се ориентирате в приложението
Начален екран: достъп до основните категории и препоръчани курсове

Курсове: видеоуроци, тестове и интерактивни задачи

Тестове: различни видове въпроси и оценки

Профил: прогрес, постигнати нива и настройки на акаунта

💡 Ако имате въпроси или проблеми, можете да се свържете с вградената AI помощ в приложението.

---

## 🧰 Полезни команди
Команда	Описание
flutter pub get	Инсталира всички зависимости
flutter clean	Изчиства кеша и билд файловете
flutter pub upgrade	Обновява пакетите
flutter run	Стартира приложението
flutter build apk	Създава готов APK за Android
---
## 🔥 Firebase настройки (обобщено)
Създайте нов проект във Firebase Console.

Добавете Android приложение с applicationId, който съвпада с android/app/build.gradle.

Изтеглете google-services.json и го поставете в android/app/.

Проверете дали имате в android/build.gradle:

classpath 'com.google.gms:google-services:4.4.2'
и в android/app/build.gradle:

apply plugin: 'com.google.gms.google-services'
---
## 🧑‍💻 Автор
Име: Борис Зарков
Проект: Education App
Технологии: Flutter + Firebase
Година: 2025
