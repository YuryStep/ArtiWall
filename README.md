# ArtiWall
**Приложение по генерации обоев с помощью AI**

ТЗ в pdf лежит [здесь](https://drive.google.com/file/d/1jcc4g7d0LgQcnwbXy4JgUkYkQXuYsWon/view?usp=drive_link).

<details>
<summary><b>В проекте используются сторонние зависимости с использованием Cococapods. Инструкция по установке.</b></summary>  

<br>Для успешной установки зависимостей выполните следующие шаги:</br>
1. Откройте терминал.
2. Перейдите в корневую директорию проекта.
3. Выполните команду: ```pod install```
4. Запустите **ArtiWall.xcworkspace**

</details>

## Стэк, Ограничения и Архитектура
Стэк: **Swift 5, UIKit** 
Минимальная версия: **iOS 15**   
Архитектура: **MVP**   

<table>
 <tr>
 <td align="center"><img src="https://i.imgur.com/8ytiDlZ.png" width="350"></td>
 <td align="center"><img src="https://i.imgur.com/brxdBFm.png" width="350"></td>
 <td align="center"><img src="https://i.imgur.com/VT2Ixk6.png" width="350"></td>
 <td align="center"><img src="https://i.imgur.com/SQAIk4E.png" width="350"></td>
 </tr>
</table>

## Видео

https://github.com/YuryStep/ArtiWall/assets/112872920/abec3bb5-5e1e-4542-89a3-db56a969500b

## Особенности проекта
* Проект написан на **`UIKit`**
* Согласно ТЗ в проекте использованы обязательные библиотеки с подключением через **`Cocoapods`**
* Использована архитектура **`MVP`**
* Верстка выполнена с использованием **`SnapKit`**
* Используется **`UICollectionView + DiffableDataSource`**.
* Взаимодействие с сетью реализовано с использованием **`Alamofire`** и **`Kingfisher`**
* Работа с многопоточностью, с использованием **`GCD`**
* Кастомная анимация навигации реализована через **кастомные `Transition` для `UINavigationController`**.
* Дополнительно использована анимация библиотеки **`Lottie`**
* Для обработки ошибок используется класс **`Result`**
* Использован **кастомный шрифт**
* Реализовано **сохранение изображений в галерею**.
* При успешном сохранении происходит **вибрация телефона** и появляется сообщение **`EasyTipView`**
* Для сохранения чистоты кода в проекте используются  **`Swiftlint`** и **`SwiftFormat`**

## Другие PET проекты
* Более крупный (по функциональности и инструментам) проект для ознакомления доступен по ссылке: https://github.com/YuryStep/NewsCatcher
