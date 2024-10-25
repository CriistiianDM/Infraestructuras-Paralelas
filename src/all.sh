# #!/usr/bin/env bash

# INPUT_DIR="./public/assets/"
# OUTPUT_DIR="./public/result/"
# TEMP_FILE="image.bin"


# for INPUT_PNG in ${INPUT_DIR}*.png; do
#     echo "Procesando: ${INPUT_PNG}"

#     TEMP_FILE="${INPUT_PNG%.png}.bin"

#     python3 fromPNG2Bin.py ${INPUT_PNG}
#     ./main ${TEMP_FILE}                      
#     python3 fromBin2PNG.py ${TEMP_FILE}.new

#     echo "Procesado y guardado: ${INPUT_PNG}"
# done
#!/usr/bin/env bash

# Directorios de entrada y salida
INPUT_DIR="./public/assets/"
OUTPUT_DIR="./public/result/"
TEMP_FILE="image.bin"

# Crear el directorio de salida si no existe
mkdir -p "$OUTPUT_DIR"

# Procesar cada archivo PNG en el directorio de entrada
for INPUT_PNG in "${INPUT_DIR}"*.png; do
    # Verificar si hay archivos PNG en el directorio
    if [ ! -e "$INPUT_PNG" ]; then
        echo "No se encontraron archivos PNG en $INPUT_DIR"
        exit 1
    fi

    echo "Procesando: ${INPUT_PNG}"

    TEMP_FILE="${INPUT_PNG%.png}.bin"

    python3 fromPNG2Bin.py ${INPUT_PNG}
    ./main ${TEMP_FILE}                      
    python3 fromBin2PNG.py ${TEMP_FILE}.new

    echo "Procesado y guardado: ${INPUT_PNG}"
done
