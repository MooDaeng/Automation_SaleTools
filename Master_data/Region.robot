*** Settings ***
Resource                  ../Keyword/Main.robot

*** Variables ***
${R_code}   T0
${R_name}   TESTREGION_

*** Keywords ***
Click Region    #Click เลือก Menu : Master data >> Common >> Region
    Click Element   xpath=//*[@id="menu"]/li[12]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[2]/a
    Scroll Element Into View    xpath=//*[@id="menu"]/li[12]/ul/li[2]/ul/li[5]
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[2]/ul/li[5]
    ${gettext}  Get Text  xpath=//*[@id="mainContainer"]/div[1]/div/div/h3
    Should Be Equal As Strings   ${gettext}   Region

REG_001    #ตรวจสอบความถูกต้องของหน้าจอการค้นหาข้อมูล
    [Arguments]  ${INDEXs}
    ${Gettext}  Get Text   xpath=//*[@id="collapse1"]/form/div/div[1]/b
    Should Be Equal As Strings   ${INDEXs}   ${Gettext}

REG_002    #ค้นหาข้อมูลทั้งหมด กดปุ่ม Search
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text       xpath=//*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    ${ran_int1}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${Region_Code}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[${ran_int1}]/td[1]
    Set Global Variable  ${Region_Code}
    # Log to Console   ${Region_Code}

REG_003    #ค้นหาข้อมูลจาก Region Code
    Input Text   id=code   ${Region_Code}
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text      xpath=//*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    IF  ${entrie}[3] != 0
        ${RowGroupName}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[1]/td[1]
        Should Be Equal As Strings  ${Region_Code}  ${RowGroupName}
    ELSE    
        ${empty}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr/td
        Should Be Equal As Strings   ${empty}   No data available in table
    END

REG_004    #ตรวจสอบความถูกต้องของข้อมูลใน Data Grid
    [Arguments]  @{GridList}
    ${count}    Get Length     ${GridList}
    FOR   ${i}  IN RANGE   ${count}
        ${Grid}  Get Text  xpath=//*[@id="dtDetail"]/thead/tr/th[${i}+1]
        Should Be Equal As Strings  ${GridList}[${i}]  ${Grid}
    END

REG_008    #ตรวจสอบความถูกต้องของหน้าจอการเพิ่มข้อมูล กดปุ่ม Create New
    [Arguments]  @{GridList}
    Click Element   xpath=//*[@id="Group2"]/div/div[1]/div/div[2]/a
    ${count}    Get Length     ${GridList}
    FOR   ${i}  IN RANGE   ${count}
        ${Grid}  Get Text  xpath=//*[@id="collapse1"]/div/div[${i}+1]
        Should Be Equal As Strings  ${GridList}[${i}]  ${Grid}
    END

REG_009    #ไม่กรอกข้อมูลใดๆ
    [Arguments]  @{RequireList}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

REG_010    # ไม่กรอกข้อมูล Region Code
    [Arguments]  @{RequireList}
    ${RandomnumberRname}   Generate Random String   2   [NUMBERS]
    ${R_name}  Set Variable  ${R_name}${RandomnumberRname}
    Set Global Variable  ${R_name}
    Input Text   id=name   ${R_name}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    ${RandomnumberRcode}   Generate Random String   3   [NUMBERS]
    ${R_code}   Set Variable   ${R_code}${RandomnumberRcode}
    Set Global Variable   ${R_code}
    Input Text   id=code   ${R_code}

REG_011    #ไม่กรอกข้อมูล Region Name
    [Arguments]  @{RequireList}
    Input Text   id=name   ${SPACE}
    Press Keys   id=name  BACK_SPACE
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

REG_012    #กรอกข้อมูลให้ครบทุก Field
    [Arguments]  @{RequireList}
    Input Text   id=name   ${R_name}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

REG_014    #ค้นหาข้อมูลที่ต้องการ Edit
    Input Text   id=code   ${R_code}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//*[@id="form_${R_code}"]/button
    Switch Window   MAIN
    close Window
    Switch Window   Region - ST

REG_015    #แก้ไขข้อมูล โดยลบข้อมูล Region Name
    REG_011    Required!   Please enter "Region Name"   OK

REG_016    #.แก้ไขข้อมูล Field Region Name
    REG_012    Completed   Update completed !   OK

REG_017    #ค้นหาข้อมูล Region
    Input Text   id=code   ${R_code}
    Click Element   xpath=//*[@id="btnSearch"]
    
REG_018    #กดปุ่ม Cancel จาก Popup Confirmation Message
    [Arguments]  ${RequireList}
    Click Element   xpath=//i[@class="fa fa-2x fa-remove"]
    ${message}   Handle Alert   action=DISMISS
    # Log to Console  ${message}
    Should Be Equal As Strings  ${RequireList}  ${message}
    
REG_019    #กดปุ่ม OK จาก Popup Confirmation Message
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
REG_001 Click เลือก Menu : Master data >> Common >> Region
    Log in
    Click Region
    REG_001    Region Code

REG_002 ค้นหาข้อมูลทั้งหมด กดปุ่ม Search
    REG_002

REG_003 ค้นหาข้อมูลโดยระบุเงื่อนไข Case: ค้นหาข้อมูลจาก Region Code
    REG_003

REG_004 ตรวจสอบความถูกต้องของข้อมูลใน Data Grid กดปุ่ม Search
    REG_004    Region Code  Region Name  ***

# REG_005 - REG_007

REG_008 ตรวจสอบความถูกต้องของหน้าจอการเพิ่มข้อมูล กดปุ่ม Create New
    REG_008    Region Code  Region Name

REG_009 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูลใดๆ
    REG_009    Required!   Please enter "Region Code"   Please enter "Region Name"   OK

REG_010 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Region Code
    REG_010    Required!   Please enter "Region Code"   OK

REG_011 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Region Name
    REG_011    Required!   Please enter "Region Name"   OK

REG_012 กรอกข้อมูลให้ครบทุก Field
    REG_012    Completed   Create completed !   OK

# REG_013

REG_014 ตรวจสอบความถูกต้องของหน้าจอการแก้ไขข้อมูล ค้นหาข้อมูลที่ต้องการ Edit
    REG_014

REG_015 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล Region Name
    REG_015

REG_016 แก้ไขข้อมูล Region แก้ไขข้อมูล Field Region Name
    REG_016

REG_017 ลบข้อมูล Region ค้นหาข้อมูล Region
    REG_017

REG_018 ลบข้อมูล Region ค้นหาข้อมูล Region
    REG_018    Confirm delete ?

REG_019 ลบข้อมูล Region กดปุ่ม OK จาก Popup Confirmation Message
    REG_019    Completed   Delete completed !   OK
    Close Browser


