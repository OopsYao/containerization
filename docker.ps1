$IMAGE = "oopsy/python:daily"
$COMMAND= "python"
$PARA="plot.py"
$CONTAINER_WORKING_DIR = "/pwd"
docker run --rm -w "$CONTAINER_WORKING_DIR" -v ${PWD}:"$CONTAINER_WORKING_DIR" "$IMAGE" "$COMMAND" "$PARA"