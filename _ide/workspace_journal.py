# 2026-04-06T15:31:05.633388
import vitis

client = vitis.create_client()
client.set_workspace(path="AES_SV")

vitis.dispose()

