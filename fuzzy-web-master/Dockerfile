# Gunakan image Flutter dari CirrusCI
FROM cirrusci/flutter:latest AS build

# Set working directory
WORKDIR /app

# Salin pubspec dan pubspec.lock terlebih dahulu untuk cache dependensi
COPY pubspec.* ./
RUN flutter clean
RUN flutter pub get

# Salin kode sumber Flutter
COPY . .

# Cek versi
RUN flutter --version

# Cek dependensi
RUN flutter doctor -v
RUN flutter pub get --verbose

# Build aplikasi Flutter web
RUN flutter build web

# Gunakan image dasar dari Nginx untuk menyajikan aplikasi
FROM nginx:alpine

# Salin hasil build dari tahap sebelumnya ke direktori Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Salin konfigurasi Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port yang diinginkan (misalnya 8081)
EXPOSE 8081

# Konfigurasi default Nginx
CMD ["nginx", "-g", "daemon off;"]
