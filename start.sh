echo "------------------------ CLEAN ------------------------"
rm -rf node_modules
rm -rf build
rm package-lock.json
source .env
echo "------------------------ INSTALL ------------------------"
npm i
echo "------------------------ BUILD --------------------------"
npm run build
echo "------------------------ STOP CONTAINER ------------------------"
docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME
docker rmi $IMAGE_NAME
echo "------------------------ DEPLOY -------------------------"
docker-compose up -d
echo "------------------------ MOVE STATIC FILES -------------------------"
docker cp $CONTAINER_NAME:/usr/share/nginx/html/static/js/. $JS_LOC
docker cp $CONTAINER_NAME:/usr/share/nginx/html/static/css/. $CSS_LOC
echo "------------------------ MOVE MEDIA FILES -------------------------"
docker cp $CONTAINER_NAME:/usr/share/nginx/html/static/media/. $MEDIA_LOC