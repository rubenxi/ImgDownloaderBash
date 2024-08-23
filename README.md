# ImgDownloaderBash
Set of Shell scripts designed to interact with each other to automate the process of downloading images from Boorus using [gallery-dl](https://github.com/mikf/gallery-dl) and organizing them into folders

# Requirements
zenity

wget

curl

All the requirements to run gallery-dl 

# Install and run
1) Clone

2) Run in the folder of the project:
`chmod +x -R ./*`

3) In the tags files include the tags you want to use in each site separated by space and with a final space in the last one, like in the examples provided.

`naruto dragon_ball `

4) `./ImgDownloaderBash.sh`

5) In the first run you'll have to update the gallery-dl version to download the executable.

![Screenshot_20240823_163910](https://github.com/user-attachments/assets/6c037f58-8317-4e26-9599-cee501583d24)


6) After that, you will be prompted with a website selector to select from where do you want to download images.

![Screenshot_20240823_150915](https://github.com/user-attachments/assets/2737cfa6-74fa-41d2-b034-963488f957fd)

7) The script will download all the images that were uploaded one week ago (by default) or the last time it was run (if it was less than a week ago).

8) Then all the images will be sorted in folders containing images from yesterday, today, and new images obtained in the last run. The script will also check and delete old images that have more than one week and check images with incorrect date format and fix them.

![Screenshot_20240823_164201](https://github.com/user-attachments/assets/0ec7c9d2-dcd6-491e-8d36-eebda786088c)


9) Finally the script asks in a prompt window if you want to open the folder containing the downloaded images.
    
![Screenshot_20240823_164042](https://github.com/user-attachments/assets/206132f4-c519-43b0-b8fc-501f78908d53)

# Supported sites
zerochan.net

safebooru.org

konachan.net
