#!/bin/bash

# Get local directory to back up
echo "Please enter the path of the directory you want to backup:"
read -r SOURCE_DIRECTORY

# Get remote rclone name and directory
echo "Please enter the name of the configured rclone remote:"
read -r RCLONE_REMOTE
echo "Please enter the remote directory for backup (e.g., Backup):"
read -r REMOTE_DIRECTORY

# Get backup frequency
echo "Please choose the backup frequency:"
echo "1) Daily"
echo "2) Every three days"
echo "3) Weekly"
echo "4) Monthly"
read -r frequency_choice

case $frequency_choice in
1)
  backup_frequency="daily"
  cron_schedule="0 0 * * *"
  ;;
2)
  backup_frequency="every three days"
  cron_schedule="0 0 */3 * *"
  ;;
3)
  backup_frequency="weekly"
  cron_schedule="0 0 * * 0"
  ;;
4)
  backup_frequency="monthly"
  cron_schedule="0 0 1 * *"
  ;;
*)
  echo "Invalid choice. Exiting."
  exit 1
  ;;
esac

# Create the backup script
BACKUP_SCRIPT="${HOME}/backup_to_${RCLONE_REMOTE}.sh"
cat >"${BACKUP_SCRIPT}" <<EOL
#!/bin/bash
rclone sync "${SOURCE_DIRECTORY}" "${RCLONE_REMOTE}:${REMOTE_DIRECTORY}" --progress
EOL
chmod +x "${BACKUP_SCRIPT}"

# Schedule backup task
echo "Do you want to schedule the backup task? (yes/no)"
read -r schedule_answer

if [ "${schedule_answer,,}" = "yes" ]; then
  (
    crontab -l 2>/dev/null
    echo "${cron_schedule} ${BACKUP_SCRIPT}"
  ) | crontab -

  echo "Backup scheduled successfully for ${backup_frequency} frequency."
fi

# Run backup immediately
echo "Do you want to run the backup task immediately? (yes/no)"
read -r run_now_answer

if [ "${run_now_answer,,}" = "yes" ]; then
  "${BACKUP_SCRIPT}"
fi

# Display backup summary
echo "Backup configuration:"
echo "  Source directory: ${SOURCE_DIRECTORY}"
echo "  Remote: ${RCLONE_REMOTE}"
echo "  Remote directory: ${REMOTE_DIRECTORY}"
echo "  Backup script: ${BACKUP_SCRIPT}"
echo "  Frequency: ${backup_frequency}"
echo ""
echo "To disable the backup task, run 'crontab -r'"
