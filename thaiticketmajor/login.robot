*** Settings ***
Library    SeleniumLibrary
Library    JSONLibrary    # ต้องติดตั้ง: pip install robotframework-jsonlibrary

*** Variables ***
${URL_LOGIN}    https://www.thaiticketmajor.com/
${BROWSER}      Chrome
${USERNAME}     your_username
${PASSWORD}     your_password
${COOKIE_FILE}  cookies.json

*** Test Cases ***
Login And Save Cookies
    [Documentation]    ล็อกอินแล้วเก็บคุกกี้ออกมา
    Open Browser    ${URL_LOGIN}    ${BROWSER}
    Maximize Browser Window

    # --- ขั้นตอนล็อกอิน ---
    Wait Until Element Is Visible    //a[text()='เข้าสู่ระบบ/สมัครสมาชิก']    timeout=15s
    Click Element    //a[text()='เข้าสู่ระบบ/สมัครสมาชิก']
    Wait Until Element Is Visible    //input[@id='username']    timeout=10s
    Input Text       //input[@id='username']    ${USERNAME}
    Input Text       //input[@id='password']    ${PASSWORD}
    Click Button     //button[@id='login-button']
    Wait Until Page Contains    ยินดีต้อนรับ    timeout=15s

    # --- ดึงคุกกี้แล้วเซฟลงไฟล์ ---
    ${cookies}=    Get Cookies
    Log    Saved cookies: ${cookies}
    Save JSON To File    ${cookies}    ${COOKIE_FILE}
    [Teardown]    Close Browser
