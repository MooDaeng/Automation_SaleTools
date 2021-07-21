*** Settings ***
Resource            ../Keyword/Main.robot

*** Variables ***
${DC_Code}           ABC_
${DC_SName}          ABC
${DC_Name}           TEST_DISTRIBUTOR_
 
*** Keywords ***
Click Distributor
    Click Element   xpath=//*[@id="menu"]/li[12]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[3]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[3]/ul/li[2]/a
    ${gettext}  Get Text  xpath=//*[@id="mainContainer"]/div[1]/div/div/h3
    Should Be Equal As Strings   ${gettext}   Distributor

DC_001    #ค้นหาข้อมูลทั้งหมด
    [Arguments]  @{INDEX}
    ${count}  Get Length  ${INDEX}
    FOR  ${i}   IN RANGE   ${count}-1
         ${Gettext}  Get Text   xpath=//*[@id="collapse1"]/form/div[1]/div[${i}+1]/b
         Should Be Equal As Strings   ${INDEX}[${i}]   ${Gettext}
    END
        ${Gettext2}  Get Text   xpath=//*[@id="collapse1"]/form/div[2]/div[1]/b
        Should Be Equal As Strings   ${INDEX}[4]   ${Gettext2}

DC_002    #ค้นหาข้อมูลทั้งหมด
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text       xpath=//*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    ${ran_int1}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${ran_int2}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${Distributor_Code}  Get Text   xpath=//*[@id="dtDetail"]/tbody/tr[${ran_int1}]/td[3]
    ${Distributor_name}  Get Text   xpath=//*[@id="dtDetail"]/tbody/tr[${ran_int2}]/td[5]
    Set Global Variable  ${Distributor_Code}
    Set Global Variable  ${Distributor_Name}

DC_003    #ค้นหาข้อมูลจาก Company
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
        ${RowGroupName}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[${i}+1]/td[1]
        Should Be Equal As Strings  ${values}[${ran_int}]  ${RowGroupName}
    END
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[1]/span/span[1]/span
    Click Element   xpath=//*[@id="select2-COMPANYCODE-results"]/li[1]

DC_004    #ค้นหาข้อมูลจาก Region
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[2]/span/span[1]/span
    ${GroupName}  Get Text       xpath=//*[@id="select2-AreaCode-results"]
    @{values}   Split String   ${GroupName}  \n
    Log to Console  ${values}
    ${count}  Get Length  ${values}
    ${ran_int}    Evaluate    random.randint(1, ${count}-1)    random
    Log to Console  ${ran_int}
    Click Element   xpath=//li[contains(text(),'${values}[${ran_int}]')]  #คลิกตำแหน่งที่ 4
    ${status}   Get Text   xpath=//html/body/div[2]/div/section/div/div[2]/div/div/div/div[2]/form/div[1]/div[2]/span/span[1]/span/span[1]
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text      xpath= //*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    FOR   ${i}   IN RANGE   ${entrie}[3]
        ${RowGroupName}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[${i}+1]/td[2]
        Should Be Equal As Strings  ${status}  ${RowGroupName}
    END
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[2]/span/span[1]/span
    Click Element   xpath=//*[@id="select2-AreaCode-results"]/li[1]

DC_005    #ค้นหาข้อมูลจาก Code/Name
    Input Text   xpath=//*[@id="collapse1"]/form/div[1]/div[3]/input   ${Distributor_Code}
    Click Element   xpath=//*[@id="btnSearch"]
    ${CheckDC_Code}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[1]/td[3]
    Should Be Equal As Strings  ${CheckDC_Code}  ${Distributor_Code}
    Input Text   xpath=//*[@id="collapse1"]/form/div[1]/div[3]/input   ${Distributor_Name}
    Click Element   xpath=//*[@id="btnSearch"]
    ${CheckDC_name}  Get Text  xpath=//*[@id="dtDetail"]/tbody/tr[1]/td[5]
    Should Be Equal As Strings  ${CheckDC_Name}  ${Distributor_Name}
    Input Text   xpath=//*[@id="collapse1"]/form/div[1]/div[3]/input   ${SPACE}
    Press Keys   xpath=//*[@id="collapse1"]/form/div[1]/div[3]/input   BACK_SPACE

