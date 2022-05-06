<div align="center">
<h1>
  <br>
  <img src="cover.png" alt="TempHelper" width="900">
  <br>
  TempHelper
  <br>
</h1>
</div>

<div align="center">

<h4 align="center">This script will quickly create everything you need to keep your dotfiles safe</a>.</h4>

<p align="center">
  <a href="#Why">Why</a> •
  <a href="#default-values">Default values</a> •
  <a href="#how-to-use">How to use</a> •
  <a href="#what-will-the-script-do">What will the script do</a> •
  <a href="#suported-platforms">Suported platforms</a> •
  <a href="#authors">Authors</a> •
  <a href="#license">License</a>
</p>
</div>
<br>

## Why
Lot of times i download some assets, zip files that i don't need for long period of time. Offten i use those files in the next 24-48 hours after i download them. Not just that sometimes i do quick backups of sam projects that are hosted on shared hosting. Till now i was using Downloads or Document folder for that. Over time i start to have lot of things with mixed priiorites that is hard to search and follow. Because of that i need some place that will follow what i need. 

## Default values

| Item    | Value |
| ----------- | ----------- |
| Folder location      | ~ ($HOME) |
| Folder name   | Temp        |
| Number of days   | 10        |
| Cron location   | crontab -e        |



## How to use

If you want **qick and easy** way to implement this **with default values** just use: 
```
bash <(curl -s https://gitlab.com/bruno-afk/temp-helper/-/raw/main/install.sh)
```

If you want to install the script **with your own custom values** use this command:
```
bash <(curl -s https://gitlab.com/bruno-afk/temp-helper/-/raw/main/install.sh) -c
```



## What will script do

Script will create folder on desired location (with desired name), and create cronjob that will delete files and folders older then 10 days (or some custom num of days you want).

1. Check OS
2. Create script temp folder inside /tmp for crontab backup
3. If you want to custom install script will get your custom folder location, custom name, and number of days after cron will delete files
4. Create folder/s if it's not there yet
5. Create cron record inside crontab -e
6. Delete script temp folder

## Suported platform

MacOS and Linux

## Authors

<a href="https://pavelja.me"><img src="https://pavelja.me/assets/images/paveljame.svg" alt="Paveljame" width="200"></a>

PAVELJAME - informatičke usluge

## License

MIT
