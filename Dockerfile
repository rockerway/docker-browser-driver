FROM alpine

ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

COPY geckodriver-v0.11.1-linux64.tar.gz geckodriver-v0.11.1-linux64.tar.gz

RUN apk update && \
       apk add sudo unzip tar libexif udev \
       chromium chromium-chromedriver \
       firefox-esr dbus-x11 ttf-freefont xvfb \
       nodejs && \
       tar -zxvf geckodriver-v0.11.1-linux64.tar.gz && \
       rm geckodriver-v0.11.1-linux64.tar.gz && \
       mv ./geckodriver /usr/local/bin/ && \
       chmod a+x /usr/local/bin/geckodriver && \
       rm -rf /var/cache/apk/*
RUN chmod 640 /etc/sudoers && \
       printf "tester\ntester\n" | adduser tester && \
       echo "tester ALL=(ALL) ALL" >> /etc/sudoers

USER tester
WORKDIR /home/tester/
RUN mkdir app
COPY startX startX
COPY test test

CMD ["sh"]
