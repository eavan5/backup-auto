# Rclone Automatic Backup Script

This repository contains a script for automating the backup of a local folder to a remote storage service using Rclone. The script allows you to customize the backup source directory, the Rclone remote name, and the backup frequency.

## Features

1. Customize the source directory to be backed up.
2. Choose the Rclone remote name to back up to.
3. Schedule automatic backups with a choice of daily, every three days, weekly, or monthly.
4. Option to run the backup script immediately upon configuration.
5. Upon creating the new backup script, it returns the scheduled backup time, the local and remote directories, and instructions on how to disable the backup.

## Requirements

- [Rclone](https://rclone.org/) installed and configured with the remote storage service you want to use.

## How to use

1. Make the script executable:

```bash
chmod +x rclone_backup.sh
```

2. Run the script:

```bash
./rclone_backup.sh
```

3. Follow the prompts to configure the backup settings.

## Support

If you encounter any issues, please open an issue on the GitHub repository, and we will address it as soon as possible.