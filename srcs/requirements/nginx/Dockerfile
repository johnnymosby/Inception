FROM alpine:3.19

WORKDIR /server

COPY . .

RUN apk add --no-cache nginx openssl \
	&& mkdir ssl \
	&& openssl req -x509 -noenc -newkey rsa:4096 \
		-keyout ssl/rbasyrov.42.fr.crt \
		-out ssl/rbasyrov.42.fr.key \
		-subj "/C=AT/ST=Vienna/L=Vienna/O=42 School/OU=Student/CN=rbasyrov.42.fr/emailAddress=rbasyrov@student.42vienna.com/"

ENTRYPOINT [ "nginx", "-c", "/server/conf/nginx.conf" ]

CMD [ "-g", "daemon off;" ]
