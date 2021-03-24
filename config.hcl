target "release" {
  context = "./"
  dockerfile = "Dockerfile"
  platforms = [
    "linux/amd64",
    "linux/arm64",
    "linux/arm/v7",
    "linux/arm/v6",
    "linux/386",
    "linux/mips64le"
  ]
  tags = [
    "mguaylam/usecallmanager:latest"
  ]
}