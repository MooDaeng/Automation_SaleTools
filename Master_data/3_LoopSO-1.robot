*** Settings ***
Library                   Selenium2Library
Library                   String


*** Variables ***
${url}        http://122.155.162.24/st_swc/
${browser}    Chrome
${username}   adminpond
${password}   1234
${DC}   BPD


*** Test Cases ***
Login Salestool เข้าสู่ระบบ salestool และ เมนู ขายสั่ง
    Login
    FOR  ${i}  IN RANGE   0  50
    SO_000
    SO_001      ${DC}
    SO_002    
    SO_003
    SO_004
    #SO_005
    SO_006
    END

*** Keywords ***
Login
    Open Browser   ${url}   ${browser}
    Maximize Browser Window
    Set Selenium Speed   0.3
    Wait Until Element Is Visible   id=Username   timeout=20s
    Input Text   id=Username   ${username}
    Wait Until Element Is Visible   id=Password   timeout=20s
    Input Password   id=Password   ${password}
    Click Button  xpath=//*[@id="loginForm1"]/div[3]/div/button
    go to       ${url}ApproveNew/salesorder
SO_000
    Click Element   xpath=//*[@id="btnCreates"]
SO_001
    [Arguments]    ${DC} 
    Click Element   xpath=/html/body/div[2]/div/section/div/div[2]/form/div[1]/div/div/div[2]/div[1]/div/span/span[1]/span/span[1]
    input text      xpath=/html/body/span/span/span[1]/input    ${DC} 
    Click Element   xpath=/html/body/span/span/span[2]/ul/li

SO_002   #เลือก Customer
    Click Element   xpath=//*[@id="btnPopupCustomer"]
    # เลือก Customer Type
    Click Element      xpath=//*[@id="select2-ddlPopupCustomerType-container"]
    input text      xpath=/html/body/span/span/span[1]/input        D1
    Click Element   xpath=//*[@id="select2-ddlPopupCustomerType-results"]/li
    # เลือกลูกค้าจากข้อมูลที่เจอ
    Click Element   xpath=//*[@id="btnPopupCustomerSearch"]
    sleep   3s
    ${entries}     Get Text       xpath=//*[@id="dtCustomer_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    #${ran_int1}    Evaluate    random.randint(1, ${entrie}[3])    random ใช้สุ่มจากจำนวนที่แสดง
    ${ran_int1}    Evaluate    random.randint(1, 3)    random
    ${Code}  Get Text  xpath=//*[@id="dtCustomer"]/tbody/tr[${ran_int1}]/td[1] 
    Set Global Variable  ${Code}
    # log to console  ${Code}
    Set Global Variable  ${entrie} 
    input text      xpath=//*[@id="txtPopupCustomer"]         ${Code}
    Click Element   xpath=//*[@id="btnPopupCustomerSearch"]
    sleep   2s
    ${a}   Get Text   xpath=//*[@id="dtCustomer"]/tbody
    @{splittext}   Split String   ${a}  ${SPACE}
    # Log to Console  ${splittext}
    Click Element   xpath=//a[contains(text(),'${splittext}[0]')]     

SO_003       #ระบุสินค้าขาย
    FOR  ${i}  IN RANGE   0  2
    Click Button   xpath=//*[@id="Group4"]/div/div[1]/div/div[2]/button
    Click element   xpath=//*[@id="modal-product"]/div/div/div[2]/div[2]/div[3]/button[2]
    click element   xpath=//*[@id="btnPopupProductSearch"]
    Scroll Element Into View      xpath=//*[@id="dtPopupProduct_info"]
    ${entries}     Get Text       xpath=//*[@id="dtPopupProduct_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    Log to Console  ${entrie}
    Log to Console  ${entrie}[3]
    ${ran_int1}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${P_Code}  Get Text  xpath=//*[@id="dtPopupProduct"]/tbody/tr[${ran_int1}]/td[1] 
    Set Global Variable  ${P_Code}
    log to console  ${P_Code}
    Set Global Variable  ${entrie}
    input text      xpath=//*[@id="txtPopupProduct"]    ${P_Code}
    Click Element   xpath=//*[@id="btnPopupProductSearch"]
    # @{numbers}      Create List    12
    # ${ran_num1}      Evaluate    random.choice(${numbers})   random
    # log to console      ${ran_num1}  
    Wait For Condition          return document.readyState=="complete"
    ${num_qty}      get Text    xpath=//*[@id="dtPopupProduct"]/tbody/tr[1]/td[12]
    ${count}    Get Length      ${num_qty}
    log to console       ${count}
        IF  '${count}' == '0'
             @{numbers1}      Create List    10   11
             ${ran_num1}      Evaluate    random.choice(${numbers1})   random
             ${num_qty}      get Text    xpath=//*[@id="dtPopupProduct"]/tbody/tr[1]/td[${ran_num1}]
        END    
    ${ran_qty}      Evaluate    random.randint(0, ${num_qty})    random        
    log to console     ${ran_qty}
    @{numbers2}      Create List    4   6
    ${ran_num2}      Evaluate    random.choice(${numbers2})   random
    log to console      ${ran_num2}
    input text      xpath=//*[@id="dtPopupProduct"]/tbody/tr/td[${ran_num2}]/input      5
    Click element   xpath=//*[@id="btnProductConfirm"]
    sleep       3s
    END
SO_004
    Click Element   xpath=//*[@id="Group4"]/div/div[3]/div/div/button[2]
    sleep   4s
    Click element  xpath=//*[@id="dialogPromotionConfirm"]
    Click element  xpath=//*[@id="dialogPromotionDetailConfirm"]
     sleep  3s
    # Click Element   xpath=/html/body/div[3]/div/div[3]/button[1]    
SO_005
    ${table}    Get Element Count       xpath=/html/body/div[2]/div/section/div/div[2]/form/div[2]/div/div/div[2]/div[1]/div/div/div/table/tbody/tr
    log to console  NUM_TB ${table}
    ${table2}    Convert To Number    ${table}
    ${total}    set variable    ${0}

    FOR    ${num}       IN RANGE    1      ${table2}+1
    ${price}      Get Text        xpath=/html/body/div[2]/div/section/div/div[2]/form/div[2]/div/div/div[2]/div[1]/div/div/div/table/tbody/tr[${num}]/td[13]
    ${price2}     Remove String        ${price}       ,
    ${price3}     Convert To Number    ${price2}
    log to console   ${price3}
    ${total}   set variable    ${total + ${price3}}
    log to console  Total ${total}
    END

    ${vat}     set variable    ${total *7}
    ${vat2}     set variable    ${vat /100}
    ${vat2}   Evaluate  "%.2f" % ${vat2}
    log to console  Vat ${vat2}
    ${g_total}  set variable   ${total + ${vat2}}
    log to console  IN VAT ${g_total}

    ${Grand Total}    Get Text       xpath=/html/body/div[2]/div/section/div/div[2]/form/div[2]/div/div/div[2]/div[2]/div/div[2]/div[4]/div[2]/label[2]
    ${Grand Total}     Remove String        ${Grand Total}       ,
    ${Grand Total}    Convert To Number     ${Grand Total}
    log to console      ${Grand Total}
    Should Be Equal     ${Grand Total}  ${g_total}

    [Return]    ${total}    


SO_006
    click Element   xpath=//*[@id="btnSubmit"]
    sleep   3s
    Click Element   xpath=//*[@id="swal2-content"]/a[1]