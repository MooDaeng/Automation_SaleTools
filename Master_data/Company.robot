*** Settings ***
Resource            ../Keyword/Main.robot

*** Variables ***
${C_name}   TESTCOMPANY_
${C_code}   C

*** Keywords ***
Click Company    #Click เลือก Menu : Master data >> Distributor >> Company
    Click Element   xpath=//*[@id="menu"]/li[12]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[3]/a
    Scroll Element Into View   xpath=//*[@id="menu"]/li[12]/ul/li[3]/ul/li[3]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[3]/ul/li[3]/a
    ${gettext}  Get Text  xpath=//*[@id="mainContainer"]/div[1]/div/div/h3
    Should Be Equal As Strings   ${gettext}   Company

COM_001     #ตรวจสอบความถูกต้องของหน้าจอการค้นหาข้อมูล
    [Arguments]  ${INDEX}
    ${Gettext}  Get Text   xpath=//*[@id="collapse1"]/form/div/div[1]/b
    Should Be Equal As Strings   ${INDEX}   ${Gettext}

COM_002     #ค้นหาข้อมูลทั้งหมด กดปุ่ม Search
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text       xpath=//*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    ${ran_int1}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${Company_Code}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[${ran_int1}]/td[1]
    Set Global Variable  ${Company_Code}

COM_003    #ค้นหาข้อมูลจาก Company Code
    Input Text   id=COMPANYCODE   ${Company_Code}
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text      xpath=//*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    IF  ${entrie}[3] != 0
        ${RowGroupName}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[1]/td[1]
        Should Be Equal As Strings  ${Company_Code}  ${RowGroupName}  
        Log to Console   ${RowGroupName}  
    ELSE
        ${empty}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr/td
        Should Be Equal As Strings   ${empty}   No data available in table
    END
 
COM_004    #ตรวจสอบความถูกต้องของข้อมูลใน Data Grid
    [Arguments]  @{GridList}
    ${count}    Get Length     ${GridList}
    FOR   ${i}  IN RANGE   ${count}
        ${Grid}  Get Text  xpath=//*[@id="dtDetail"]/thead/tr/th[${i}+1]
        Should Be Equal As Strings  ${GridList}[${i}]  ${Grid}
        # Log to Console   ${Grid}
    END

COM_008    #กดปุ่ม Create New
    Click Element   xpath=//*[@id="Group2"]/div/div[1]/div/div[2]/a

COM_009    #ไม่กรอกข้อมูลใดๆ
    [Arguments]  @{RequireList}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

COM_010    #ไม่กรอกข้อมูล Company Code
    [Arguments]  @{RequireList}
    #Company Code
    ${RandomnumberPname}   Generate Random String   2   [NUMBERS]
    ${C_name}  Set Variable  ${C_name}${RandomnumberPname}
    Set Global Variable  ${C_name}
    Input Text   id=COMPANYNAME   ${C_name}
    #Default Tax Type
    ${TaxType}  Get Text       xpath=//*[@id="DEFAULTTAXTYPE"]
    Click Element   xpath=//*[contains(text(),'Include Vat')]
    #Default Currency
    ${Currency}  Get Text       xpath=//*[@id="DEFAULTCURRENCY"]
    Click Element   xpath=//*[contains(text(),'Thai Baht')]
    #Time Zone
    ${TimeZone}  Get Text       xpath=//*[@id="TimeZoneID"]
    Click Element   xpath=//*[contains(text(),'(UTC+07:00) Bangkok, Hanoi, Jakarta')]
    #Country
    ${Country}  Get Text       xpath=//*[@id="CountryName"]
    Click Element   xpath=//*[@id="CountryName"]/option[221]
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    #Company Code
    ${RandomnumberCcode}   Generate Random String   3   [NUMBERS]
    ${C_code}   Set Variable   ${C_code}${RandomnumberCcode}
    Set Global Variable   ${C_code}
    Input Text   id=COMPANYCODE   ${C_code}

COM_011    #ไม่กรอกข้อมูล Company Name
    [Arguments]  @{RequireList}
    Input Text   id=COMPANYNAME   ${SPACE}
    Press Keys   id=COMPANYNAME  BACK_SPACE
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    Input Text   id=COMPANYNAME   ${C_Name}

COM_012    #ไม่เลือกข้อมูล Default Tax Type
    [Arguments]   @{RequireList}
    ${TaxType}  Get Text       xpath=//*[@id="DEFAULTTAXTYPE"]
    Click Element   xpath=//*[@id="DEFAULTTAXTYPE"]/option[1]
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    ${TaxType}  Get Text       xpath=//*[@id="DEFAULTTAXTYPE"]
    Click Element   xpath=//*[contains(text(),'Include Vat')]

COM_013    #ไม่เลือกข้อมูล Default Currency
    [Arguments]   @{RequireList}
    ${Currency}  Get Text     xpath=//*[@id="DEFAULTCURRENCY"]
    Click Element   xpath=//*[@id="DEFAULTCURRENCY"]/option[1]
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    ${Currency}  Get Text       xpath=//*[@id="DEFAULTCURRENCY"]
    Click Element   xpath=//*[contains(text(),'Thai Baht')]

