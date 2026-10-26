from pathlib import Path
from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
BASE = Path(__file__).resolve().parent
app = FastAPI(title='Alfulaiti Development Growth Intelligence', version='3.0.0')
app.mount('/static', StaticFiles(directory=BASE/'app'/'static'), name='static')
@app.get('/', response_class=HTMLResponse)
def home(): return (BASE/'app'/'static'/'index.html').read_text(encoding='utf-8')
@app.get('/health')
def health(): return {'status':'ok','app':'Alfulaiti Growth Intelligence'}
@app.get('/api/overview')
def overview(): return {'status':'ok','message':'Alfulaiti Development Growth Intelligence backend is running','version':'3.0.0'}
