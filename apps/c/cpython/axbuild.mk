python-objs := python3

app-objs := $(python-objs)

$(APP)/python3: static-link

static-link:
	aarch64-linux-musl-ld -r $(APP)/Programs/python.o $(APP)/libpython3.9d.a -o $(APP)/python3