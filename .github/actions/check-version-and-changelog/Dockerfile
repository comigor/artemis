FROM makocchi/alpine-git-curl-jq

ENV OQ_VERSION 1.1.0
RUN curl -L https://github.com/Blacksmoke16/oq/releases/download/v${OQ_VERSION}/oq-v${OQ_VERSION}-linux-x86_64 > /usr/local/bin/oq \
    && chmod +x /usr/local/bin/oq

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]