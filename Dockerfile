FROM ubuntu:22.04
 RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
&& apt update \
&& apt install -y --no-install-recommends \
   build-essential \
   gtkwave \
   verilator \
&& apt -y clean \
&& rm -rf /var/lib/apt/lists/*