DC_006    #ค้นหาข้อมูลจาก Check Credit
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[4]/span/span[1]/span
    ${GroupName}  Get Text       xpath=//html/body/span/span/span[2]
    @{values}   Split String   ${GroupName}  \n
    # ${count}  Get Length  ${values}
    Click Element   xpath=//li[contains(text(),'Pending')]
    ${status}   Get Text   xpath=//html/body/div[2]/div/section/div/div[2]/div/div/div/div[2]/form/div[1]/div[4]/span/span[1]/span/span[1]
    # Log to Console     ${status}
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text      xpath= //*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    FOR   ${i}   IN RANGE   ${entrie}[3]
            Click Element     xpath=//*[@id="dtDetail"]/tbody/tr[${i}+1]/td[1]
            ${RowGroupName}   Get Text   //*[@id="dtDetail"]/tbody/tr[${i}+2]/td/ul
            @{SplitRowGropName}   Split String   ${RowGroupName}   \n
            ${SplitRowGropName2}    Split String    ${SplitRowGropName}[1]
            # Log to Console   ${RowGroupName}
            # Log to Console   ${SplitRowGropNmae}
            Should Be Equal As Strings    ${Status}   ${SplitRowGropName2}[2]
            Click Element     xpath=//*[@id="dtDetail"]/tbody/tr[${i}+1]/td[1]
    END
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[4]/span/span[1]/span
    Click Element   xpath=//li[contains(text(),'-- All --')]
    
DC_007    #ค้นหาข้อมูลจาก Active Status
    Click Element   xpath=//*[@id="collapse1"]/form/div[2]/div[1]/span/span[1]/span
    ${GroupName}  Get Text       xpath=//html/body/span/span/span[2]
    @{values}   Split String   ${GroupName}  \n
    # ${count}  Get Length  ${values}
    Click Element   xpath=//li[contains(text(),'Active')]
    ${status}   Get Text   xpath=//html/body/div[2]/div/section/div/div[2]/div/div/div/div[2]/form/div[2]/div[1]/span/span[1]/span/span[1]
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text      xpath= //*[@id="dtDetail_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    FOR   ${i}   IN RANGE   ${entrie}[3]
            Click Element     xpath=//*[@id="dtDetail"]/tbody/tr[${i}+1]/td[1]
            ${RowGroupName}   Get Text   //*[@id="dtDetail"]/tbody/tr[${i}+2]/td/ul
            @{SplitRowGropName}   Split String   ${RowGroupName}   \n
            ${SplitRowGropName2}    Split String    ${SplitRowGropName}[2]
            # Log to Console   ${RowGroupName}
            # Log to Console   ${SplitRowGropName}
            # Log to Console   ${SplitRowGropName2}[2]
            Should Be Equal As Strings   ${status}   ${SplitRowGropName2}[2]
            Click Element     xpath=//*[@id="dtDetail"]/tbody/tr[${i}+1]/td[1]
    END
    Click Element   xpath=//*[@id="collapse1"]/form/div[1]/div[4]/span/span[1]/span
    Click Element   xpath=//li[contains(text(),'-- All --')]

DC_008    #ตรวจสอบความถูกต้องของข้อมูลใน Data Grid
    [Arguments]  @{GridList}
    ${count}    Get Length     ${GridList}
    FOR   ${i}  IN RANGE   ${count}
        ${Grid}  Get Text  xpath=//*[@id="dtDetail"]/thead/tr/th[${i}+1]
        Should Be Equal As Strings  ${GridList}[${i}]  ${Grid}
        # Log to Console   ${Grid}
    END

DC_012    #กดปุ่ม Create New
    Click Element   xpath=//*[@id="Group2"]/div/div[1]/div/div[2]/a

DC_013    #Case: ไม่กรอกข้อมูลใดๆ
    [Arguments]  @{RequireList}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

DC_014    #Case: ไม่กรอกข้อมูล Company Code
    [Arguments]  @{RequireList}
    #Distributor Code
    ${RandomnumberPname}   Generate Random String   2   [NUMBERS]
    ${DC_Code}  Set Variable  ${DC_Code}${RandomnumberPname}
    Set Global Variable  ${DC_Code}
    Input Text   xpath=//*[@id="SaleUnit"]   ${DC_Code}
    #Distributor Short Name
    Input Text   xpath=//*[@id="DIST_SHORTNAME"]   ${DC_SName}
    #Distributor Name
    ${RandomnumberPname}   Generate Random String   2   [NUMBERS]
    ${DC_Name}  Set Variable  ${DC_Name}${RandomnumberPname}
    Set Global Variable  ${DC_Name}
    Input Text   xpath=//*[@id="DIST_NAME"]   ${DC_Name}
    #Area Code
    Click Element   xpath=//*[@id="AreaCode"]/option[2]
    #Check Credit
    Click Element   xpath=//*[@id="CheckCredit"]/option[2]
    #Active Status
    Click Element   xpath=//*[@id="ActiveStatus"]/option[3]
    #Calculate Type
    Click Element   xpath=//*[@id="Optional10"]/option[2]
    #Sync History
    Click Element   xpath=//*[@id="SyncHistory"]/option[3]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="COMPANYCODE"]/option[2]

