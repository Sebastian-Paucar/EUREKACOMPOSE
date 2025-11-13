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


### Hardware mínimo
- CPU: 2 cores  
- RAM: 4 GB  
- Disco: 5 GB libres  

### Puertos usados
- 8083 → HTTP Payara  
- 4848 → Consola Admin Payara  
- 3307 → MySQL  

---

## 2️⃣ Instalar Docker y Docker Compose
```bash
git clone https://github.com/Sebastian-Paucar/EUREKACOMPOSE
cd EUREKACOMPOSE
```


## 3️⃣ Configuración del puerto externo del servicio Payara

Para que el servicio SOAP genere el **WSDL con la dirección correcta**, es necesario configurar la variable `EXTERNAL_ADDRESS` en el archivo `.env`.

Esta variable define la **URL pública** desde la cual los clientes externos accederán al servicio.



Modifica la variable `EXTERNAL_ADDRESS` y reemplázala con la **IP o dominio del servidor** donde está ejecutándose el contenedor de Payara.

Ejemplo usando una IP local y el puerto externo 8083:
```env
EXTERNAL_ADDRESS=http://192.xxx.100.xxx:8083
```
## 4️⃣ Levantar el entorno completo
```bash
docker-compose up -d
```