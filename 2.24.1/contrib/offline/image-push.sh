#!/bin/bash

# 이미지 리스트가 담긴 파일 이름
IMAGE_LIST="temp/images.list"

# Private Registry 주소
PRIVATE_REGISTRY="192.168.116.138:5000"

# 이미지 리스트 파일을 읽으면서 라인별로 처리
while IFS= read -r image; do
  echo "Pulling image: $image"
  docker pull "$image"

  # 이미지 태그의 Private Registry 버전 생성
  private_image="${PRIVATE_REGISTRY}/${image}"
  echo "Tagging image for private registry: $private_image"
  docker tag "$image" "$private_image"

  # Private Registry로 Push
  echo "Pushing image to private registry: $private_image"
  docker push "$private_image"
done < "$IMAGE_LIST"

echo "All images have been processed."
