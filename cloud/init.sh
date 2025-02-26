#!/bin/bash

mkdir -p ./mysql/data
mkdir -p ./mysql/conf

mkdir -p ./nginx/conf/certs
mkdir -p ./nginx/conf/conf.d
mkdir -p ./nginx/html

echo 'types {
text/html                                        html htm shtml;
text/css                                         css;
text/xml                                         xml;
image/gif                                        gif;
image/jpeg                                       jpeg jpg;
application/javascript                           js;
application/atom+xml                             atom;
application/rss+xml                              rss;

text/mathml                                      mml;
text/plain                                       txt;
text/vnd.sun.j2me.app-descriptor                 jad;
text/vnd.wap.wml                                 wml;
text/x-component                                 htc;

image/avif                                       avif;
image/png                                        png;
image/svg+xml                                    svg svgz;
image/tiff                                       tif tiff;
image/vnd.wap.wbmp                               wbmp;
image/webp                                       webp;
image/x-icon                                     ico;
image/x-jng                                      jng;
image/x-ms-bmp                                   bmp;

font/woff                                        woff;
font/woff2                                       woff2;

application/java-archive                         jar war ear;
application/json                                 json;
application/mac-binhex40                         hqx;
application/msword                               doc;
application/pdf                                  pdf;
application/postscript                           ps eps ai;
application/rtf                                  rtf;
application/vnd.apple.mpegurl                    m3u8;
application/vnd.google-earth.kml+xml             kml;
application/vnd.google-earth.kmz                 kmz;
application/vnd.ms-excel                         xls;
application/vnd.ms-fontobject                    eot;
application/vnd.ms-powerpoint                    ppt;
application/vnd.oasis.opendocument.graphics      odg;
application/vnd.oasis.opendocument.presentation  odp;
application/vnd.oasis.opendocument.spreadsheet   ods;
application/vnd.oasis.opendocument.text          odt;
application/vnd.openxmlformats-officedocument.presentationml.presentation
pptx;
application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
xlsx;
application/vnd.openxmlformats-officedocument.wordprocessingml.document
docx;
application/vnd.wap.wmlc                         wmlc;
application/wasm                                 wasm;
application/x-7z-compressed                      7z;
application/x-cocoa                              cco;
application/x-java-archive-diff                  jardiff;
application/x-java-jnlp-file                     jnlp;
application/x-makeself                           run;
application/x-perl                               pl pm;
application/x-pilot                              prc pdb;
application/x-rar-compressed                     rar;
application/x-redhat-package-manager             rpm;
application/x-sea                                sea;
application/x-shockwave-flash                    swf;
application/x-stuffit                            sit;
application/x-tcl                                tcl tk;
application/x-x509-ca-cert                       der pem crt;
application/x-xpinstall                          xpi;
application/xhtml+xml                            xhtml;
application/xspf+xml                             xspf;
application/zip                                  zip;

application/octet-stream                         bin exe dll;
application/octet-stream                         deb;
application/octet-stream                         dmg;
application/octet-stream                         iso img;
application/octet-stream                         msi msp msm;

audio/midi                                       mid midi kar;
audio/mpeg                                       mp3;
audio/ogg                                        ogg;
audio/x-m4a                                      m4a;
audio/x-realaudio                                ra;

video/3gpp                                       3gpp 3gp;
video/mp2t                                       ts;
video/mp4                                        mp4;
video/mpeg                                       mpeg mpg;
video/quicktime                                  mov;
video/webm                                       webm;
video/x-flv                                      flv;
video/x-m4v                                      m4v;
video/x-mng                                      mng;
video/x-ms-asf                                   asx asf;
video/x-ms-wmv                                   wmv;
video/x-msvideo                                  avi;
}' > ./nginx/conf/mime.types

echo 'worker_processes  1;

events {
worker_connections  1024;
}

http {
include       mime.types;
default_type  application/octet-stream;

sendfile        on;
keepalive_timeout  65;

include /etc/nginx/conf.d/*.conf;
}' > ./nginx/conf/nginx.conf

echo 'server {
listen 80;
server_name nanguomm.top;
return 301 https://$host$request_uri;
}

server {
listen 443 ssl;
server_name nanguomm.top;

ssl_certificate  /etc/nginx/certs/full_chain.pem;
ssl_certificate_key /etc/nginx/certs/private.key;

location / {
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Host $http_host;
proxy_pass http://solo:8080;
client_max_body_size 20000m;
}
}

server {
listen 10000 ssl;
server_name nanguomm.top;

ssl_certificate  /etc/nginx/certs/full_chain.pem;
ssl_certificate_key /etc/nginx/certs/private.key;

location / {
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header Host $http_host;
proxy_pass http://x-ui:54321;
client_max_body_size 20000m;
}
}' > ./nginx/conf/conf.d/default.conf

mkdir -p ./x-ui

echo "所需的文件已成功创建！"


