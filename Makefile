SCRIPT_PATH := 
LOG_PATH := 

define CRON_JOB
30 22 * * 1-5 $(SCRIPT_PATH) >> $(LOG_PATH) 2>&1
endef

chmod-script:
	@echo "The script is given permission to run..."
	@chmod +x $(SCRIPT_PATH)

install: chmod-script
	@echo "Setting up a cron job..."
	@echo "$(CRON_JOB)" | crontab -

list:
	@echo "Available Cron Jobs:"
	@crontab -l

remove:
	@echo "Removing cron job..."
	@crontab -r