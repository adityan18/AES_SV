import vitis
from pathlib import Path
from argparse import ArgumentParser
import shutil
import time

ROOT = Path(__file__).parent
VITIS_WS = ROOT / "vitis_ws"
PLATFORM_NAME = "aes_128_platform"


def generate_platform(client, xsa_path: Path):
    status = ""
    try:
        platform = client.create_platform_component(
            name=PLATFORM_NAME,
            hw_design=str(xsa_path),
            os="standalone",
            cpu="psu_cortexa53_0",
        )
        status = platform.build()
    except Exception as E:
        if "ALREADY_EXISTS" in str(E):
            print("Deleting Existing and rebuilding...")
            shutil.rmtree(VITIS_WS / PLATFORM_NAME)
            time.sleep(1)
            platform = client.create_platform_component(
                name=PLATFORM_NAME,
                hw_design=str(xsa_path),
                os="standalone",
                cpu="psu_cortexa53_0",
            )
            status = platform.build()
    print(status)


def parse_args():
    parser = ArgumentParser(
        "AES128 Platform Generator", description="Generates Platform"
    )

    parser.add_argument("--xsa", help="XSA Path", type=str)

    return parser.parse_args()


def main(xsa) -> None:

    client = vitis.create_client()

    try:
        client.set_workspace(str(VITIS_WS))
    except:
        client.update_workspace(str(VITIS_WS))



    generate_platform(client, xsa)


if __name__ == "__main__":
    args = parse_args()
    main(**vars(args))
