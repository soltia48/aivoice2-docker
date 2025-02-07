docker run --rm -it \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    -e PULSE_COOKIE=/tmp/pulse/cookie \
    -e PULSE_SERVER=unix:/tmp/pulse/native \
    -e DISPLAY \
    -e XMODIFIERS \
    -e GTK_IM_MODULE \
    -e QT_IM_MODULE \
    -v /run/user/1000/pulse/native:/tmp/pulse/native \
    -v ~/.config/pulse/cookie:/tmp/pulse/cookie:ro \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    aivoice2
