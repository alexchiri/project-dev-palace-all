import os
import sys
import subprocess

registry = sys.argv[1]
repository = sys.argv[2]
distro = sys.argv[3]
wsl_base_path = sys.argv[4]

pull_container_cmd = f"docker pull {registry}.azurecr.io/{repository}:latest"
pull_return_code = subprocess.run(pull_container_cmd.split(),stdout=subprocess.PIPE).returncode

create_container_cmd = f"docker create {registry}.azurecr.io/{repository}:latest"
create_container_completed_process = subprocess.run(create_container_cmd.split(), stdout=subprocess.PIPE)

create_container_return_code = create_container_completed_process.returncode

if create_container_return_code == 0:
    container_id = create_container_completed_process.stdout.decode('utf-8')
    export_container_cmd = f"docker container export -o {distro}.tar {container_id}"
    export_container_return_code = subprocess.run(export_container_cmd.split(), stdout=subprocess.PIPE).returncode

    if export_container_return_code == 0:
        unregister_wsl_cmd = f"wsl --unregister {distro}"
        subprocess.run(unregister_wsl_cmd.split(), stdout=subprocess.PIPE)

        import_wsl_cmd = f"wsl --import {distro} {wsl_base_path}\\{distro} {distro}.tar"
        import_wsl_return_code = subprocess.run(import_wsl_cmd.split(), stdout=subprocess.PIPE).returncode

        if import_wsl_return_code == 0:
            start_wsl_distro_cmd = f"wsl -d {distro}"
            subprocess.run(start_wsl_distro_cmd.split())
        else:
            print("Import failed!")
            os.system("timeout 60")
    else:
        print("Could not export container!")
else:
    print("Container was not found!")
