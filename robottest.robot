*** Settings ***
Library           Selenium2Library

*** Variable ***
${url}   
${browser}  Chrome
${username}     
${password}     

*** Keywords ***
Login
    Open Browser    ${url}   ${browser}
    Maximize Browser Window
    Set Selenium Speed      0.3
    Wait Until Element Is Visible   id=Username   timeout=20s
    Input Text     id=Username   ${username}
    Wait Until Element Is Visible   id=Password   timeout=20s
    Input Password   id=Password   ${password}
    Click Button  //*[@id="loginForm1"]/div[3]/div/button


    # --- switch window ---
    Click Element   //*[@id="menu"]/li[8]
    Click Element   //*[@id="menu"]/li[8]/ul/li[3]/a
    Switch Window   - ST
    close Window
    Switch Window   salestools 
    Reload Page
    ${message}   Handle Alert
    Log to Console  ${message}
    Click Element  //*[@id="ContentPlaceHolder1_ddlStore"]
    Click Element  //*[@id="ContentPlaceHolder1_ddlStore"]/option[1]
    Click Element  //*[@id="ContentPlaceHolder1_btnSearch"]
    
   



    # --- ใส่รูป ---
    # Click Button  //*[@id="loginForm1"]/div[3]/div/button
    # Click Element  //*[@id="menu"]/li[10]/a
    # Click Element  //*[@id="menu"]/li[10]/ul/li[2]/a
    # Click Element  //*[@id="menu"]/li[10]/ul/li[2]/ul/li[1]/a
    # Click Element  //*[@id="Group2"]/div/div[1]/div/div[2]
    # Input Text  id=P_Code  Pro001
    # Input Text  id=PRODUCTNAME  Test Promotion scotch
    # Click Element   //*[@id="collapse1"]/div[3]/div[2]/div/div/div[1]/img
    # Wait Until Element is Enabled   name=picture1    60
    # Choose File    name=picture1   ${CURDIR}/4qyiu1.jpg
    # Log to Console  ${CURDIR}

    

*** Test Case ***
1. Open Browsers
    Login
    



   
#     # Click Element  //*[@id="__next"]/div/div[2]/div[2]/div[3]/div[2]/select
#     # Click Element   //*[@id="__next"]/div/div[2]/div[2]/div[3]/div[2]/select/option[3]
#     # Press Keys   //*[@id="__next"]/div/div[2]/div[2]/div[1]/div   ARROW_UP

#     Click Element   //*[@id="formSearch"]/div[1]/div
#     Click Element   //*[@id="formSearch"]/div[1]/div/select/option[3]

#     Click Element   //*[@id="formSearch"]/div[10]/div/select
#     Click Element   //*[@id="formSearch"]/div[10]/div/select/option[5]

# Search single date
#     ${getnow}   Get Current Date    result_format=%d
#     Click Element   //*[@id="formSearch"]/div[5]/div/div[1]/div/input
#     Wait Until Element Is Visible   //*[@class="react-datepicker__day react-datepicker__day--0${getnow} react-datepicker__day--today"]
#     Click Element   //*[@class="react-datepicker__day react-datepicker__day--0${getnow} react-datepicker__day--today"]
#     Click Element   ${Search}

# test run keywords

#     Click Element   //*[@id="__next"]/div/div[2]/div[2]/div[3]/table/tbody/tr[1]
#     Click Element   //*[@id="__next"]/div/div[2]/div[2]/div[3]/div[1]/button
#     ${getDis}=  Get Element Attribute  //*[@id="bt-void-confirm"]  disabled
#     Log To Console  ${getDis}
#     Should Be Equal As Strings    ${getDis}   true
#     Input Text   //*[@id="txt-reason"]   dfhgkjfdhg
#     Input Text   //*[@id="txt-confirm"]   VOID ME

#     @{locators}=     Get Webelements    //*[@id="form-void"]/div[1]/div[1]
#     FOR   ${locator}   IN    @{locators}
#         ${name}=    Get Text    ${locator}
#         @{values}=   Split String   ${name}  \n
#         ${count}    Get Length  ${values}
#         Log To Console  ${values}
#         Should Be Equal As Strings    ${values}[0]   Transaction ID:
#         Should Be Equal As Strings    ${values}[1]   $Amount:
        
