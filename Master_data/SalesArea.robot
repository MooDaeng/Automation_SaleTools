*** Settings ***
Resource            ../Keyword/Main.robot

*** Variables ***

*** Keywords ***
Click x    #Click เลือก Menu : Master data >> Distributor >> Company

*** Test Cases ***
1
    Log in
    Click x