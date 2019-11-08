param($parameters)
$config = Get-Content "./commands.json" | ConvertFrom-Json
$IMAGE = $config.image
$COMMAND = $config.command
$PARA = $parameters.Replace("\", "/")
$CONTAINER_WORKING_DIR = $config.workdir
docker run --rm -w "$CONTAINER_WORKING_DIR" -v ${PWD}:"$CONTAINER_WORKING_DIR" -e DISPLAY=host.docker.internal:0.0 "$IMAGE" "$COMMAND" "$PARA"