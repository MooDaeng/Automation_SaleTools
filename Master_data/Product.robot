*** Settings ***
Resource                  ../Keyword/Main.robot

*** Variables ***
${P_code}          T0
${P_name}          PRODUCT_
${UOM1}            CAR
${UOM1_Name}       ลัง
${Conversion1}     2

*** Keywords ***
Click Product
    Click Element   xpath=//*[@id="menu"]/li[12]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[2]/a
    Click Element   xpath=//*[@id="menu"]/li[12]/ul/li[2]/ul/li[1]/a
    # ${gettext}  Get Text  xpath=//*[@id="mainContainer"]/div[1]/div/div/h3
    # Should Be Equal As Strings   ${gettext}   Product

PRO_001 
    [Arguments]  @{INDEX}
    ${count}  Get Length   ${INDEX}
    FOR  ${i}   IN RANGE   ${count}
        ${Gettext}  Get Text   xpath=//*[@id="collapse1"]/form/div/div[${i}+1]/b
        Should Be Equal As Strings   ${INDEX}[${i}]   ${Gettext}
    END

PRO_002      # Search ทั้งหมด
    Click Element   xpath=//*[@id="btnSearch"]
    ${entries}     Get Text       xpath=//*[@id="tblShowData_info"]
    @{entrie}   Split String   ${entries}   ${SPACE}
    ${ran_int1}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${ran_int2}    Evaluate    random.randint(1, ${entrie}[3])    random
    ${Product_Code}  Get Text  xpath=//*[@id="tblShowData"]/tbody/tr[${ran_int1}]/td[6]/a
    ${Product_name}  Get Text  xpath=//*[@id="tblShowData"]/tbody/tr[${ran_int2}]/td[7]
    Set Global Variable  ${Product_Code}
    Set Global Variable  ${Product_Name}
 
PRO_003 - PRO_007       # Search Group, Brand, Flavour, Var, Size
    FOR  ${i}  IN RANGE   0  5
        Click Element   xpath=//*[@id="collapse1"]/form/div/div[${i}+1]/span/span[1]/span
        ${GroupName}  Get Text       xpath=//html/body/span/span/span[2]
        @{values}   Split String   ${GroupName}  \n
        ${count}  Get Length  ${values}
        ${ran_int}    Evaluate    random.randint(1, ${count}-1)    random
        Click Element   xpath=//li[contains(text(),'${values}[${ran_int}]')]
        @{splittext}   Split String   ${values}[${ran_int}]  :${SPACE}
        Click Element   xpath=//*[@id="btnSearch"]
        ${entries}     Get Text      xpath= //*[@id="tblShowData_info"]
        @{entrie}   Split String   ${entries}   ${SPACE}
        FOR   ${j}   IN RANGE  0  ${entrie}[3]
            ${RowGroupName}  Get Text  xpath=//*[@id="tblShowData"]/tbody/tr[${j}+1]/td[${i}+1]
            Should Be Equal As Strings  ${splittext}[1]  ${RowGroupName}
        END
        Click Element   xpath=//*[@id="collapse1"]/form/div/div[9]/button[2]/i
    END

PRO_008 - PRO_009      # ค้นหาข้อมูลจาก Active Status, Sales Item
    FOR  ${i}  IN RANGE   5  7
        Click Element   xpath=//*[@id="collapse1"]/form/div/div[${i}+1]/span/span[1]/span
        ${getFeildName}  Get Text     xpath=//*[@id="collapse1"]/form/div/div[${i}+1]/b
        ${GroupName}     Get Text     xpath=//html/body/span/span/span[2]
        @{values}   Split String   ${GroupName}  \n
        ${count}  Get Length  ${values}
        ${ran_int}    Evaluate    random.randint(1, ${count}-1)    random
        Click Element   xpath=//li[contains(text(),'${values}[${ran_int}]')]    
        Click Element   xpath=//*[@id="btnSearch"]
        ${entries}     Get Text      xpath= //*[@id="tblShowData_info"]
        @{entrie}   Split String   ${entries}   ${SPACE}
        # Log to Console   ${getFeildName}
        IF   "${getFeildName}" == "Active Status"
            FOR   ${j}   IN RANGE  0  ${entrie}[3]
                ${RowGroupName}  Get Text  xpath=//*[@id="tblShowData"]/tbody/tr[${j}+1]/td[${i}+4]
                Should Be Equal As Strings  ${values}[${ran_int}]  ${RowGroupName}
                # Log to Console  Status:${RowGroupName}
            END
        ELSE
            FOR   ${j}   IN RANGE  0  ${entrie}[3]
                ${RowGroupName}  Get Text  xpath=//*[@id="tblShowData"]/tbody/tr[${j}+1]/td[${i}+2]
                Should Be Equal As Strings  ${values}[${ran_int}]  ${RowGroupName}
                # Log to Console  Status:${RowGroupName}
            END
        END
        Click Element   xpath=//*[@id="collapse1"]/form/div/div[9]/button[2]/i
    END
                    
