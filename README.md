# vscode-theme-change-detector

## Setup and Run

### Environment variables

See [.env.example](./.env.example)

### Run on Docker

It is recommended to create volume and mount to `/work`.

```
$ docker create volume vscode-theme-change-detector
$ docker build -t vscode-theme-change-detector .
$ docker run --env-file=.env -v vscode-theme-change-detector:/work --rm -it vscode-theme-change-detector
```

## License and Notices

See [LICENSE](./LICENSE) for vscode-theme-change-detector and [DOCKER_NOTICE](https://github.com/nonylene/vscode-theme-change-detector/blob/master/DOCKER_NOTICE) for Docker image notices.
