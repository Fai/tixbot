*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${URL}            https://www.thaiticketmajor.com/
${BROWSER}        Chrome
${USERNAME}       your_username
${PASSWORD}       your_password
${CONCERT_NAME}   BLUSH BLOSSOM FAN FEST
${CONCERT_DATE}   28 มิถุนายน 2568
${SEAT_SECTION}   โซนที่นั่งที่ต้องการ
${SEAT_NUMBER}    หมายเลขที่นั่งที่ต้องการ
${CARD_NUMBER}    4111111111111111
${EXPIRY_DATE}    12/25
${CVV}            123

*** Test Cases ***
ซื้อบัตรคอนเสิร์ต BLUSH BLOSSOM FAN FEST
    เปิดเว็บไซต์ ThaiTicketMajor
    ล็อกอินเข้าสู่ระบบ
    ค้นหาและเลือกคอนเสิร์ต
    เลือกวันที่แสดง
    เลือกที่นั่ง
    ดำเนินการชำระเงิน
    ยืนยันการซื้อ
    ปิดเบราว์เซอร์

*** Keywords ***
เปิดเว็บไซต์ ThaiTicketMajor
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

ล็อกอินเข้าสู่ระบบ
    Click Element    //a[text()='เข้าสู่ระบบ/สมัครสมาชิก']
    Input Text       //input[@id='username']    ${USERNAME}
    Input Text       //input[@id='password']    ${PASSWORD}
    Click Button     //button[@id='login-button']

ค้นหาและเลือกคอนเสิร์ต
    Input Text       //input[@id='search-box']    ${CONCERT_NAME}
    Click Button     //button[@id='search-button']
    Click Link       //a[contains(text(), '${CONCERT_NAME}')]

เลือกวันที่แสดง
    Click Element    //button[contains(text(), '${CONCERT_DATE}')]

เลือกที่นั่ง
    # ขั้นตอนการเลือกโซนและที่นั่ง
    Click Element    //div[@data-section='${SEAT_SECTION}']
    Click Element    //div[@data-seat='${SEAT_NUMBER}']
    Click Button     //button[@id='confirm-seats']

ดำเนินการชำระเงิน
    # เลือกวิธีการชำระเงินและกรอกข้อมูลบัตรเครดิต
    Select From List By Value    //select[@id='payment-method']    credit_card
    Input Text       //input[@id='card-number']    ${CARD_NUMBER}
    Input Text       //input[@id='expiry-date']    ${EXPIRY_DATE}
    Input Text       //input[@id='cvv']            ${CVV}
    Click Button     //button[@id='pay-button']

ยืนยันการซื้อ
    Page Should Contain    ขอบคุณสำหรับการสั่งซื้อ
    # ตรวจสอบว่ามีข้อความยืนยันการสั่งซื้อปรากฏขึ้น

ปิดเบราว์เซอร์
    Close Browser