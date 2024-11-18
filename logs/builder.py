# 2024-11-18T22:43:29.336628800
import vitis

client = vitis.create_client()
client.set_workspace(path="D:/FPGA/AES_SV")

platform = client.create_platform_component(name = "aes_128_pf",hw_design = "D:/FPGA/AES_SV/aes_128_xsa.xsa",os = "standalone",cpu = "psu_cortexa53_0",domain_name = "standalone_psu_cortexa53_0")

platform = client.get_component(name="aes_128_pf")
status = platform.build()

comp = client.create_app_component(name="aes_128_app",platform = "D:/FPGA/AES_SV/aes_128_pf/export/aes_128_pf/aes_128_pf.xpfm",domain = "standalone_psu_cortexa53_0")

client.delete_component(name="aes_128_app")

comp = client.create_app_component(name="aes_128_app",platform = "D:/FPGA/AES_SV/aes_128_pf/export/aes_128_pf/aes_128_pf.xpfm",domain = "standalone_psu_cortexa53_0",template = "empty_application")

client.delete_component(name="aes_128_app")

comp = client.create_app_component(name="aes_128_app",platform = "D:/FPGA/AES_SV/aes_128_pf/export/aes_128_pf/aes_128_pf.xpfm",domain = "standalone_psu_cortexa53_0",template = "hello_world")

status = platform.build()

comp = client.get_component(name="aes_128_app")
comp.build()

status = platform.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

status = platform.build()

comp.build()

status = platform.build()

status = platform.build()

comp.build()

status = platform.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

comp.build()

status = platform.build()

status = platform.build()

comp.build()

vitis.dispose()

