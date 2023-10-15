import subprocess
from serve import Serve


# depends on wkhtmltopdf
def print_page(page: str, file: str):
    _res = subprocess.run(["wkhtmltopdf", "--print-media-type", page, file])


interface = "127.0.0.1"
port = "1234"
url = f"http://{interface}:{port}/"
print("generating new print format")
with Serve(interface, port):
    print_page(url, "test.pdf")
