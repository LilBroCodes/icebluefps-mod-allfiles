#!/bin/bash

# Source directory where .jar files are located
source_directory="D:/Projects/Other/IceBlueFPS/jar"

# Destination directory where you want to copy the latest .jar file
destination_directory="C:/Users/scrap/Desktop/Temp"

# Find the latest .jar file based on modification time
latest_jar=$(ls -t "$source_directory"/**/*.jar | head -n 1)

if [ -n "$latest_jar" ]; then
  # Extract modification time in seconds since epoch
  mod_time=$(stat -c %Y "$latest_jar")

  # Loop through all .jar files to find the latest one
  for jar_file in "$source_directory"/**/*.jar; do
    current_mod_time=$(stat -c %Y "$jar_file")
    if [ $current_mod_time -ge $mod_time ]; then
      latest_jar="$jar_file"
      mod_time=$current_mod_time
    fi
  done

  # Delete all .jar files starting with "icebluefps" in the destination directory
  rm -f "$destination_directory"/icebluefps*.jar

  # Copy the latest .jar file to the destination directory
  cp "$latest_jar" "$destination_directory"
  echo "Latest .jar file copied to $destination_directory"
else
  echo "No .jar files found in $source_directory"
fi
