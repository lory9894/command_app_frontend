docker compose up -d
cd cliente
flutter create .
flutter config --enable-web
flutter build web --base-href "/cliente/"
cp -r build/web ../html/cliente/
cd ../gestore
flutter create .
flutter config --enable-web
flutter build web --base-href "/gestore/"
cp -r build/web ../html/gestore/

