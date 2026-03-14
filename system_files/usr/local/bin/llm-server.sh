
#!/bin/sh

# Configuration
CONTAINER_NAME="llama-rocm-7.2-server"
IMAGE_NAME="docker.io/kyuz0/amd-strix-halo-toolboxes:rocm-7.2"
MODEL_PATH="/models/qwen3-coder-30B-A3B/BF16/Qwen3-Coder-30B-A3B-Instruct-BF16-00001-of-00002.gguf"
PORT="8080"
MODEL_VOLUME="$HOME/models:/models:z"
set -e

# Function to check if container is running
is_container_running() {
    podman ps -f name="$CONTAINER_NAME" --format "{{.Names}}" | grep -q "$CONTAINER_NAME"
}

# Function to stop existing container
stop_container() {
    if is_container_running; then
        printf "Stopping existing container...\n"
        podman stop "$CONTAINER_NAME"
    fi
}

# Function to pull latest image
pull_image() {
    printf "Pulling latest image...\n"
    podman pull "$IMAGE_NAME"
}

# Function to start the container
start_container() {
    printf "Starting container with model: %s\n" "$MODEL_PATH"
    
    podman run --rm \
        --name "$CONTAINER_NAME" \
        --device /dev/dri \
        --device /dev/kfd \
        --group-add video \
        --group-add render \
        --ipc=host \
        --cgroupns=host \
        --ulimit memlock=-1 \
        --security-opt seccomp=unconfined \
        -p "$PORT:$PORT" \
        -v "$MODEL_VOLUME" \
        "$IMAGE_NAME" \
        llama-server \
            --models-preset /models/models.ini \
            --host 0.0.0.0 \
            --port 8080 \
            --models-max 1 \
            --parallel 1
        # llama-server \
        # -m "$MODEL_PATH" \
        # -h "0.0.0.0" \
        # -c 8192 \
        # -ngl 999 \
        # -fa 1 \
        # --no-mmap
}

debug_container() {
    podman run --rm \
        --name "$CONTAINER_NAME" \
        --device /dev/dri \
        --device /dev/kfd \
        --group-add video \
        --group-add render \
        --ipc=host \
        --cgroupns=host \
        --ulimit memlock=-1 \
        --security-opt seccomp=unconfined \
        -p "$PORT:$PORT" \
        -v "$MODEL_VOLUME" \
        -it \
        "$IMAGE_NAME" \
        bash
}

# Main execution
main() {
    printf "Managing Llama-ROCm container...\n"
    
    case "${1:-start}" in
        "start")
            stop_container
            start_container
            ;;
        "stop")
            stop_container
            printf "Container stopped\n"
            ;;
        "restart")
            stop_container
            start_container
            ;;
        "update")
            pull_image
            ;;
        "debug")
            stop_container
            debug_container
            ;;
        "status")
            if is_container_running; then
                printf "Container is running\n"
            else
                printf "Container is not running\n"
            fi
            ;;
        *)
            printf "Usage: %s {start|stop|restart|update|debug|status}\n" "$(basename "$0")"
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"

