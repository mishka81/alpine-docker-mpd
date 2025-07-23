# alpine-docker-mpd
An Alpine-based Music Player Daemon Docker image with HTTP streaming support.

## Features
- Lightweight Alpine Linux base
- MPD with HTTP streaming on port 8000
- Support for multiple audio formats (MP3, FLAC, OGG, AAC)
- Auto-updating music database

## Installation

### Using Docker Compose (Recommended)

1. Create environment variables file `.env`:
```bash
MUSIC_FOLDER=/path/to/your/music
PLAYLISTS_FOLDER=/path/to/your/playlists
```

2. Start the container:
```bash
docker-compose up -d
```

### Using Docker directly

```bash
docker run -d \
  --name mpd \
  -p 6600:6600 \
  -p 8000:8000 \
  -v /path/to/your/music:/var/lib/mpd/music:ro \
  -v /path/to/your/playlists:/var/lib/mpd/playlists \
  ghcr.io/mishka81/alpine-docker-mpd:latest
```

### Pre-built Images

Images are automatically built and published to GitHub Container Registry:
- `ghcr.io/mishka81/alpine-docker-mpd:latest` - Latest stable version
- `ghcr.io/mishka81/alpine-docker-mpd:main` - Latest development version
- `ghcr.io/mishka81/alpine-docker-mpd:v1.0.0` - Specific version tags

Images are available for both `linux/amd64` and `linux/arm64` architectures.

3. Access MPD:
   - Control interface: `<docker-host>:6600`
   - HTTP stream: `http://<docker-host>:8000`
   
   Replace `<docker-host>` with your Docker host IP address (e.g., `localhost` for local Docker, or your server's IP for remote Docker).

## Configuration

The default configuration provides:
- Music directory: `/var/lib/mpd/music` (mounted from `MUSIC_FOLDER`)
- Playlists: `/var/lib/mpd/playlists` (mounted from `PLAYLISTS_FOLDER`)
- HTTP streaming at 192kbps MP3

### Sound Card Access

To enable direct sound card output (instead of HTTP streaming only), uncomment the devices section in `docker-compose.yml`:

```yaml
devices:
  - /dev/snd
```

This grants the container access to your host's sound card for local audio playback.

### Custom Configuration

To customize MPD settings, edit `mpd.conf` before building the image.

## Usage with MPD clients

Connect any MPD client to `<docker-host>:6600`:
- **ncmpcpp** (terminal): `ncmpcpp -h <docker-host>`
- **Cantata** (GUI): Add server at `<docker-host>:6600`
- **M.A.L.P.** (Android): Add profile with host `<docker-host>:6600`
