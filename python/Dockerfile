FROM basic:1

RUN apt-get update && apt-get -y install --no-install-recommends python3.10 python3-pip ffmpeg libsm6 libxext6 ghostscript python3-tk xvfb \
        libx11-6 \
        libxext6 \
        libxtst6 \
        libxrender1 \
        libxft2 \
        libxpm4 \
        libxmu6 \
        libxaw7 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install "camelot-py[cv]" PyPDF2==2.12.1 matplotlib pyvirtualdisplay