DC_015    #Case: ไม่กรอกข้อมูล Distributor Code
    [Arguments]  @{RequireList}
    Input Text   xpath=//*[@id="SaleUnit"]    ${SPACE}
    Press Keys   xpath=//*[@id="SaleUnit"]    BACK_SPACE
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    Input Text     xpath=//*[@id="SaleUnit"]   ${DC_Code}

DC_016    #Case: ไม่กรอกข้อมูล Distributor Short name
    [Arguments]  @{RequireList}
    Input Text   xpath=//*[@id="DIST_SHORTNAME"]    ${SPACE}
    Press Keys   xpath=//*[@id="DIST_SHORTNAME"]    BACK_SPACE
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    Input Text     xpath=//*[@id="DIST_SHORTNAME"]   ${DC_SName}

DC_017    #Case: ไม่กรอกข้อมูล Distributor name
    [Arguments]  @{RequireList}
    Input Text   xpath=//*[@id="DIST_NAME"]    ${SPACE}
    Press Keys   xpath=//*[@id="DIST_NAME"]    BACK_SPACE
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    Input Text     xpath=//*[@id="DIST_NAME"]   ${DC_Name}

DC_018    #Case: ไม่กรอกข้อมูล Area Code
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="AreaCode"]/option[1]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="AreaCode"]/option[2]

DC_019    #Case: ไม่กรอกข้อมูล Check Credit
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="CheckCredit"]/option[1]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="CheckCredit"]/option[2]

DC_020    #Case: ไม่กรอกข้อมูล Active Status
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="ActiveStatus"]/option[1]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="ActiveStatus"]/option[3]

DC_021    #Case: ไม่กรอกข้อมูล Calculate Type
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="Optional10"]/option[1]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="Optional10"]/option[2]

DC_022    #Case: ไม่กรอกข้อมูล Sync History
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="SyncHistory"]/option[1]
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]
    Click Element   xpath=//*[@id="SyncHistory"]/option[3]

DC_023    #กรอกข้อมูลให้ครบทุก Field กดปุ่ม Save
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="btnSubmit"]
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element   xpath=//html/body/div[3]/div/div[3]/button[1]


DC_025    #ค้นหาข้อมูลที่ต้องการ Edit
    Input Text   xpath=//*[@id="collapse1"]/form/div[1]/div[3]/input   ${DC_Code}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//*[@id="dtDetail"]/tbody/tr[1]/td[1]
    Click Element   xpath=//html/body/div[2]/div/section/div/div[3]/div/div/div/div[2]/div/div/div/div/table/tbody/tr[2]/td/ul/li[4]/span[2]/div/div[1]/form

DC_026    #Case: แก้ไขข้อมูล โดยลบข้อมูลที่เป็น Require Field 
    [Arguments]   @{RequireList}
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

DC_027    #ลบข้อมูล Distributor Short name
    DC_016    Required!   Please enter "Distributor Short name"   OK

DC_028    #ลบข้อมูล Distributor Name
    DC_017    Required!   Please enter "Distributor Name"   OK

DC_029    #ลบข้อมูล Area Code
    DC_018    Required!   Please select "Area Code"   OK

DC_030    #ลบข้อมูล Check Credit
    DC_019    Required!   Please select "Check Credit"   OK

DC_031    #ลบข้อมูล Active Status
    DC_020    Required!   Please select "Active Status"   OK

DC_032    #ลบข้อมูล Calculate Type
    DC_021    Required!   Please select "Calculate Type"   OK

DC_033    #ลบข้อมูล Sync History (Month)
    DC_022    Required!   Please select "Sync History (Month)"   OK
       
DC_034    #กดปุ่ม Save
    DC_023    Completed   Update completed !   OK

DC_035    #เลือก Distributor ที่ต้องการลบ
    Input Text   xpath=//*[@id="collapse1"]/form/div[1]/div[3]/input   ${DC_Code}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//*[@id="dtDetail"]/tbody/tr[1]/td[1]
    Click Element   xpath=//html/body/div[2]/div/section/div/div[3]/div/div/div/div[2]/div/div/div/div/table/tbody/tr[2]/td/ul/li[4]/span[2]/div/div[2]/form

