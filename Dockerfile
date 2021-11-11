FROM ubuntu:focal

RUN apt-get -q update &&\
    apt-get -yq install --no-install-recommends gnupg curl ca-certificates &&\
    # add zulu-jdk to the 
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 &&\
    curl -O https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-3_all.deb &&\
    apt-get -y  install ./zulu-repo_1.0.0-3_all.deb &&\
    # update the package sources 
    # install Azul Zulu JDK 11
    apt-get update &&\
    apt-get -y --no-install-recommends install zulu11-jdk unzip \
               python3-pip wget git rsync ccache make patch &&\
    #Install QT
    python3 -m pip install aqtinstall &&\
    python3 -m aqt install --outputdir /opt 5.15.2 linux android -m qtcharts qtnetworkauth &&\
    #Download Additional stuff that is not in a repo
    wget -q https://dl.google.com/android/repository/android-ndk-r20b-linux-x86_64.zip &&\
    wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip &&\
    wget -q https://raw.githubusercontent.com/mozilla-mobile/mozilla-vpn-client/main/requirements.txt &&\
    pip install -r requirements.txt &&\
    unzip commandlinetools-linux-7583922_latest.zip -d /opt &&\
    unzip android-ndk-r20b-linux-x86_64.zip -d /opt/NDK/ &&\
    echo y | /opt/cmdline-tools/bin/sdkmanager --sdk_root=/opt/android/sdk --install "platforms;android-30" &&\
    # Cleanup
    rm -rf /opt/cmdline-tools &&\
    rm commandlinetools-linux-7583922_latest.zip &&\
    rm android-ndk-r20b-linux-x86_64.zip &&\
    rm zulu-repo_1.0.0-3_all.deb &&\ 
    rm -rf /var/lib/apt/lists/* &&\
    mkdir /opt/ccache




ENV QTPATH=/opt/5.15.2/
ENV ANDROID_SDK_ROOT="/opt/android/sdk"
ENV ANDROID_NDK_ROOT=/opt/NDK/android-ndk-r20b
ENV PATH="/opt/5.15.2/android/bin:/opt/cmdline-tools/bin:${PATH}"
ENV CCACHE_CONFIGPATH ="/ccache.conf"
ENV XDG_CACHE_HOME ="/opt/"

VOLUME [ "/opt/ccache" ]

COPY ./ccache.conf /ccache.conf
COPY ./docker_compile.sh /docker-entrpoint.sh
RUN chmod +x /docker-entrpoint.sh
ENTRYPOINT ["/docker-entrpoint.sh"]