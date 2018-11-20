#  Currency Converter 2.0
## Objetivo.- Convertir un cantidad de una moneda a otra moneda

### Vamos a utilizar los siguientes POD's
Alamofire
SwiftyJSON
Chameleon Framework (Opcional)
SVProgressHUD (Opcional)

### Instalación de POD's
1. Abrir la aplicación de *Terminal*
2. Cambiarte al directorio donde está la aplicación que acabas de crear (Usa el comando *cd*)
3. Teclea el comando *pod init*
4. Teclea *open Podfile -a Xcode*
    Quita el comentario a la línea donde dice #platform :ios, '9.0' (*borra el signo de #*)
    Agrega las siguientes líneas antes del comando *end*:
   
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'SVProgressHUD'
    pod 'ChameleonFramework'
    
    Salva el archivo y cierra el Xcode
5. Teclea *pod install*
6. Abre el proyecto con extensión *xcworkspace* que se acaba de crear
    


