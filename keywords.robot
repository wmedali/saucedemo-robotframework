*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Se connecter
    [Arguments]    ${username}    ${password}
    Input Text    data:test:username    ${username}
    Input Password    data:test:password    ${password}
    Click Button    data:test:login-button