PRO_010            # ค้นหาข้อมูลจาก Code/Name Product
    Input Text   xpath=//*[@id="txtP_code"]   ${Product_Code}
    Click Element   xpath=//*[@id="btnSearch"]
    ${CheckP_Code}  Get Text  xpath=//*[@id="tblShowData"]/tbody/tr[1]/td[6]/a
    Should Be Equal As Strings  ${CheckP_Code}  ${Product_Code}
    Input Text   xpath=//*[@id="txtP_code"]   ${Product_Name}
    Click Element   xpath=//*[@id="btnSearch"]
    ${CheckP_name}  Get Text  xpath=//*[@id="tblShowData"]/tbody/tr[1]/td[7]
    Should Be Equal As Strings  ${CheckP_Name}  ${Product_Name}

PRO_011
    Click Element   xpath=//*[@id="collapse1"]/form/div/div[9]/button[2]/i

PRO_012
    [Arguments]  @{GridList}
    ${count}    Get Length     ${GridList}
    FOR   ${i}  IN RANGE   ${count}
        ${Grid}  Get Text  xpath=//*[@id="tblShowData"]/thead/tr/th[${i}+1]
        Should Be Equal As Strings  ${GridList}[${i}]  ${Grid}
    END

# PRO_013

PRO_016
    Click Element   xpath=//*[@id="Group2"]/div/div[1]/div/div[2]/a
    
PRO_017
    [Arguments]  @{RequireList}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

PRO_018     #ไม่กรอก Code
    [Arguments]  @{RequireList}
    ${RandomnumberPname}   Generate Random String   2   [NUMBERS]
    ${P_name}  Set Variable  ${P_name}${RandomnumberPname}
    Set Global Variable  ${P_name}
    Input Text   id=PRODUCTNAME   ${P_name}
    Input Text   id=UNIT1   ${UOM1}
    Input Text   id=UNIT1NAME   ${UOM1_Name}
    Input Text   id=UNIT2RATE   ${Conversion1}
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    ${RandomnumberPcode}   Generate Random String   3   [NUMBERS]
    ${P_code}   Set Variable   ${P_code}${RandomnumberPcode}
    Set Global Variable   ${P_code}
    Input Text   id=P_Code   ${P_code}

PRO_019      #ไม่กรอก name
    [Arguments]  @{RequireList}
    Input Text   id=PRODUCTNAME   ${SPACE}
    Press Keys   id=PRODUCTNAME  BACK_SPACE
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

PRO_020        #ไม่กรอก UOM1
    [Arguments]  @{RequireList}
    Input Text   id=PRODUCTNAME   ${P_Name}
    Input Text   id=UNIT1   ${SPACE}
    Press Keys   id=UNIT1  BACK_SPACE
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

PRO_021         #ไม่กรอก UOM1 Name
    [Arguments]  @{RequireList}
    Input Text   id=UNIT1   ${UOM1}
    Input Text   id=UNIT1NAME   ${SPACE}
    Press Keys   id=UNIT1NAME   BACK_SPACE
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

PRO_022            #ไม่กรอก Conversion1
    [Arguments]  @{RequireList}
    Input Text   id=UNIT1NAME   ${UOM1_Name}
    Press Keys   id=UNIT2RATE   BACK_SPACE
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]
    Input Text   id=UNIT2RATE   ${Conversion1}

PRO_024          #กรอกข้อมูลครบทุก Field
    [Arguments]  @{RequireList}
    Click Element   //*[@id="collapse1"]/div[3]/div[2]/div/div/div[1]/img
    # Wait Until Element is Enabled   name=picture1    60
    Choose File    name=picture1   ${CURDIR}/4qyiu1.jpg
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