#     END

# xpath to click
#     [Arguments]   ${xpath}
#     Set Global Variable     ${xpath}

# click on field Dropdown
#     @{locators}=     Get Webelements    ${xpath}
#     FOR   ${locator}   IN    @{locators}
#         ${name}=    Get Text    ${locator}
#         @{values}=   Split String   ${name}  \n
#         ${count}    Get Length  ${values}
#     END
#     FOR  ${VALUE}  IN RANGE  0  4
#         ${ran_int}=    Evaluate    random.randint(0, ${count}-1)    random
#         Click Element   ${xpath}     # Wait Until Page Contains  ${VALUE}
#         Click Element   //*[contains(text(),'${values}[${ran_int}]')]
#         Click Element   ${Search}
#     END
#     Click Element   //*[contains(text(),'${values}[0]')]
#     Click Element   ${Search}

# click date
#      ${getnow}   Get Current Date    result_format=%d
#     Click Element   //*[@id="formSearch"]/div[5]/div/div[1]/div/input
#     Wait Until Element Is Visible   //*[@class="react-datepicker__day react-datepicker__day--0${getnow} react-datepicker__day--today"]
#     Click Element   //*[@class="react-datepicker__day react-datepicker__day--0${getnow} react-datepicker__day--today"]

# click on field 'All Merchant'
#     @{locators}=     Get Webelements    ${xpath}
#     FOR   ${locator}   IN    @{locators}
#         ${name}=    Get Text    ${locator}
#         @{values}=   Split String   ${name}  \n
#         ${count}    Get Length  ${values}
#     END
#     FOR  ${VALUE}  IN RANGE  0  4
#         ${ran_int}=    Evaluate    random.randint(0, ${count}-1)    random
#         Log To Console  ${ran_int}
#         Click Element   ${xpath}     # Wait Until Page Contains  ${VALUE}
#         Click Element   //*[contains(text(),'${values}[${ran_int}]')]
#         Click Element   //*[@id="__next"]/div/div[2]/div[2]/div[2]/div/button[2]
#     END
#     Click Element   //*[contains(text(),'${values}[0]')]
#     Click Element   //*[@id="__next"]/div/div[2]/div[2]/div[2]/div/button[2]

# Search text field
#     [Arguments]  @{VALUE}   
#     FOR  ${INDEX}  IN  @{VALUE}       
#     Click Element   ${xpath}               
#     Input Text   ${xpath}    ${INDEX}
#     Click Element   ${Search}
#     Press Keys    ${xpath}      BACK_SPACE
#     END

   
    
  
# Search field 'Transacrion ID'2
#     [Arguments]  ${VALUE2}     
#     Wait Until Element Is Visible   //*[@id="formSearch"]/div[3]/div/input   timeout=20s
#     Click Element   //*[@id="formSearch"]/div[3]/div/input            
#     ${TransID}=  Get Element Attribute    //*[@id="formSearch"]/div[3]/div/input     placeholder          
#     Input Text   //*[@placeholder="${TransID}"]    ${VALUE2}
#     Click Element   ${Search}
#     Log To Console  ${TransID}
#     Clear Element Text  //*[@id="formSearch"]/div[3]/div/input 


# Random
#     ${ran_int}=    Evaluate    random.randint(0, 9)    random
#     Log To Console     This is a random number between 0 and 9: ${ran_int}



# xpath to click
#     [Arguments]   ${xpath}
#     Set Global Variable     ${xpath}

# click on field 'All Payment Type'2
#     [Arguments]  @{INDEX}
#     @{locators}=     Get Webelements    ${xpath}
#     FOR   ${locator}   IN    @{locators}
#         ${name}=    Get Text    ${locator}
#         @{value}=   Split String   ${name}  \n
#         Should Be Equal As Strings   ${INDEX}    ${value}
#     END
#     FOR  ${VALUE}  IN  @{INDEX}
#         Click Element   //*[@id="formSearch"]/div[1]/div/select     # Wait Until Page Contains  ${VALUE}
#         Click Element   //*[contains(text(),'${VALUE}')]
#         Click Element   //*[@id="__next"]/div/div[2]/div[2]/div[2]/div/button[2]
#     END
#     Click Element   //*[contains(text(),'${INDEX}[0]')]
#     Click Element   //*[@id="__next"]/div/div[2]/div[2]/div[2]/div/button[2]





    # @{locators}=     Get Webelements    //*[@id="formSearch"]/div[1]/div/select
    # FOR   ${locator}   IN    @{locators}
    #        ${name}=    Get Text    ${locator}
    #     #    ${result}    Create List   ${name}
    #        @{output}=   Split String   ${name}  \n
    #        Log To Console   \n@{output}
    # END




