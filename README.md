# Boletero App

Proyecto en Flutter que genera una aplicación que permite la lectura del timbre electronico del SII que se encuentra en todas las boletas generadas al momento de realizar una compra, con el fin de registrarla y poder tener un respaldo digital de ella.

Project in Flutter that generates an application that allows the reading of the electronic stamp of the SII that is found in all the tickets generated at the time of making a purchase, in order to register it and be able to have a digital backup of it.

## 📌 Características
- Compatible con iOS y Android
- Lectura por cámara de timbre electrónico SII presente en boletas (PDF417).
- Integración con Firebase para autenticación y almacenamiento
- Exportación en PDF de boletas.
- UI responsiva con Material Design

## 📂 Estructura del Proyecto
```
/
├── lib/                # Código fuente principal
├── assets/             # Recursos gráficos y estáticos
├── test/               # Pruebas unitarias y de integración
├── pubspec.yaml        # Configuración de dependencias
└── README.md           # Documentación principal
```

## 🚀 Instalación y Uso
1. Clonar el repositorio:
   ```sh
   git clone https://github.com/EstebanTomic/boletero.git
   cd boletero
   ```

2. Instalar Flutter si aún no lo tienes:
   - Descarga desde [flutter.dev](https://flutter.dev/docs/get-started/install)
   - Agrega Flutter al `PATH` del sistema

3. Verificar la configuración del entorno:
   ```sh
   flutter doctor
   ```

4. Instalar dependencias del proyecto:
   ```sh
   flutter pub get
   ```

5. Ejecutar la aplicación en un emulador o dispositivo físico:
   ```sh
   flutter run
   ```

## 📖 Documentación
Para más detalles sobre la arquitectura y funcionalidades del proyecto, revisa la carpeta `docs/`.

## 📜 Licencia
Este proyecto está bajo la licencia MIT.

## ✨ Autor
Desarrollado por **[Esteban Tomic A.](https://github.com/EstebanTomic) - e.tomic@gmail.com**.
