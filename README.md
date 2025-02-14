## iOS test
Prueba técnica

## Descripción
Este proyecto consume usa la [PokeApi](https://pokeapi.co/) para mostrar
una lista de nombres de Pokémon, al dar clic sobre algunos de los nombres
muestra una vista de detalle donde se puede ver su imagen.


### Tecnologías
El propósito de este proyecto es mostrar de manera (muy) básica
el uso del StoryBoard, CoreData, Firebase Authentication. La app
hace uso del patrón Repository para manejar los datos.

### Mejoras
Aunque existen muchos puntos de mejora, los principales son:
- Implementación de Dependency Injection
- Aplicación de VIPER 

## Configuración del entorno

### Instalación de Xcode
Xcode es un entorno de desarrollo integrado para macOS que contiene un conjunto de herramientas creadas por
Apple destinadas al desarrollo de software para macOS, iOS, watchOS y tvOS. [Wikipedia](https://es.wikipedia.org/wiki/Xcode)

Puedes descargar el instalador y/o obtener más información desde la [página oficial](https://developer.apple.com/xcode/)

### CocoaPods
La app usa Cocoa Pods como administrador de dependencias por lo que será necesaria su instalación.

Puedes instalarlo desde la terminal de Mac OS X ejecutando lo siguiente

```sh
sudo gem install cocoapods
```

más información en la [página oficial](https://guides.cocoapods.org/using/getting-started.html#getting-started)

### Descarga y configuración
Una véz instalado el entorno, instala las dependencias del proyecto ejecutando la siguiente instrucción en la terminal desde la carpeta del proyecto

```sh
pod install
```
El proceso puede tardar varios minutos, dependiendo de tu conexión a internet

para más información: [Using CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

### Firebase
Dado que este proyecto usa Firebase Authentication como servicio de autenticación es necesario crear un proyecto en la [consola de Firebase](https://console.firebase.google.com/).

Una vez creado el proyecto debe registrar una nueva app iOS para obtener el archivo ```GoogleService-Info.plist```. Este archivo deberas agregarlo al proyecto en la siguiente ruta: ```Playground/Playground/GoogleService-info.plist```

#### Importante!
Durante el proceso se solicitará el id de la app, este debe ser único por lo que debes proporcionar uno diferente al del proyecto y cambiarlo.
e.g. ```com.yourname.yourproject```. Puedes cambiar el id abriendo el proyecto con Xcode y yendo a: Playground > General > Targets > Playground > Bundle Identifier.

Para más información: [iOS setup](https://firebase.google.com/docs/ios/setup?authuser=0)

### Listo!

Ahora solo resta abrir el proyecto mediante el archivo

```sh
App.xcworkspace
```


