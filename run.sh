#!/bin/bash

structure() {
    ls -la
}

build_generator() {
    docker build -t generator:latest -f Dockerfile.generator .
}

#запуск генератора
run_generator() {
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" generator:latest
}

create_local_data() {
    mkdir -p local_data
    python3 generate.py local_data
}

build_reporter() {
    docker build -t reporter:latest -f Dockerfile.reporter .
}

run_reporter() {
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" reporter:latest
}

clear_data() {
    rm -f data/*.csv data/*.html
    echo "data очищена"
}

inside_generator() {
    docker run --rm -v "$(pwd)/data:/data" --entrypoint ls generator:latest /data
}

inside_reporter() {
    docker run --rm -v "$(pwd)/data:/data" --entrypoint ls reporter:latest /data
}


# Выбор команды
case "$1" in
    structure)
        structure
        ;;
    build_generator)
        build_generator
        ;;
    run_generator)
        run_generator
        ;;
    create_local_data)
        create_local_data
        ;;
    build_reporter)
        build_reporter
        ;;
    run_reporter)
        run_reporter
        ;;
    clear_data)
        clear_data
        ;;
    inside_generator)
        inside_generator
        ;;
    inside_reporter)
        inside_reporter
        ;;
    *)
        echo "Использование: ./run.sh {structure|build_generator|run_generator|create_local_data|build_reporter|run_reporter|clear_data|inside_generator|inside_reporter}"
        exit 1
        ;;
esac