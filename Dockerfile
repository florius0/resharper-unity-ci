FROM mcr.microsoft.com/dotnet/sdk:3.1-focal

RUN apt-get update \
    && apt-get -y install python3-pip \
    && apt-get -y install unzip \
    && pip3 install rich

RUN curl -sf -o resharper-cli.zip -L "https://download.jetbrains.com/resharper/dotUltimate.2021.1.4/JetBrains.ReSharper.CommandLineTools.2021.1.4.zip" \
    && mkdir -p /resharper \
    && unzip resharper-cli.zip -d /resharper \
    && rm resharper-cli.zip \
    && chmod -R +x /resharper

RUN curl -sf -o JetBrains.Unity.nupkg -L "https://github.com/JetBrains/resharper-unity/releases/download/net211-rtm-2021.1.2/JetBrains.Unity.2021.1.2.127.nupkg" \
    && mv JetBrains.Unity.nupkg /resharper/JetBrains.Unity.nupkg

COPY lib lib

ENTRYPOINT ["./lib/main.py"]
