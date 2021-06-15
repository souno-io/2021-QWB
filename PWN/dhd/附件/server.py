#!/usr/bin/python3
import tempfile
import os

def main():
    print("Please input your php script. Enter EOF to indicate and end")

    content = ""

    # Don't write too large script
    for i in range(1024):
        l = input()
        if l == 'EOF': break
        content += l + "\n"

    print(content)

    tmp = tempfile.NamedTemporaryFile(delete=False)
    try:
        tmp.write(str.encode(content))
        tmp.close()
        os.system("/home/ctf/php -f %s" % tmp.name)
    finally:
        tmp.close()
        os.unlink(tmp.name)

main()
