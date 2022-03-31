FROM alexchiri.azurecr.io/k8s:latest

USER root
RUN apt-get update && apt-get -y install libffi6 python3-pip

RUN python3 -m pip install azure-cli

RUN curl -L https://raw.githubusercontent.com/Azure/azure-cli/dev/az.completion -o /opt/az.completion
RUN echo "source /opt/az.completion" >> /home/alex/.zshrc

RUN wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    sudo dpkg -i packages-microsoft-prod.deb

RUN add-apt-repository universe && apt-get update && apt-get install -y apt-transport-https
RUN apt-get update && apt-get install -y dotnet-sdk-3.1 aspnetcore-runtime-3.1 dotnet-runtime-3.1