docker build ../Builder -t builder

docker run --rm \
  --env NDKARCH="linux-x86_64" \
  --volume="$PWD:/go" \
  -it builder:latest \
  ./build_Android_shared.sh

docker run --rm \
  --env NDKARCH="linux-x86_64" \
  --volume="$PWD:/go" \
  -it builder:latest \
  ./build_windows_cross.sh