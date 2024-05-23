rm ../../../disk.img
dd if=/dev/zero of=../../../disk.img bs=32M count=30

mkfs.vfat -F 32 ../../../disk.img

mkdir -p mnt
sudo mount ../../../disk.img mnt

export FILE='rootfs'

# 根据命令行参数生成对应的测例
echo "Copying $FILE/* to disk"
sudo cp -r ./$FILE/* ./mnt/
sudo umount mnt
sudo rm -rf mnt
sudo chmod 777 ../../../disk.img