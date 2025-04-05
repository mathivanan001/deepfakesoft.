from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class AlertRequest(BaseModel):
    alert_type: str
    message: str

@app.post("/alert/")
async def send_alert(alert: AlertRequest):
    return {
        "status": "Alert Sent",
        "type": alert.alert_type,
        "message": alert.message
    }