PRO_026
    Input Text   xpath=//*[@id="txtP_code"]   ${P_code}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//*[@id="tblShowData"]/tbody/tr/td[10]/form/button
    Switch Window   MAIN
    close Window
    Switch Window   Product - ST

PRO_028 - PRO_032
    [Arguments]  @{RequireList}
    PRO_019    Required!  Please enter "Name"  OK
    PRO_020    Required!  Please enter "UOM1"  OK
    PRO_021    Required!  Please enter "UOM1 Name"  OK
    PRO_022    Required!  Please enter "Conversion1"  OK
    Click Element  id=btnSubmit
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

PRO_033
    Input Text   xpath=//*[@id="txtP_code"]   ${P_code}
    Click Element   xpath=//*[@id="btnSearch"]
    Click Element   xpath=//*[@id="tblShowData"]/tbody/tr/td[11]/form/button

PRO_034
    [Arguments]  ${RequireList}
    ${message}   Handle Alert   action=DISMISS
    # Log to Console  ${message}
    Should Be Equal As Strings  ${RequireList}  ${message}

PRO_035
    [Arguments]  @{RequireList}
    Click Element   xpath=//*[@id="tblShowData"]/tbody/tr/td[11]/form/button
    ${message}   Handle Alert
    ${Required}   Get Text   xpath=//html/body/div[3]/div
    @{splittext}   Split String   ${Required}  \n
    # Log to Console  ${splittext}
    ${count}  Get Length   ${splittext}
    FOR   ${i}   IN RANGE   0  ${count}
        Should Be Equal As Strings  ${RequireList}[${i}]  ${splittext}[${i}]
    END
    Click Element  xpath=//html/body/div[3]/div/div[3]/button[1]

Create Product
    
    # FOR   ${i}  IN RANGE   52  101
    # Click Element   xpath=//*[@id="Group2"]/div/div[1]/div/div[2]/a
        # IF   ${i} <= 9
        #     Input Text   //*[@id="P_Code"]   ${productcode}0${i}
        #     Input Text   //*[@id="PRODUCTNAME"]    ${productname}0${i}
        #     Input Text   //*[@id="UNIT1"]     ${UOM1}
        #     Input Text   //*[@id="UNIT1NAME"]    ${UOM1_Name}
        #     Input Text   //*[@id="UNIT2RATE"]    ${Conversion1}
        #     Input Text   //*[@id="UNIT2"]     ${UOM2}
        #     Input Text   //*[@id="UNIT2NAME"]    ${UOM1_Name2}
        #     Input Text   //*[@id="UNIT1RATE"]    ${Conversion2}
        #     Input Text   //*[@id="PRICE1"]    255
        #     Click Element   xpath=//*[@id="ddlP_GroupCode"]/option[2]
        #     Click Element   xpath=//*[@id="ddlP_BrandCode"]/option[32]
        #     Click Element   xpath=//*[@id="ddlP_FlavourCode"]/option[11]
        #     Click Element   xpath=//*[@id="ddlP_VarCode"]/option[3]
        #     Click Element   //*[@id="ActiveStatus"]/option[2]
        #     Click Element   //*[@id="btnSubmit"]
        # Log to Console   ${productcode}0${i}
        # ELSE
            # Input Text   //*[@id="P_Code"]   TP0100
            # Input Text   //*[@id="PRODUCTNAME"]    TPro0100
            # Input Text   //*[@id="UNIT1"]     ${UOM1}
            # Input Text   //*[@id="UNIT1NAME"]    ${UOM1_Name}
            # Input Text   //*[@id="UNIT2RATE"]    ${Conversion1}
            # Input Text   //*[@id="UNIT2"]     ${UOM2}
            # Input Text   //*[@id="UNIT2NAME"]    ${UOM1_Name2}
            # Input Text   //*[@id="UNIT1RATE"]    ${Conversion2}
            # Input Text   //*[@id="PRICE1"]    255
            # Click Element   xpath=//*[@id="ddlP_GroupCode"]/option[2]
            # Click Element   xpath=//*[@id="ddlP_BrandCode"]/option[32]
            # Click Element   xpath=//*[@id="ddlP_FlavourCode"]/option[11]
            # Click Element   xpath=//*[@id="ddlP_VarCode"]/option[3]
            # Click Element   //*[@id="ActiveStatus"]/option[2]
            # Click Element   //*[@id="btnSubmit"]
        # Log to Console   ${productcode}${i}
        # END
        # Click Element    //html/body/div[3]/div/div[3]/button[1] 
    # END

