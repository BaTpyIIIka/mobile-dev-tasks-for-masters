# dogs_client_application

Приложение использует открытый API api.thedogapi.com. [Подробнее](https://docs.thedogapi.com).
Первый экран приложения отображает список пород собак, получаемый [запросом](https://docs.thedogapi.com/api-reference/breeds/breeds-list).
При нажатии на породу открывается экран с подробным описанием породы и 
фотографией собаки данной породы, взятой из [запроса](https://docs.thedogapi.com/api-reference/images/images-search).

Авторизацация в приложении происходит с помощью Firebase. Для использования
приложения необходимо создать новый проект в консоли Firebase и заменить файлы
google-services.json и GoogleService-Info.plist на сгенерированный для вашего проекта, см. [документацию](https://firebase.google.com/docs/flutter/setup).


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
