import subprocess
from time import sleep


def serve_zola(interface="127.0.0.1", port="1111"):
    subprocess.run(["zola", "build"])
    process = subprocess.Popen(
        ["zola", "serve", "--interface", interface, "--port", port]
    )

    return process


class Serve:
    def __init__(self, interface="127.0.0.1", port="1111"):
        self.interface = interface
        self.port = port

    def __enter__(self):
        self.process = serve_zola(self.interface, self.port)
        sleep(0.5)

    def __exit__(self, exc_type, exc_value, exc_tb):
        self.process.kill()
