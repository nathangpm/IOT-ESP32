[README.md](https://github.com/user-attachments/files/27422584/README.md)
# 🌡️ Monitoramento Inteligente com IoT — ESP32 + MQTT + Node-RED + Oracle

> Trabalho Prático CP2 — Integração de Sistemas IoT

---

## 📋 Descrição do Projeto

Sistema de monitoramento em tempo real utilizando um **ESP32** com dois sensores:
- **DHT22** — Temperatura
- **LDR (Photoresistor)** — Luminosidade

Os dados são transmitidos via **MQTT** para o **Node-RED**, que processa, exibe em dashboard e persiste no banco de dados **Oracle**. O sistema também consome dados climáticos externos via **API OpenWeatherMap**.

---

## 🏗️ Arquitetura da Solução

```
┌─────────────────────────────────────────┐
│           ESP32 (Wokwi)                 │
│  ├── DHT22  → Temperatura               │
│  └── LDR    → Luminosidade              │
│         │                               │
│         └── WiFi → MQTT Publish         │
└─────────────────────────────────────────┘
                    │
           broker.hivemq.com
          (Broker MQTT público)
                    │
┌─────────────────────────────────────────┐
│              NODE-RED                   │
│  MQTT Subscribe: maquina1/dados         │
│         │                               │
│    Processamento (JSON Parse)           │
│         │                               │
│  ┌──────┼──────────────┐                │
│  ▼      ▼              ▼                │
│ Dashboard  Alertas   Oracle DB          │
│ (Gauges +  (Texto)   (leituras)         │
│  Charts)                                │
│  ▲                                      │
│  └── API OpenWeatherMap (5 min)         │
└─────────────────────────────────────────┘
```

---

## 🛠️ Tecnologias Utilizadas

| Tecnologia | Uso |
|---|---|
| ESP32 (Wokwi) | Microcontrolador — leitura dos sensores |
| DHT22 | Sensor de temperatura |
| LDR (Photoresistor) | Sensor de luminosidade |
| MQTT | Protocolo de comunicação IoT |
| HiveMQ (broker.hivemq.com) | Broker MQTT público e gratuito |
| Node-RED | Processamento, dashboard e integração |
| node-red-dashboard | Interface visual em tempo real |
| node-red-contrib-oracledb | Persistência no banco Oracle |
| Oracle DB (FIAP) | Banco de dados relacional |
| OpenWeatherMap API | Dados climáticos externos |

---

## 📡 Tópico MQTT

| Tópico | Formato | Exemplo |
|---|---|---|
| maquina1/dados | JSON | {"temperatura":26.5,"luminosidade":1001} |

---

## 📊 Dashboard

O dashboard exibe:
- Gauge Temperatura — valor em °C em tempo real
- Gauge Luminosidade — valor ADC (0-4095) em tempo real
- Gráfico Temperatura — histórico da última hora
- Gráfico Luminosidade — histórico da última hora
- Alertas — status de temperatura e luminosidade
- Clima Externo — dados de São Paulo via OpenWeatherMap

---

## 🗄️ Banco de Dados Oracle

```sql
CREATE TABLE leituras (
    id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sensor    VARCHAR2(50) NOT NULL,
    valor     FLOAT NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE alertas (
    id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo      VARCHAR2(100) NOT NULL,
    mensagem  VARCHAR2(500) NOT NULL,
    valor     FLOAT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 🔧 Instruções de Execução

### 1. Simulação do ESP32 (Wokwi)

1. Acesse wokwi.com e crie um novo projeto ESP32
2. Substitua o sketch.ino, diagram.json e libraries.txt pelos arquivos deste repositório
3. Clique em Start Simulation
4. Verifique no Serial Monitor: WiFi conectado! e conectado!

### 2. Banco de Dados Oracle

1. Acesse o SQL Developer com os dados da sua instituição
2. Execute o arquivo Cp2 - IOT.sql para criar as tabelas

### 3. Node-RED

Instalar paletas: node-red-dashboard e node-red-contrib-oracledb

Importar o fluxo: Menu -> Import -> cole o flows.json -> Deploy

Acessar o dashboard: http://localhost:1880/ui

---

## 📁 Estrutura do Repositório

```
CP2-IOT/
 ├── sketch.ino        → Código do ESP32
 ├── diagram.json      → Circuito Wokwi
 ├── libraries.txt     → Bibliotecas Wokwi
 ├── flows.json        → Fluxo Node-RED
 ├── Cp2 - IOT.sql     → Script banco Oracle
 └── README.md         → Documentação
```

---

## Autor

Nathan Gonçalves Pereira Mendes e 
João Pedro Bitencourt Goldoni
RM564666 — Rm564339