#แปลง cahractors เป็น String
    # ${HG} =  Set Variable   Nodename ransdate ICC Support FAX Detection Trunk Group Number Bill Trunk Group Number MGW Name Trunk Group Name Sub-Route Name Circuit Type Group Direction Circuit Selection Mode
    #     @{words} =  Split String    ${HG}  
    #     ${HGLenght}=      Get length  ${words}
    #      log to Console  ${words}[1]

    
    # FOR     ${ELEMENT}   IN      @{TEST}
    # Log To Console     \n${ELEMENT}
    # END

    # Click Element      //*[@id="formSearch"]/div[2]/div/input      Transaction ID or Order ID
    
    

    # Element Should Be Visible  //*[@id="formSearch"]/div[2]/div/input 
    # Click Element   //*[@id="formSearch"]/div[2]/div/input
    # ${place}=  Get Element Attribute    //*[@id="sidebar"]/nav/li[2]  placeholder


    # Should Be Equal As Strings      ${place}        Transaction ID or Order ID
     


# Search single date mon-fri
#     ${getnow}   Get Current Date   result_format=%d
#     Click Element   //*[@id="formSearch"]/div[5]/div/div[1]/div/input
#     Wait Until Element Is Visible   //*[@class="react-datepicker__day react-datepicker__day--0${getnow} react-datepicker__day--today"]
#     Click Element   //*[@class="react-datepicker__day react-datepicker__day--0${getnow} react-datepicker__day--today"]
#                   # //*[@class="react-datepicker__day react-datepicker__day--013 react-datepicker__day--selected react-datepicker__day--today react-datepicker__day--weekend"]
#     Click Element   ${Search}

# Search single date sat-sun
#     ${getnow}   Get Current Date   result_format=%d
#     Click Element   //*[@id="formSearch"]/div[5]/div/div[1]/div/input
#     Wait Until Element Is Visible   //*[@class="react-datepicker__day react-datepicker__day--014 react-datepicker__day--weekend"]
#     Click Element   //*[@class="react-datepicker__day react-datepicker__day--014 react-datepicker__day--weekend"]

#     # Wait Until Element Is Visible   //*[@class="react-datepicker__day react-datepicker__day--014 react-datepicker__day--selected react-datepicker__day--today react-datepicker__day--weekend"]
#     # Click Element   //*[@class="react-datepicker__day react-datepicker__day--014 react-datepicker__day--selected react-datepicker__day--today react-datepicker__day--weekend"]
#                   # //*[@class="react-datepicker__day react-datepicker__day--013 react-datepicker__day--selected react-datepicker__day--today react-datepicker__day--weekend"]
#     Click Element   ${Search}

# Search single date
#     @{getday}   Create List   Mon  Tue  Wed  Thu  Fri  Sat  Sun
#     ${ran_int}   Evaluate   random.randint(0, 6)   random
#     # ${getday}   Get Current Date   result_format=%a
#     Log To Console  ${getday}[${ran_int}]
#     Run Keyword If    '${getday}[${ran_int}]'== 'Sat' or '${getday}[${ran_int}]'== 'Sun'  Search single date sat-sun
#     ...         ELSE  Search single date mon-fri
    
    
#     Search single date
# 1. test
#     test run keywords
#      xpath to click    //*[@id="formSearch"]/div[5]/div/div[1]/div/input
#     click on field Dropdown
    
# # 2.
#       xpath to click    //*[@id="formSearch"]/div[3]/div/input
#       Search text field    0388675541
# 3.
#     xpath to click    //*[@id="formSearch"]/div[7]/div/input
#     Search text field    0  00  000  0002

