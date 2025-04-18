*** Settings ***
Library    SeleniumLibrary
Library    JSONLibrary

*** Variables ***
${URL_CONCERT}    https://www.thaiticketmajor.com/concert/blush-blossom-fan-fest.html
${BROWSER}        Chrome
${COOKIE_FILE}    cookies.json
${CONCERT_DATE}   29 มิถุนายน 2568
${PRICE_ZONE}     7500
${SEAT_NUMBER}    A1
${CARD_NUMBER}    4111111111111111
${EXPIRY_DATE}    12/25
${CVV}            123

*** Test Cases ***
Load Cookies And Purchase Ticket
    [Documentation]    โหลดคุกกี้ แล้วกดซื้อบัตรตามกำหนด
    Open Browser    ${URL_CONCERT}    ${BROWSER}
    Maximize Browser Window

    # --- โหลดคุกกี้จากไฟล์ แล้ว inject ---
    ${cookies}=    Load JSON From File    ${COOKIE_FILE}
    FOR    ${cookie}    IN    @{cookies}
        Add Cookie    ${cookie}
    END
    Reload Page
    Wait Until Page Contains Element    //button[contains(@class,'btn-purchase')]    timeout=15s

    # --- กดซื้อบัตรและเลือกวันที่ ---
    Click Button    //button[contains(@class,'btn-purchase')]
    Wait Until Element Is Visible      //li[contains(@class,'performances__date')]    timeout=10s
    Click Element    //li[contains(@class,'performances__date')]//button[normalize-space()='${CONCERT_DATE}']

    # --- เลือกแผนผังที่นั่ง (iframe ถ้ามี) ---
    Wait Until Element Is Visible      //iframe[contains(@src,'SeatMap')]    timeout=15s
    Select Frame    //iframe[contains(@src,'SeatMap')]
    Wait Until Element Is Visible      //g[@data-price='${PRICE_ZONE}']    timeout=10s
    Click Element    //g[@data-price='${PRICE_ZONE}']
    Wait Until Element Is Visible      //g[@data-seat-number='${SEAT_NUMBER}']    timeout=10s
    Click Element    //g[@data-seat-number='${SEAT_NUMBER}']
    Unselect Frame
    Click Button     //button[@id='btnConfirmSeat']

    # --- ชำระเงิน ---
    Wait Until Element Is Visible      //select[@id='payment-method']    timeout=10s
    Select From List By Value          //select[@id='payment-method']    credit_card
    Input Text       //input[@id='card-number']    ${CARD_NUMBER}
    Input Text       //input[@id='expiry-date']    ${EXPIRY_DATE}
    Input Text       //input[@id='cvv']            ${CVV}
    Click Button     //button[@id='pay-button']

    # --- ยืนยันการซื้อ ---
    Wait Until Page Contains            ขอบคุณสำหรับการสั่งซื้อ    timeout=20s
    [Teardown]    Close Browser
