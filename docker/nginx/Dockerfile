FROM nginx:1.20
RUN apt-get update && apt-get install -y tzdata && rm -rf /var/lib/apt/lists/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY uwsgi_params /etc/nginx/uwsgi_params
RUN rm /etc/nginx/conf.d/default.conf
ENV TZ=Asia/Tokyo
CMD ["nginx", "-g", "daemon off;"]