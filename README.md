# app_vs

Aplicación de Procesamiento de Imágenes con Flutter, FastAPI y OpenCV

Este proyecto consiste en una aplicación móvil desarrollada con Flutter que permite al usuario capturar imágenes, cargarlas desde la galería y aplicar diversos filtros espaciales, filtros elementales y operaciones morfológicas.
El backend está construido con FastAPI y utiliza OpenCV para realizar el procesamiento de imágenes.

✅ Características principales
📌 Frontend (Flutter + Dart)
Interfaz intuitiva y responsiva.
Captura de fotografías con vista previa.
Cambio entre cámara frontal y trasera.
Carga de imágenes desde la galería.
Aplicación de múltiples filtros: Brillo, Contraste, Transformación gamma, Negativo, Desenfoque gaussiano, Mediana, Enfoque, Detección de bordes, Erosión, Dilatación, Apertura y Cierre
Vista previa del resultado antes de procesar.
Descarga de la imagen generada.

Arquitectura
El proyecto sigue una arquitectura cliente–servidor:
Flutter (Cliente)
📸 Captura/selección de imagen
📤 Envía la imagen a la API
📥 Recibe el resultado procesado
🖼 Muestra la vista previa y permite descargar

FastAPI (Servidor)
🔍 Recibe la imagen
🧠 Procesa con OpenCV
✅ Devuelve la imagen modificada

Instalación y ejecución
✅ Backend
#Crear entorno virtual
python -m venv venv
#Instalar dependencias
pip install -r requirements.txt
#Ejecutar servidor
uvicorn main:app --reload

✅ Frontend
#Instalar dependencias
flutter pub get
#Correr la app
flutter run
