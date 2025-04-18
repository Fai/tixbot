*** Settings ***
Library    SeleniumLibrary

*** Test Cases ***
เปิดเว็บไซต์ Google
    Open Browser    https://www.google.com    chrome
    Sleep    3s
    Close Browser
