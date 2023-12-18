# Backup Types

## FULL
Backs up the entire database 
### Schedule recommendation:
Weekly or Daily

## Differential
Backs up database changes since the last full backup was performed.
### Schedule recommendation:
Daily


## Log
Backs up the transaction log; in addition to enabling point-in-time restores, transaction log backups keep your log files reasonable in size.
### Schedule recommendation:
At least hourly
