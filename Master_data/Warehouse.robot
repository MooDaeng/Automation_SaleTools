*** Settings ***
Resource            ../Keyword/Main.robot

*** Variables ***
${WH_ID}       ABCD_
${WH_Name}     TEST_WAREHOUSE_

*** Keywords ***
Click Warehouse
    Click Element   xpath=//*[@id="menu"]/li[12]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[3]/a
    Scroll Element Into View   xpath=//*[@id="menu"]/li[12]/ul/li[3]/ul/li[4]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[3]/ul/li[4]/a
    ${gettext}  Get Text  xpath=//*[@id="mainContainer"]/div[1]/div/div/h3
    Should Be Equal As Strings   ${gettext}   Warehouse

WH_001    #ตรวจสอบความถูกต้องของหน้าจอการค้นหาข้อมูล
    [Arguments]  @{INDEX}
    ${count}  Get Length  ${INDEX}
    FOR  ${i}   IN RANGE   ${count}-1
         ${Gettext}  Get Text   xpath=//*[@id="collapse1"]/form/div[1]/div[${i}+1]/b
         Should Be Equal As Strings   ${INDEX}[${i}]   ${Gettext}
    END

WH_002    #กดปุ่ม Search
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text       xpath=//*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    ${ran_int1}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${ran_int2}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${Warehouse_ID}  Get Text   xpath=//*[@id="dtDetail"]/tbody/tr[${ran_int1}]/td[1]
    ${Warehouse_name}  Get Text   xpath=//*[@id="dtDetail"]/tbody/tr[${ran_int2}]/td[2]
    Log to Console  ${ran_int2}
    Set Global Variable  ${Warehouse_ID}
    Set Global Variable  ${Warehouse_name}

WH_003    #Case: ค้นหาข้อมูลจาก Company 
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[1]/span/span[1]/span
    ${GroupName}  Get Text       xpath=//*[@id="select2-COMPANYCODE-results"]
    @{values}   Split String   ${GroupName}  \n
    ${count}  Get Length  ${values}
    ${ran_int}    Evaluate    random.randint(1, ${count}-1)    random
    Click Element   xpath=//li[contains(text(),'${values}[${ran_int}]')]
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text      xpath= //*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    FOR   ${i}   IN RANGE   ${entrie}[3]
        ${RowGroupName}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[${i}+1]/td[4]
        Should Be Equal As Strings  ${values}[${ran_int}]  ${RowGroupName}
    END
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[1]/span/span[1]/span
    Click Element   xpath=//*[@id="select2-COMPANYCODE-results"]/li[1]

WH_004    #Case: ค้นหาข้อมูลจาก Warehouse ID
    Input Text   xpath=//*[@id="WAREHOUSEID"]   ${Warehouse_ID}
    Click Element   xpath=//*[@id="btnSearch"]
    ${CheckWH_ID}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[1]/td[1]
    Should Be Equal As Strings  ${CheckWH_ID}  ${Warehouse_ID}
    Input Text   xpath=//*[@id="WAREHOUSEID"]   ${SPACE}
    Press Keys   xpath=//*[@id="WAREHOUSEID"]   BACK_SPACE
    
WH_005    #Case: ค้นหาข้อมูลจาก Warehouse Name
    Input Text   xpath=//*[@id="WAREHOUSENAME"]   ${Warehouse_name}
    Click Element   xpath=//*[@id="btnSearch"]
    ${CheckWH_name}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[1]/td[2]
    Should Be Equal As Strings  ${CheckWH_Name}  ${Warehouse_name}
    Input Text   xpath=//*[@id="WAREHOUSENAME"]   ${SPACE}
    Press Keys   xpath=//*[@id="WAREHOUSENAME"]   BACK_SPACE

