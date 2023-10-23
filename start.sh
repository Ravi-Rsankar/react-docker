echo "------------------------ CLEAN ------------------------"
rm -rf node_modules
rm -rf build
rm package-lock.json
source .env
echo "------------------------ INSTALL ------------------------"
npm i
echo "------------------------ BUILD --------------------------"
sudo PUBLIC_URL=/shopping-cart npm run build
echo "------------------------ STOP CONTAINER ------------------------"
docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME
docker rmi $IMAGE_NAME
echo "------------------------ DEPLOY -------------------------"
docker-compose up -d