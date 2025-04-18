# tixbot

## Instruction

1. ติดตั้งโปรแกรม

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Python
brew install python

# Verify python
python3 --version
pip3 --version

# Create a new virtual environment
python -m venv .venv

# Activate the virtual environment
# On macOS/Linux:
source .venv/bin/activate

# Install the required packages
pip3 install robotframework
pip3 install robotframework-seleniumlibrary
pip3 install robotframework-jsonlibrary
pip3 install robotframework-requests

# Install Chrome Driver
brew install --cask chromedriver
```

หรือดาวโหลด Chrome Driver เองผ่านเวบ

[Download Chrome Driver](https://developer.chrome.com/docs/chromedriver/downloads)
```sh
mv chromedriver /usr/local/bin/
chmod +x /usr/local/bin/chromedriver
```

2. รัน robot ตามด้วยชื่อไฟล์ที่ต้องการทดสอบ ใน terminal ตามตัวอย่าง
```sh
robot test.robot
```
จากนั้นโปรแกรมจะเปิด Chrome ขึ้นมาทำตามคำสั่งเอง และแสดงผลการทำงาน พร้อมสร้าง report แต่ถ้าไม่ผ่าน จะปิดตัวเอง ตามตัวอย่าง
```sh
==============================================================================
Test                                                                          
==============================================================================
เปิดเว็บไซต์ Google                                                   | PASS |   
------------------------------------------------------------------------------
Test                                                                  | PASS |
1 test, 1 passed, 0 failed
==============================================================================
```
