import sys
import subprocess
import schedule
from datetime import datetime, timedelta
import time


def execute_scripts():
    # Execute all scripts passed as args
    for i in range(1, len(sys.argv)):
        #    print(sys.argv[i])
        subprocess.call(["bash", sys.argv[i]])

# Schedule the script execution
schedule.every(3).days.at("03:00").do(execute_scripts)

while True:
    schedule.run_pending()
    time.sleep(1)
