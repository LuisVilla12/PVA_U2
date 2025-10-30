#Importa la clase FastAPI para crear la aplicación.
import io
import cv2
from fastapi import FastAPI, HTTPException,Form,File, Query,UploadFile
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse, StreamingResponse
from fastapi.responses import FileResponse
import numpy as np

#Crea una instancia de la aplicación FastAPI.
app = FastAPI()
# ✅ Configuración de CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

#Define una ruta raíz
@app.get("/")
def home():
    return {"mensaje": "Bienvenido a la API"}

@app.get("/ping")
async def ping():
    return JSONResponse(content={"status": "ok"})

async def _process_upload(sample_file: UploadFile, operation: str, ksize: int = 5) -> StreamingResponse:
    try:
        contents = await sample_file.read()
        nparr = np.frombuffer(contents, np.uint8)
        img = cv2.imdecode(nparr, cv2.IMREAD_UNCHANGED)
        if img is None:
            raise HTTPException(status_code=400, detail="No se pudo decodificar la imagen")

        # crear kernel (ksize debe ser impar idealmente)
        k = max(1, int(ksize))
        if k % 2 == 0:
            k += 1
        kernel = np.ones((k, k), np.uint8)
        # Operaciones morfologicos
        if operation == "erosion":
            result = cv2.erode(img, kernel, iterations=1)
        elif operation == "dilatacion":
            result = cv2.dilate(img, kernel, iterations=1)
        elif operation == "apertura":
            result = cv2.morphologyEx(img, cv2.MORPH_OPEN, kernel)
        elif operation == "cierre":
            result = cv2.morphologyEx(img, cv2.MORPH_CLOSE, kernel)
        # filtros especiales
        elif operation == "mediana":
            k_median = max(3, int(ksize))
            if k_median % 2 == 0:
                k_median += 1
            result = cv2.medianBlur(img, k_median)
            
        elif operation == "enfoque":
            kernel_sharpen = np.array([[0, -1, 0],
                                       [-1, 5, -1],
                                       [0, -1, 0]], dtype=np.float32)
            result = cv2.filter2D(img, -1, kernel_sharpen)

        elif operation == "desenfoque":
            k_blur = max(1, int(ksize))
            if k_blur % 2 == 0:
                k_blur += 1
            result = cv2.GaussianBlur(img, (k_blur, k_blur), 0)
            
        elif operation == "bordes":
            # detección de bordes con Canny — convertir a gris si es necesario
            if len(img.shape) == 3 and img.shape[2] == 4:
                gray = cv2.cvtColor(img, cv2.COLOR_BGRA2GRAY)
            elif len(img.shape) == 3 and img.shape[2] == 3:
                gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
            else:
                gray = img
            # usar ksize como threshold adaptativo de Canny (suavemente)
            t = max(50, min(200, int(ksize) * 10))
            edges = cv2.Canny(gray, t // 2, t)
            # convertir a 3 canales para mantener consistencia PNG coloreable
            result = cv2.cvtColor(edges, cv2.COLOR_GRAY2BGR)
            
        # filtros elementales
        elif operation == "brillo":
            beta = min(255, max(-255, int(ksize))) 
            result = cv2.add(img, beta)
            
        elif operation == "contraste":
            alpha = max(0.1, min(3.0, float(ksize)/10))
            result = cv2.multiply(img, alpha)
            
        elif operation == "cuantizacion":
            # Usar ksize como número de niveles (2-256)
            levels = max(2, min(256, int(ksize)))
            # Calcular el factor de cuantificación
            factor = 255 / (levels - 1)
            # Aplicar cuantificación
            result = np.uint8(np.round(img / factor) * factor)
            
        elif operation == "negativo":
            result = cv2.bitwise_not(img)
            
        elif operation == "transformaciones":
            gamma = max(0.1, min(3.0, float(ksize)/10))
            # Aplicar corrección gamma
            lookUpTable = np.empty((1,256), np.uint8)
            for i in range(256):
                lookUpTable[0,i] = np.clip(pow(i / 255.0, gamma) * 255.0, 0, 255)
            result = cv2.LUT(img, lookUpTable)
            
        else:
            raise HTTPException(status_code=400, detail="Operación no soportada")
        success, buf = cv2.imencode('.png', result)
        if not success:
            raise HTTPException(status_code=500, detail="Error al codificar la imagen procesada")

        return StreamingResponse(io.BytesIO(buf.tobytes()), media_type="image/png")
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# Operaciones morfologicas
@app.post("/erosion")
async def erosion(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "erosion", ksize)

@app.post("/dilatacion")
async def dilatacion(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "dilatacion", ksize)

@app.post("/apertura")
async def apertura(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "apertura", ksize)

@app.post("/cierre")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "cierre", ksize)

# Filtros especiales
@app.post("/mediana")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "mediana", ksize)

@app.post("/enfoque")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "enfoque", ksize)

@app.post("/desenfoque")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "desenfoque", ksize)

@app.post("/bordes")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "bordes", ksize)

# Filtros Elementales
@app.post("/brillo")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "brillo", ksize)

@app.post("/contraste")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "contraste", ksize)

@app.post("/negativo")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "negativo", ksize)

@app.post("/cuantizacion")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "cuantizacion", ksize)

@app.post("/transformaciones")
async def cierre(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "transformaciones", ksize)
