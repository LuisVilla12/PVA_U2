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

        if operation == "erosion":
            result = cv2.erode(img, kernel, iterations=1)
        elif operation == "dilatacion":
            result = cv2.dilate(img, kernel, iterations=1)
        elif operation == "apertura":
            result = cv2.morphologyEx(img, cv2.MORPH_OPEN, kernel)
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

@app.post("/erosion")
async def erosion(sample_file: UploadFile = File(...), ksize: int = Query(5)):
    return await _process_upload(sample_file, "erosion", ksize)

