# 📘 Guía de Instalación en Servidor  
## MySQL 8 + Payara Server + Docker Compose

Este documento explica cómo instalar y ejecutar en un **servidor Linux** el entorno que incluye:

- **MySQL 8.0**
- **Payara Server Full**
- **Workload SOAP desplegado automáticamente**
- **Docker + Docker Compose**
- **Variables de entorno vía `.env`**

---

## 1️⃣ Requisitos del Servidor

### Sistema Operativo Recomendado
- Ubuntu 20.04 / 22.04  
- Debian 11+  
- CentOS / RockyLinux 8+

### Hardware mínimo
- CPU: 2 cores  
- RAM: 4 GB  
- Disco: 10 GB libres  

### Puertos usados
- 8083 → HTTP Payara  
- 4848 → Consola Admin Payara  
- 3307 → MySQL  

---

## 2️⃣ Instalar Docker y Docker Compose

Actualizar e instalar dependencias:

```bash
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release
