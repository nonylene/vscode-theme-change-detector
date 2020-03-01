FROM alpine

RUN apk add --no-cache curl git jq bash
COPY ./vscode-theme-change-detector.sh /app/

WORKDIR /work
CMD ["/app/vscode-theme-change-detector.sh"]
