# ImgDownloaderShell
Set of Shell scripts designed to interact with each other to automate the process of downloading images from Boorus using [gallery-dl](https://github.com/mikf/gallery-dl) and organizing them into folders

# Requirements
zenity
wget
All the requirements to run gallery-dl (python, glibc)

# Install and run
1) Clone
2) Run in the folder of the project:
```
chmod +x ./*
chmod +x ./updater/*
chmod +x ./downloaders/*
```
3) Configure
   In the tags files include the tags you want to use in each site separated by space and with a final space in the last one, like in the examples provided
4) './ImgDownloaderBash'
5) In the first run you'll have to update the gallery-dl version to download the executable.
After that, you will be prompted with a website selector to select from where do you want to download images.
6) The script will download all the images that were uploaded one week ago (by default) or the last time it was run (if it was less than a week ago).
Then all the images will be sorted in folders containing images from yesterday, today, and new images obtained in the last run.
The script will also check and delete old images that have more than one week and check images with incorrect date format and fix them.
7) Finally the script asks in a prompt window if you want to open the folder containing the downloaded images.
