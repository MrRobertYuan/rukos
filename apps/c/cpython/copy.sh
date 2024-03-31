rm -r ../dl/root/bin
rm -r ../dl/root/lib/pkgconfig
rm -r ../dl/root/lib/python3.9
rm -r ../dl/root/lib/libpython3.9d.so
rm -r ../dl/root/lib/libpython3.9d.so.1.0
cp -r ../cpython-exec/bin ../dl/root/
cp -r ../cpython-exec/lib/*	../dl/root/lib/