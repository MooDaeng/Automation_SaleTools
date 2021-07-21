*** Settings ***
Library                   Selenium2Library
Library                   String
Library                   Collections
Library                   DateTime
Library                   BuiltIn

*** Variables ***
${url}        
${browser}    Chrome
${username}   
${password}   

*** Keywords ***
Log in
    Open Browser   ${url}   ${browser}
    Maximize Browser Window
    Set Selenium Speed   0.3
    Wait Until Element Is Visible   id=Username   timeout=20s
    Input Text   id=Username   ${username}
    Wait Until Element Is Visible   id=Password   timeout=20s
    Input Password   id=Password   ${password}
    Click Button  xpath=//*[@id="loginForm1"]/div[3]/div/button