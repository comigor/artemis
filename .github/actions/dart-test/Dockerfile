FROM cirrusci/flutter:stable

USER root

RUN apt update && apt install -y jq

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]