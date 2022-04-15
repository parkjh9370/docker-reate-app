# Builder stage
# 빌드 파일을 생성해 /usr/src/app/build 에 저장
# as : 현재 FROM ~ 다음 FROM 단계를 builder stage로 지정
FROM node:alpine as builder

WORKDIR '/usr/src/app'

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build

# Run stage

FROM nginx
# bulider stage에서 온 빌드 파일을 nginx가 정적 파일을 제공해줄 수 있는 위치에 저장
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# 이미지 생성 : DOCKER_BUILDKIT=0 docker build ./
# 컨테이너 실행 : docker run -p 8080:80 <이미지이름>
# nginx 기본 포트: 80