WH_006    #Case: ค้นหาข้อมูลจาก Type
     Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[4]/span/span[1]/span
    ${GroupName}  Get Text       xpath=//*[@id="select2-TYPE-results"]
    @{values}   Split String   ${GroupName}  \n
    Log to Console  ${values}
    ${count}  Get Length  ${values}
    ${ran_int}    Evaluate    random.randint(1, ${count}-1)    random
    Log to Console  ${ran_int}
    Click Element   xpath=//li[contains(text(),'${values}[${ran_int}]')]  #คลิกตำแหน่งที่ 4
    # ${status}   Get Text   xpath=//*[@id="select2-TYPE-container"]
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text      xpath= //*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    FOR   ${i}   IN RANGE   ${entrie}[3]
        ${RowGroupName}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[${i}+1]/td[3]
        Should Be Equal As Strings  ${values}[${ran_int}]  ${RowGroupName}
    END
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[4]/span/span[1]/span
    Click Element   xpath=//*[@id="select2-TYPE-results"]/li[1]

WH_007    #ตรวจสอบความถูกต้องของข้อมูลใน Data Grid
    [Arguments]  @{GridList}
    ${count}    Get Length     ${GridList}
    FOR   ${i}  IN RANGE   ${count}
        ${Grid}  Get Text  xpath=//*[@id="dtDetail"]/thead/tr/th[${i}+1]
        Should Be Equal As Strings  ${GridList}[${i}]  ${Grid}
        # Log to Console   ${Grid}
    END

WH_011    #กดปุ่ม Create New
    Click Element   xpath=//*[@id="Group2"]/div/div[1]/div/div[2]/a

WH_012    #Case: ไม่กรอกข้อมูลใดๆ
    [Arguments]  @{RequireList}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

WH_013    #Case: ไม่กรอกข้อมูล Warehouse ID
    [Arguments]  @{RequireList}
    #Warehouse Name
    ${RandomnumberPname}   Generate Random String   2   [NUMBERS]
    ${WH_Name}  Set Variable  ${WH_Name}${RandomnumberPname}
    Set Global Variable  ${WH_Name}
    Input Text   xpath=//*[@id="WAREHOUSENAME"]  ${WH_Name}
    #Company Code
    Click Element   xpath=//*[@id="COMPANYCODE"]/option[2]
    #Warehouse Type
    Click Element   xpath=//*[@id="TYPE"]/option[2]
    #VMI Profile
    Click Element   xpath=//*[@id="VMI"]/option[2]
    Click Element   id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    ${RandomnumberPname}   Generate Random String   2   [NUMBERS]
    ${WH_ID}  Set Variable  ${WH_ID}${RandomnumberPname}
    Set Global Variable  ${WH_ID}
    Input Text   xpath=//*[@id="WAREHOUSEID"]   ${WH_ID}

WH_014    #Case: ไม่กรอกข้อมูล Warehouse Name
    [Arguments]  @{RequireList}
    Input Text   xpath=//*[@id="WAREHOUSENAME"]    ${SPACE}
    Press Keys   xpath=//*[@id="WAREHOUSENAME"]    BACK_SPACE
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    Input Text     xpath=//*[@id="WAREHOUSENAME"]   ${WH_Name}

WH_015    #Case: ไม่กรอกข้อมูล Warehouse Code
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="COMPANYCODE"]/option[1]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="COMPANYCODE"]/option[2]


WH_016    #Case: ไม่กรอกข้อมูล Warehouse Type
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="TYPE"]/option[1]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="TYPE"]/option[2]


WH_017    #Case: Case: ไม่กรอกข้อมูล VMI Profile
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="VMI"]/option[1]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="VMI"]/option[2]

WH_018    #กรอกข้อมูลให้ครบทุก Field
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]

WH_020    #ค้นหาข้อมูลที่ต้องการ Edit
    Input Text   xpath=//*[@id="WAREHOUSEID"]   ${WH_ID}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//html/body/div[2]/div/section/div/div[3]/div/div/div/div[2]/div/div/div/div/table/tbody/tr/td[9]/div/div[1]/form/button 
    Switch Window   MAIN
    close Window
    Switch Window   Warehouse - ST  

WH_021    #Case: แก้ไขข้อมูล โดยลบข้อมูล Warehouse Name
    WH_014    Required!   Please enter "Warehouse Name"   OK

