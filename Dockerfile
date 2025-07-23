FROM alpine:latest

# Metadata
LABEL org.opencontainers.image.source="https://github.com/mishka81/alpine-docker-mpd"
LABEL org.opencontainers.image.description="Alpine Linux based Music Player Daemon (MPD)"
LABEL org.opencontainers.image.licenses="MIT"

# Install MPD and required dependencies
RUN apk add --no-cache mpd lame flac vorbis-tools faac ffmpeg curl

# Create required directories with proper permissions
RUN mkdir -p \
    /var/lib/mpd/music \
    /var/lib/mpd/playlists \
    /var/log/mpd \
    /run/mpd && \
    chown -R mpd:audio /var/lib/mpd /var/log/mpd /run/mpd

# Copy MPD configuration
COPY ./mpd.conf /etc/mpd.conf
RUN chown mpd:audio /etc/mpd.conf

# Switch to MPD user
USER mpd

# Expose MPD port and HTTP streaming port
EXPOSE 6600 8000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD nc -z localhost 6600 || exit 1

# Set working directory
WORKDIR /var/lib/mpd

# Start MPD
ENTRYPOINT ["mpd", "--no-daemon"]
CMD ["--stdout", "--stderr"]