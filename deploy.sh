docker pull maryokpala/image1:latest1
docker stop acada-webapp1 acada-webapp2 acada-webapp3 acada-webapp4 acada-webapp5 || true
docker rm acada-webapp1  acada-webapp2 acada-webapp3 acada-webapp4 acada-webapp5 -f
docker network create acada-apps
docker run -d --name acada-webapp1 --hostname acada-webapp1 --network acada-apps maryokpala/image1:latest1
docker run -d --name acada-webapp2 --hostname acada-webapp2 --network acada-apps maryokpala/image1:latest1
docker run -d --name acada-webapp3 --hostname acada-webapp3 --network acada-apps maryokpala/image1:latest1
docker run -d --name acada-webapp4 --hostname acada-webapp4 --network acada-apps maryokpala/image1:latest1
docker run -d --name acada-webapp5 --hostname acada-webapp5 --network acada-apps maryokpala/image1:latest1
