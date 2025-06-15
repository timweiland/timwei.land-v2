#!/bin/bash

# Check if icon.jpg exists
if [ ! -f "icon.jpg" ]; then
    echo "Error: icon.jpg not found!"
    exit 1
fi

# Generate different sized icons
convert icon.jpg -resize 32x32 icon-32.jpg
convert icon.jpg -resize 192x192 icon-192.jpg
convert icon.jpg -resize 512x512 icon-512.jpg

echo "Icons generated successfully!"