COM_014    #ไม่เลือกข้อมูล Time Zone
    [Arguments]   @{RequireList}
    ${TimeZone}  Get Text       xpath=//*[@id="TimeZoneID"]
    Click Element   xpath=//*[@id="TimeZoneID"]/option[1]
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    ${TimeZone}  Get Text       xpath=//*[@id="TimeZoneID"]
    Click Element   xpath=//*[contains(text(),'(UTC+07:00) Bangkok, Hanoi, Jakarta')]

COM_015    #ไม่เลือกข้อมูล Country
    [Arguments]   @{RequireList}
    ${Country}  Get Text       xpath=//*[@id="CountryName"]
    Click Element   xpath=//*[@id="CountryName"]/option[1]
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    ${Country}  Get Text       xpath=//*[@id="CountryName"]
    Click Element   xpath=//*[@id="CountryName"]/option[221]

COM_016    #กรอกข้อมูลให้ครบทุก Field
    [Arguments]   @{RequireList}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

COM_018    #ค้นหาข้อมูลที่ต้องการ Edit
    Input Text   id=COMPANYCODE   ${C_code}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//*[@id="form_${C_code}"]/button
    Switch Window   MAIN
    close Window
    Switch Window   Company - ST

COM_019    #แก้ไขข้อมูล โดยลบข้อมูล Company Name
    COM_011    Required!   Please enter "Company Name"   OK

COM_020    #แก้ไขข้อมูล โดยลบข้อมูล Default Tax Type
    COM_012    Required!   Please select "Default Tax Type"   OK

COM_021    #แก้ไขข้อมูล โดยลบข้อมูล Default Currency
    COM_013    Required!   Please select "Default Currency"   OK

COM_022    #แก้ไขข้อมูล โดยลบข้อมูล Time Zone
    COM_014    Required!   Please select "Time Zone"   OK

COM_023    #ไม่เลือกข้อมูล Country
    COM_015    Required!   Please select "Country"   OK

COM_024    #แก้ไขข้อมูล Company กดปุ่ม Save
    COM_016    Completed   Update completed !   OK

COM_025    #ค้นหาข้อมูล Company
    Input Text   id=COMPANYCODE   ${C_code}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//i[@class="fa fa-2x fa-remove"]

COM_026    #กดปุ่ม Cancel จาก Popup Confirmation Message
    [Arguments]  ${RequireList}
    ${message}   Handle Alert   action=DISMISS
    # Log to Console  ${message}
    Should Be Equal As Strings  ${RequireList}  ${message}

COM_027    #กดปุ่ม OK จาก Popup Confirmation Message
    [Arguments]  @{RequireList}
    Click Element    xpath=//i[@class="fa fa-2x fa-remove"]
    ${message}   Handle Alert
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

*** Test Cases ***
COM_001 Click เลือก Menu : Master data >> Distributor >> Company
    Log in
    Click Company
    COM_001    Company Code

COM_002 ค้นหาข้อมูลทั้งหมด กดปุ่ม Search
    COM_002

COM_003 ค้นหาข้อมูลโดยระบุเงื่อนไข Case: ค้นหาข้อมูลจาก Company Code
    COM_003

COM_004 ตรวจสอบความถูกต้องของข้อมูลใน Data Grid
    COM_004    Company Code   Company Name   Address   Telephone   Tax Number   Default Tax Type   Tax Rate   Default Currency   ***

COM_008 ตรวจสอบความถูกต้องของหน้าจอการเพิ่มข้อมูล กดปุ่ม Create New
    COM_008

COM_009 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูลใดๆ
    COM_009    Required!   Please enter "Company Code"   Please enter "Company Name"   Please select "Default Tax Type"   Please select "Default Currency"   Please select "Time Zone"   Please select "Country"   OK

COM_010 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Company Code
    COM_010    Required!   Please enter "Company Code"   OK

COM_011 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Company Name
    COM_011    Required!   Please enter "Company Name"   OK

COM_012 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่เลือกข้อมูล Default Tax Type
    COM_012    Required!   Please select "Default Tax Type"   OK

COM_013 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่เลือกข้อมูล Default Currency
    COM_013    Required!   Please select "Default Currency"   OK

COM_014 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่เลือกข้อมูล Time Zone
    COM_014    Required!   Please select "Time Zone"   OK

COM_015 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่เลือกข้อมูล Country
    COM_015    Required!   Please select "Country"   OK

COM_016 กรอกข้อมูลให้ครบทุก Field
    COM_016    Completed   Create completed !   OK

COM_018 ตรวจสอบความถูกต้องของหน้าจอการแก้ไขข้อมูล ค้นหาข้อมูลที่ต้องการ Edit
    COM_018

COM_019 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล Company Name
    COM_019

COM_020 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล Default Tax Type
    COM_020

COM_021 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล Default Currency
    COM_021

COM_022 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล Time Zone
    COM_022

COM_023 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล Country
    COM_023

COM_024 แก้ไขข้อมูล Company กดปุ่ม Save
    COM_024

COM_025 ลบข้อมูล Company ค้นหาข้อมูล Company
    COM_025

COM_026 ลบข้อมูล Company กดปุ่ม Cancel จาก Popup Confirmation Message
    COM_026    Confirm delete ?

COM_027 ลบข้อมูล Company กดปุ่ม OK จาก Popup Confirmation Message
    COM_027    Completed   Delete completed !   OK
    Close Browser
