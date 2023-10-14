from playwright.sync_api import sync_playwright

from serve import Serve


def print_page(page: str):
    playwright = sync_playwright().start()

    browser = playwright.chromium.launch()
    page = browser.new_page()
    page.goto("https://cv.glennwso.com/")
    margins = 0.5
    # page.emulate_media(media="print")
    page.pdf(
        path="example.pdf",
        format="A4",
        print_background=True,
        margin={
            "top": f"{margins}in",
            "bottom": f"{margins}in",
            "left": f"{margins}in",
            "right": f"{margins}in",
        },
    )
    browser.close()

    playwright.stop()


interface = "127.0.0.1"
port = "1111"
url = "http://{interface}:{port}/"
with Serve(interface, port):
    print_page(url)