WH_022    #Case: แก้ไขข้อมูล โดยลบข้อมูล Warehouse Type
    WH_016    Required!   Please select "Warehouse Type"   OK

WH_023    #Case: แก้ไขข้อมูล โดยลบข้อมูล VMI Profile
    WH_017    Required!   Please select "VMI Profile"   OK

WH_024    #แก้ไขข้อมูลทุก Field
    WH_018    Completed   Update completed !   OK

WH_025    #เลือก Warehouse ที่ต้องการลบ
    Input Text   xpath=//*[@id="WAREHOUSEID"]   ${WH_ID}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//i[@class="fa fa-2x fa-remove"]

WH_026    #กดปุ่ม Cancel จาก Popup Confirmation Message
    [Arguments]  ${RequireList}
    ${message}   Handle Alert   action=DISMISS
    # Log to Console  ${message}
    Should Be Equal As Strings  ${RequireList}  ${message}

WH_027    #กดปุ่ม OK จาก Popup Confirmation Message
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
WH_001 Click เลือก Menu : Master data >> Distributor >> Warehouse
    Log in
    Click Warehouse
    WH_001    Company   Warehouse ID   Warehouse Name   Type

WH_002 ค้นหาข้อมูลทั้งหมด กดปุ่ม Search
    WH_002

WH_003 ค้นหาข้อมูลทั้งหมด Case: ค้นหาข้อมูลจาก Company 
    WH_003

WH_004 ค้นหาข้อมูลทั้งหมด Case: ค้นหาข้อมูลจาก Warehouse ID
    WH_004
    
WH_005 ค้นหาข้อมูลทั้งหมด Case: ค้นหาข้อมูลจาก Warehouse Name
    WH_005

WH_006 ค้นหาข้อมูลทั้งหมด Case: ค้นหาข้อมูลจาก Type
    WH_006

WH_007 ตรวจสอบความถูกต้องของข้อมูลใน Data Grid
    WH_007    Warehouse ID   Warehouse Name   Warehouse Type   Company Name   Branch   Ship To   Deliver Day   VMI Profile

WH_011 ตรวจสอบความถูกต้องของหน้าจอการเพิ่มข้อมูล กดปุ่ม Create New
    WH_011

WH_012 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูลใดๆ
    WH_012    Required!   Please enter "Warehouse ID"   Please enter "Warehouse Name"   Please select "Company Code"   Please select "Warehouse Type"   Please select "VMI Profile"   OK

WH_013 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Warehouse ID
    WH_013    Required!   Please enter "Warehouse ID"   OK

WH_014 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Warehouse Name
    WH_014    Required!   Please enter "Warehouse Name"   OK

WH_015 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Company Code
    WH_015    Required!   Please select "Company Code"   OK

WH_016 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Warehouse Type
    WH_016    Required!   Please select "Warehouse Type"   OK

WH_017 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล VMI Profile
    WH_017    Required!   Please select "VMI Profile"   OK

WH_018 กรอกข้อมูลให้ครบทุก Field กดปุ่ม Save
    WH_018    Completed   Create completed !   OK

WH_020 ค้นหาข้อมูลที่ต้องการ Edit
    WH_020

WH_021 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล Warehouse Name
    WH_021    

WH_022 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล Warehouse Type
    WH_022

WH_023 ลบข้อมูลที่เป็น Require Field Case: แก้ไขข้อมูล โดยลบข้อมูล VMI Profile
    WH_023

WH_024 แก้ไขข้อมูลทุก Field
    WH_024

WH_025 เลือก Warehouse ที่ต้องการลบ
    WH_025

WH_026 ลบข้อมูล Warehouse กดปุ่ม Cancel จาก Popup Confirmation Message
    WH_026    Confirm delete ?

WH_027 ลบข้อมูล Warehouse กดปุ่ม OK จาก Popup Confirmation Message
    WH_027    Completed   Delete completed !   OK
    Close Browser
