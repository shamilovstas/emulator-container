FROM ubuntu:24.04


RUN apt upgrade && apt update -y
RUN apt install -y curl unzip adb openjdk-17-jre-headless
ENV ANDROID_HOME=/usr/local/android/sdk
RUN curl -Lo /tmp/androidsdk.zip https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip
RUN mkdir -p /usr/local/android/sdk/cmdline-tools/latest &&\
    unzip /tmp/androidsdk.zip -d /tmp && \
    mv /tmp/cmdline-tools/* $ANDROID_HOME/cmdline-tools/latest && \
    ln -s $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager /bin/sdkmanager && \
    yes | sdkmanager --install "emulator" "platform-tools" "platforms;android-35" "system-images;android-35;google_apis;x86_64" && \
    ln -s $ANDROID_HOME/cmdline-tools/latest/bin/avdmanager /bin/avdmanager && \
    ln -s $ANDROID_HOME/emulator/emulator /bin/emulator
RUN echo | avdmanager create avd --name testAvd --abi google_apis/x86_64 --package "system-images;android-35;google_apis;x86_64"
RUN apt install -y libx11-dev
CMD ["emulator", "-avd", "testAvd", "-no-window", "-no-metrics", "-no-snapshot", "-verbose"]

