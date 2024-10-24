INPUT_DIR="public/assets/"
TEMP_FILE="image.bin"

# Procesar cada imagen PNG en el directorio de entrada
for INPUT_PNG in ${INPUT_DIR}*.png; do
    # Verificar si hay archivos PNG en el directorio
    if [ -f "$INPUT_PNG" ]; then
        # Extraer el nombre base del archivo (sin la ruta y extensión)
        BASENAME=$(basename "$INPUT_PNG" .png)

        echo "Procesando: $INPUT_PNG"

        # Convertir de PNG a secuencia de píxeles
        python3 fromPNG2Bin.py "${INPUT_PNG}"

        # Verificar si el archivo temporal se creó correctamente
        if [ ! -f "${TEMP_FILE}" ]; then
            echo "Error: No se pudo crear el archivo temporal ${TEMP_FILE} para $INPUT_PNG"
            continue
        fi

        # Procesar la secuencia de píxeles
        ./main "${TEMP_FILE}"

        # Verificar si el archivo nuevo se creó
        if [ ! -f "${TEMP_FILE}.new" ]; then
            echo "Error: No se pudo crear el archivo nuevo ${TEMP_FILE}.new para $INPUT_PNG"
            continue
        fi

        # Guardar la imagen procesada en el mismo directorio con el sufijo "_result.png"
        OUTPUT_PNG="${INPUT_DIR}${BASENAME}_result.png"
        python3 fromBin2PNG.py "${TEMP_FILE}.new" "${OUTPUT_PNG}"

        # Verificar si se creó la imagen de salida
        if [ -f "${OUTPUT_PNG}" ]; then
            echo "Imagen procesada guardada en: ${OUTPUT_PNG}"
        else
            echo "Error: No se pudo guardar la imagen procesada en ${OUTPUT_PNG}"
        fi
    else
        echo "No se encontraron archivos PNG en ${INPUT_DIR}"
    fi
done
