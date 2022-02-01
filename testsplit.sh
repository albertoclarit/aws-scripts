

INPUT="arn:aws:ecs:us-west-2:213207498725:task/dev-appa/ff5494226f9946f181b548ce9c1d2c93"
arrIN=(${INPUT//\// })
OUTPUT=${arrIN[${#arrIN[@]}-1]}
echo $OUTPUT