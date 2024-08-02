# Basis-Image festlegen (Ubuntu 20.04 LTS)
FROM ubuntu:20.04

# Arbeitsverzeichnis setzen
WORKDIR /app

# Abhängigkeiten installieren
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    openssh-client

# SSH-Konfigurationsdatei kopieren und Berechtigungen setzen
COPY .ssh /root/.ssh
RUN chmod 600 /root/.ssh/id_rsa_nextgen2
RUN chmod 700 /root/.ssh

# GitHub-Host zu known_hosts hinzufügen, um die Eingabeaufforderung zu vermeiden
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Starten des SSH-Agenten und Hinzufügen des Schlüssels
RUN eval $(ssh-agent -s) && ssh-add /root/.ssh/id_rsa_nextgen2

# Testen der SSH-Verbindung
RUN ssh -T git@github.com || exit 1

# Anwendungscode klonen
RUN git clone git@github.com:tx-machine/tx-nextGen.git /app

# Python-Abhängigkeiten installieren
RUN pip3 install -r /app/requirements.txt

# Exponieren des Ports, auf dem die Anwendung läuft
EXPOSE 5000

# Startbefehl festlegen
CMD ["python3", "/app/app.py"]
#note