DC_036    #กดปุ่ม Cancel จาก Popup Confirmation Message
    [Arguments]  ${RequireList}
    ${message}   Handle Alert   action=DISMISS
    # Log to Console  ${message}
    Should Be Equal As Strings  ${RequireList}  ${message}

DC_037    #กดปุ่ม OK จาก Popup Confirmation Message
    [Arguments]  @{RequireList}
    Click Element   xpath=//html/body/div[2]/div/section/div/div[3]/div/div/div/div[2]/div/div/div/div/table/tbody/tr[2]/td/ul/li[4]/span[2]/div/div[2]/form
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
DC_001 Click เลือก Menu : Master data >> Distributor >> Distributor
    Log in
    Click Distributor
    DC_001    Company   Region   Code/Name   Check Credit   Active Status

DC_002 ค้นหาข้อมูลทั้งหมด
    DC_002

DC_003 ค้นหาข้อมูลโดยระบุเงื่อนไข Case: ค้นหาข้อมูลจาก Company
    DC_003

DC_004 ค้นหาข้อมูลโดยระบุเงื่อนไข Case: ค้นหาข้อมูลจาก Region
    DC_004

DC_005 ค้นหาข้อมูลโดยระบุเงื่อนไข Case: ค้นหาข้อมูลจาก Code/Name
    DC_005

DC_006 ค้นหาข้อมูลโดยระบุเงื่อนไข Case: ค้นหาข้อมูลจาก Check Credit
    DC_006

DC_007 ค้นหาข้อมูลโดยระบุเงื่อนไข Case: ค้นหาข้อมูลจาก Check Credit
    DC_007

DC_008 ตรวจสอบความถูกต้องของข้อมูลใน Data Grid
    DC_008    Company Name   Region Name   Distributor Code   Distributor Short name   Distributor Name   Latitude   Longitude   Color    

DC_012 ตรวจสอบความถูกต้องของหน้าจอการเพิ่มข้อมูล กดปุ่ม Create New
    DC_012

DC_013 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูลใดๆ
    DC_013    Required!   Please select "Company Code"   Please enter "Distributor Code"   Please enter "Distributor Short name"   Please enter "Distributor Name"   Please select "Area Code"   Please select "Check Credit"   Please select "Active Status"   Please select "Calculate Type"   Please select "Sync History (Month)"   OK

DC_014 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Company Code
    DC_014    Required!   Please select "Company Code"   OK

DC_015 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Distributor Code
    DC_015    Required!   Please enter "Distributor Code"   OK

DC_016 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Distributor Short name
    DC_016    Required!   Please enter "Distributor Short name"   OK

DC_017 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Distributor Name
    DC_017    Required!   Please enter "Distributor Name"   OK

DC_018 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Area Code
    DC_018    Required!   Please select "Area Code"   OK

DC_019 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Check Credit
    DC_019    Required!   Please select "Check Credit"   OK

DC_020 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Active Status
    DC_020    Required!   Please select "Active Status"   OK

DC_021 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Calculate Type
    DC_021    Required!   Please select "Calculate Type"   OK

DC_022 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Sync History (Month)
    DC_022    Required!   Please select "Sync History (Month)"   OK

DC_023 กรอกข้อมูลให้ครบทุก Field กดปุ่ม Save
    DC_023    Completed   Create completed !   OK

DC_025 ค้นหาข้อมูลที่ต้องการ Edit
    DC_025

DC_026 ลบข้อมูลที่เป็น Require Field ลบข้อมูล Company Code
    DC_026    Required!   Please select "Company Code"   OK

DC_027 ลบข้อมูลที่เป็น Require Field ลบข้อมูล Distributor Short name
    DC_027

DC_028 ลบข้อมูลที่เป็น Require Field ลบข้อมูล Distributor Name
    DC_028

DC_029 ลบข้อมูลที่เป็น Require Field ลบข้อมูล Area Code
    DC_029

DC_030 ลบข้อมูลที่เป็น Require Field ลบข้อมูล Check Credit
    DC_030

DC_031 ลบข้อมูลที่เป็น Require Field ลบข้อมูล Active Status
    DC_031

DC_032 ลบข้อมูลที่เป็น Require Field ลบข้อมูล Calculate Type
    DC_032

DC_033 ลบข้อมูลที่เป็น Require Field ลบข้อมูล Sync History (Month)
    DC_033

DC_034 กดปุ่ม Save
    DC_034

DC_035
    DC_035
DC_036
    DC_036    Confirm delete ?
DC_037
    DC_037    Completed   Delete completed !   OK
    Close Browser