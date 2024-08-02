# Basis-Image festlegen
FROM ubuntu:20.04

# Arbeitsverzeichnis setzen
WORKDIR /app

# Abhängigkeiten installieren
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    # Weitere notwendige Pakete hinzufügen...

# Anwendungscode klonen
RUN git clone https://github.com/username/tx-nextGen.git /app

# Python-Abhängigkeiten installieren
RUN pip3 install -r /app/requirements.txt

# Exponieren des Ports, auf dem die Anwendung läuft
EXPOSE 5000

# Startbefehl festlegen
CMD ["python3", "/app/app.py"]