# DChain
#     FOR  ${i}  IN RANGE    10   82
#     Click Element   xpath=//*[@id="collapse1"]/form/div/div[6]/span/span[1]/span
#     Click Element   xpath=//li[contains(text(),'Active')]    
#     Click Element   xpath=//*[@id="btnSearch"]
#     Click Element   //*[@id="tblShowData_length"]/label/select/option[4]
#     Click Element   //*[@id="tblShowData"]/tbody/tr[${i}]/td[6]/a
#     Switch Window   MAIN
#     close Window
#     Switch Window   Product - ST
#     ${CodeOld}  Get Element Attribute    //*[@id="P_Code"]    value
#     Input Text  //*[@id="Dchain"]   TP00${i}
#     ${Dchain}  Get Element Attribute    //*[@id="Dchain"]    value
#     Click Element   //*[@id="btnSubmit"]
#     Log to Console   ${i}. Code: ${CodeOld} Dchain: ${Dchain}
#     Click Element    //html/body/div[3]/div/div[3]/button[1] 
#     # Log to Console  ${i}
#     END



*** Test Cases ***
PRO_001 ตรวจสอบความถูกต้องของหน้าจอการค้นหาข้อมูล
    Log in
    Click Product
    PRO_001    Group   Brand   Flavour  Var   Size   Active Status   Sales Item   Code/Name Product
    
PRO_002 ค้นหาข้อมูลทั้งหมด กดปุ่ม Search
    PRO_002

PRO_003 - PRO_007 ค้นหาโดยระบุเงื่อนไข ค้นหาข้อมูลจาก Group, Brand, Flavour, Var, Size
    PRO_003 - PRO_007

PRO_008 - PRO_009 ค้นหาโดยระบุเงื่อนไข ค้นหาข้อมูลจาก Active Status, Sales Item
    PRO_008 - PRO_009

PRO_010 ค้นหาโดยระบุเงื่อนไข ค้นหาข้อมูลจาก Code/Name Product
    PRO_010

PRO_011 ล้างข้อมูลที่ค้นหาทั้งหมด กดปุ่ม Clear
    PRO_011

PRO_012 ตรวจสอบความถูกต้องของข้อมูลใน Data Grid
    PRO_012    Group  Brand  Flavour  Var  Size  Code  Name  Sales Item  Status  

# PRO_013, 14, 15

PRO_016 ตรวจสอบความถูกต้องของหน้าจอการเพิ่มข้อมูล กดปุ่ม Create New
    PRO_016

PRO_017 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูลใดๆ
    PRO_017     Required!  Please enter "Code"  Please enter "Name"  Please enter "UOM1"  Please enter "UOM1 Name"  Please enter "Conversion1"  OK

PRO_018 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Code
    PRO_018       Required!  Please enter "Code"  OK

PRO_019 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Name
    PRO_019       Required!  Please enter "Name"  OK

PRO_020 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล UOM1
    PRO_020       Required!  Please enter "UOM1"  OK

PRO_021 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล UOM1 Name
    PRO_021       Required!  Please enter "UOM1 Name"  OK

PRO_022 กรอกข้อมูลที่เป็น Require Fields ไม่ครบ Case: ไม่กรอกข้อมูล Conversion1
    PRO_022       Required!  Please enter "Conversion1"  OK

PRO_024 กรอกข้อมูลให้ครบทุก Field
    PRO_024       Completed  Create completed !  OK

# PRO_025 

PRO_026 ตรวจสอบความถูกต้องของหน้าจอการแก้ไขข้อมูล
    PRO_026

PRO_027 - PRO_032 ลบข้อมูลที่เป็น Require Field
    PRO_028 - PRO_032   Completed  Update completed !  OK

PRO_033 ลบข้อมูล Company
    PRO_033

PRO_034
    PRO_034    Confirm delete ?

PRO_035
    PRO_035    Completed   Delete completed !   OK
    Close Browser
    
    