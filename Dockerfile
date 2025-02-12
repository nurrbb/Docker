# -----------------------------------------------------------
# Dockerfile: Kendi image dosyalarımızı oluşturmak için
# -----------------------------------------------------------

# Temel image olarak Node.js (v14) kullanılıyor
FROM node:14

# Bakım bilgileri
LABEL maintainer="enurb320@gmail.com"

# Ortam değişkenleri: Uygulama adı, sürüm ve port numarası
ENV APP_NAME="Node Js, Dockerfile" \
    VERSION="v1.0.0" \
    PORT="9999"

# Ortam değişkenlerini doğrulamak için çıktı veriyoruz
RUN echo "App Name: $APP_NAME" && \
    echo "Port: $PORT" && \
    echo "Version: $VERSION"

# Kalıcılık için bir volume tanımlanıyor (ör. geçici dosyalar için)
VOLUME /tmp

# Çalışma dizinini ayarla (Linux ortamı)
WORKDIR /usr/src/app
# Windows ortamı için örnek: WORKDIR C:\app

# Gerekli dosyaları image içerisine kopyala
# package.json ve package-lock.json dosyalarını kopyalıyoruz
COPY package*.json ./

# Bağımlılıkları yükle
RUN npm install

# Uygulama kodlarını kopyala
COPY . .

# Container'ın dış dünya ile iletişim kuracağı portu belirle
EXPOSE 9999

# Container başlatıldığında çalıştırılacak komut (uygulamayı başlat)
CMD ["npm", "start"]
# Windows ortamında örnek: CMD ["powershell.exe", "start"]

# -----------------------------------------------------------
# HEALTHCHECK: Container sağlığını kontrol et
# -----------------------------------------------------------
# Sağlık kontrolü ayarları:
#   --interval=30s    : Her 30 saniyede bir kontrol et.
#   --timeout=10s     : Kontrolün tamamlanması için 10 saniye bekle.
#   --start-period=5s : Container başlatıldıktan sonra ilk kontrol 5 saniye sonra yapılır.
#   --retries=3       : Başarısız olursa 3 kez dene.
#
# Belirtilen URL'den HTTP 200 dönmezse çıkış kodu 1 döner.
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:9999/ || exit 1

# -----------------------------------------------------------
# Dockerfile'ı Çalıştırma Adımları
# -----------------------------------------------------------
# Docker image'ını oluşturmak için:
#   docker build -t node_project .
# veya
#   docker build .

# Container'ı çalıştırmak için:
#   docker container run --name nod
